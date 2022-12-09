import { injectable } from "inversify";
import * as pg from "pg";
import "reflect-metadata";
import { PlanRepas } from "../table/interface-plan-repas";

@injectable()
export class DatabaseService {
  public connectionConfig: pg.ConnectionConfig = {
    user: "postgres",
    database: "DERNIER",
    password: "root",
    port: 5432,
    host: "127.0.0.1",
    keepAlive: true
  };

  public pool: pg.Pool = new pg.Pool(this.connectionConfig);

  // ======= PLANS REPAS =======
  async getAllPlanRepas(): Promise<pg.QueryResult> {
    const client = await this.pool.connect();
    const queryText: string = `SELECT * FROM Planrepas;`;
    const res = await client.query(queryText);
    client.release();
    return res;
  }

  async getPlanRepas(number: number): Promise<pg.QueryResult> {
    const client = await this.pool.connect();
    const queryText: string = `SELECT * FROM Planrepas WHERE numeroplan = ${number.toString()};`;
    const res = await client.query(queryText);
    client.release();
    return res;
  }
  async getAllNbFournisseur(): Promise<pg.QueryResult> {
    const client = await this.pool.connect();
    const queryText: string = `SELECT numerofournisseur FROM Fournisseur;`;
    const res = await client.query(queryText);
    client.release();
    return res;
  }

  public async addPlanRepas(planRepas: PlanRepas): Promise<pg.QueryResult> {
    const client = await this.pool.connect();

    if (!planRepas.categorie.length || 
        !planRepas.frequence.toString().length || planRepas.frequence < 1 ||
        !planRepas.nbrcalories.toString().length || planRepas.nbrcalories < 1 ||
        !planRepas.numerofournisseur.toString().length ||
        !planRepas.prix.toString().length || planRepas.prix <= 0) {
      throw new Error("Impossible d'ajouter le plan repas désiré.");
    }

    const values: (string | number)[] = [
      planRepas.categorie,
      planRepas.frequence,
      planRepas.nbrcalories,
      planRepas.nbrpersonnes,
      planRepas.prix,
      planRepas.numerofournisseur
    ];

    const queryText: string = `INSERT INTO PlanRepas (categorie, frequence, nbrcalories, nbrpersonnes, prix, numerofournisseur) VALUES($1, $2, $3, $4, $5, $6);`;
    const res = await client.query(queryText, values);
    client.release()
    return res;
  }

  public async updatePlanRepas(planRepas: PlanRepas): Promise<pg.QueryResult> {
    const client = await this.pool.connect();

    if (!planRepas.categorie.length || 
      !planRepas.frequence.toString().length || planRepas.frequence < 1 ||
      !planRepas.nbrcalories.toString().length || planRepas.nbrcalories < 1 ||
      !planRepas.numerofournisseur.toString().length ||
      !planRepas.prix.toString().length || planRepas.prix <= 0) {
      throw new Error("Impossible de modifier le plan repas désiré.");
    }
    
    const values: (string | number | undefined)[] = [
      planRepas.numeroplan,
      planRepas.categorie,
      planRepas.frequence,
      planRepas.nbrcalories,
      planRepas.nbrpersonnes,
      planRepas.prix,
      planRepas.numerofournisseur
    ];

    const queryText: string = `UPDATE PlanRepas SET categorie = $2, frequence = $3, nbrcalories = $4, nbrpersonnes = $5, prix = $6, numerofournisseur = $7 WHERE numeroplan = $1;`;
    const res = await client.query(queryText, values);
    client.release();
    return res;
  }

  public async deletePlanRepas(numeroplan: number): Promise<pg.QueryResult> {
    const client = await this.pool.connect();
    if (!numeroplan) {
      throw new Error("Impossible de supprimer le plan repas désiré.");
    }

    const queryText: string = `DELETE FROM Planrepas WHERE numeroplan = $1;`;
    const res = await client.query(queryText, [numeroplan]);
    client.release()
    return res;
  }
}