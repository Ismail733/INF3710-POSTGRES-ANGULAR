import { Component, ViewChild } from '@angular/core';
import { MatDialog, MatDialogConfig } from '@angular/material/dialog';
import { Sort } from '@angular/material/sort';
import { MatTable } from '@angular/material/table';
import { AddPlanRepasComponent } from '../add-plan-repas/add-plan-repas.component';
import { PlanRepas } from '../interfaces/interface-plan-repas';
import { CommunicationService } from '../services/communication.service';
import { UpdatePlanRepasComponent } from '../update-plan-repas/update-plan-repas.component';

@Component({
  selector: 'app-plan-repas',
  templateUrl: './plan-repas.component.html',
  styleUrls: ['./plan-repas.component.css']
})
export class PlanRepasComponent {

  planRepas: PlanRepas[];

  @ViewChild(MatTable) table: MatTable<any>;

  constructor(public dialog: MatDialog, private communicationService: CommunicationService) { }

  ngOnInit(): void {
    this.getAllPlanRepas();
    

  }

  getAllPlanRepas(){
    this.communicationService.getAllPlanRepas().subscribe((planRepasDB: PlanRepas[])=>{
      this.planRepas = planRepasDB? planRepasDB : [];
      this.doSort('desc');
    }
    )
  }


  sortData(sort: Sort): void {
    this.doSort(sort.direction);
    this.table.renderRows();

  }

  insertPlanRepas(): void{
    this.openAddDialog();
  }
  updatePlanRepas(planRepas: PlanRepas): void{
    this.openUpdateDialog(planRepas);
  }
  deletePlanRepas(planRepas: PlanRepas): void{
    this.communicationService.deletePlanRepas(planRepas).subscribe((res)=> {
      if(res === -1){
        window.alert('Ce repas ne peut pas être supprimé')
      }
      window.location.reload();});
  }

  private doSort(dir: string): void {
    switch(dir) {
      case 'asc':
        this.planRepas.sort((a: PlanRepas, b: PlanRepas) => a.numeroplan < b.numeroplan ? 1 : -1)
        break;
      default:
        this.planRepas.sort((a: PlanRepas, b: PlanRepas) => a.numeroplan < b.numeroplan ? -1 : 1)
      }
  }


  openAddDialog() {
    const dialogConfig = new MatDialogConfig();
    dialogConfig.disableClose = false;
    dialogConfig.autoFocus = true;
    dialogConfig.minWidth = '650px';
    this.dialog.open(AddPlanRepasComponent, dialogConfig);
  }
  openUpdateDialog(planRepas: PlanRepas) {
    const dialogConfig = new MatDialogConfig();
    dialogConfig.disableClose = false;
    dialogConfig.autoFocus = true;
    dialogConfig.minWidth = '650px';
    dialogConfig.data = planRepas;
    this.dialog.open(UpdatePlanRepasComponent, dialogConfig);
  }

}
