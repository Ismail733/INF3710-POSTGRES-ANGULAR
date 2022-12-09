import { HttpClient } from "@angular/common/http";
import { Injectable } from "@angular/core";
import {  catchError, Observable, of, Subject } from "rxjs";
import { PlanRepas } from "../interfaces/interface-plan-repas";

@Injectable()
export class CommunicationService {
  // À DÉCOMMENTER ET À UTILISER LORSQUE VOTRE COMMUNICATION EST IMPLÉMENTÉE
  private readonly BASE_URL: string = "http://localhost:3000/database";
  public constructor(private readonly http: HttpClient) {}

  private _listeners: any = new Subject<any>();

  listen(): Observable<any> {
    return this._listeners.asObservable();
  }

  filter(filterBy: string): void {
    this._listeners.next(filterBy);
  }


  public postPlanRepas(planRepas  :PlanRepas) : Observable<void>{
    return this.http.post<void>(this.BASE_URL + "/planRepas", planRepas).pipe(catchError(this.handleError<void>('postPlanRepas')));
  }

  public getAllPlanRepas() : Observable<PlanRepas[]>{
    return this.http.get<PlanRepas[]>(this.BASE_URL + "/planRepas").pipe(catchError(this.handleError<PlanRepas[]>('getAllPlanRepas')));
  }
  public getAllNbFournisseur() : Observable<number[]>{
    return this.http.get<number[]>(this.BASE_URL + "/numero-Fournisseur").pipe(catchError(this.handleError<number[]>('getAllNbFournisseur')));
  }
  public insertPlanRepas(planRepas  :PlanRepas) : Observable<number>{
    return this.http.post<number>(this.BASE_URL + "/planRepas", planRepas).pipe(catchError(this.handleError<number>('insertPlanRepas')));
  }
  public updatePlanRepas(planRepas  :PlanRepas) : Observable<number>{
    return this.http.put<number>(this.BASE_URL + "/planRepas", planRepas).pipe(catchError(this.handleError<number>('updatePlanRepas')));
  }

  public deletePlanRepas(planRepas  :PlanRepas) : Observable<number>{
    return this.http.delete<number>(this.BASE_URL + `/planRepas/${planRepas.numeroplan}`).pipe(catchError(this.handleError<number>('deletePlanRepas')));
  }
  // À DÉCOMMENTER ET À UTILISER LORSQUE VOTRE COMMUNICATION EST IMPLÉMENTÉE
  private handleError<T>(
    request: string,
    result?: T
  ): (error: Error) => Observable<T> {
    return (error: Error): Observable<T> => {
      return of(result as T);
    };
  }
}