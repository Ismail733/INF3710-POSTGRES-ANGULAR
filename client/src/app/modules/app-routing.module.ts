import { NgModule } from "@angular/core";
import { RouterModule, Routes } from "@angular/router";

import { AppComponent } from "../app.component";
import { PlanRepasComponent } from "../plan-repas/plan-repas.component";

const routes: Routes = [
  { path: "app", component: AppComponent, },
  { path: "plan-repas", component: PlanRepasComponent, }
];

@NgModule({
  imports: [ RouterModule.forRoot(routes) ],
  exports: [ RouterModule ]
})
export class AppRoutingModule { }
