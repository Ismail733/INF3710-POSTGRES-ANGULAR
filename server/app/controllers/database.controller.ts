import { inject, injectable } from "inversify";
import { NextFunction, Request, Response, Router } from "express";
import * as pg from "pg";
import { DatabaseService } from "../services/database.service";
import Types from "../types";
import { PlanRepas } from "../table/interface-plan-repas";

@injectable()
export class DatabaseController {
  public constructor(
    // @ts-ignore -- À ENLEVER LORSQUE L'IMPLÉMENTATION EST TERMINÉE
    @inject(Types.DatabaseService) private readonly databaseService: DatabaseService
  ) {}

  public get router(): Router {
    const router: Router = Router();
    router.get("/planRepas", (req: Request, res: Response, _: NextFunction) => {
  
        this.databaseService
        .getAllPlanRepas()
        .then((result: pg.QueryResult) => {
          const planRepas: PlanRepas[] = result.rows.map((planRepas: PlanRepas) => ({
            numeroplan: planRepas.numeroplan,
            categorie: planRepas.categorie,
            frequence: planRepas.frequence,
            nbrcalories: planRepas.nbrcalories,
            nbrpersonnes: planRepas.nbrpersonnes,
            prix: planRepas.prix,
            numerofournisseur: planRepas.numerofournisseur,
  
          } as PlanRepas));
          res.json(planRepas);
        })
        .catch((e: Error) => {
          console.error(e.stack);
        });
      });
    router.get("/numero-fournisseur", (req: Request, res: Response, _: NextFunction) => {
  
        this.databaseService
        .getAllNbFournisseur()
        .then((result: pg.QueryResult) => {
          const fournisseurs: number[] = result.rows.map((numerofournisseur: {numerofournisseur: number}) => 
          numerofournisseur.numerofournisseur
          );
          res.json(fournisseurs);
        })
        .catch((e: Error) => {
          console.error(e.stack);
        });
      });

      router.post("/planRepas", (req: Request, res: Response, _: NextFunction) => {
        const planRepas: PlanRepas = {
          categorie: req.body.categorie,
          frequence: req.body.frequence,
          nbrcalories: req.body.nbrcalories,
          nbrpersonnes: req.body.nbrpersonnes,
          prix: req.body.prix,
          numerofournisseur: req.body.numerofournisseur,
        }as PlanRepas;
        this.databaseService
          .addPlanRepas(planRepas)
          .then((result: pg.QueryResult) => {
            res.json(result.rowCount);
          })
          .catch((e: Error) => {
            console.error(e.stack);
            res.json(-1);
          });
      })
      router.put("/planRepas", (req: Request, res: Response, _: NextFunction) => {
        const planRepas: PlanRepas = {
          numeroplan: req.body.numeroplan,
          categorie: req.body.categorie,
          frequence: req.body.frequence,
          nbrcalories: req.body.nbrcalories,
          nbrpersonnes: req.body.nbrpersonnes,
          prix: req.body.prix,
          numerofournisseur: req.body.numerofournisseur,
        }as PlanRepas;
        this.databaseService
          .updatePlanRepas(planRepas)
          .then((result: pg.QueryResult) => {
            res.json(result.rowCount);
          })
          .catch((e: Error) => {
            console.error(e.stack);
            res.json(-1);
          });
      })

      router.delete("/planRepas/:numeroPlan", (req: Request, res: Response, _: NextFunction) => {
        this.databaseService
          .deletePlanRepas(parseInt(req.params.numeroPlan))
          .then((result: pg.QueryResult) => {
            res.json(result.rowCount);
          })
          .catch((e: Error) => {
            console.error(e.stack);
            res.json(-1);
          });
      })
      return router;
    };


}