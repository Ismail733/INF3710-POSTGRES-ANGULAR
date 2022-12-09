import { Component, Inject, OnInit } from '@angular/core';
import { PlanRepas } from '../interfaces/interface-plan-repas';
import { CommunicationService } from '../services/communication.service';
import {MAT_DIALOG_DATA} from '@angular/material/dialog';
import { FormControl, Validators } from '@angular/forms';


@Component({
  selector: 'app-update-plan-repas',
  templateUrl: './update-plan-repas.component.html',
  styleUrls: ['./update-plan-repas.component.css']
})
export class UpdatePlanRepasComponent implements OnInit {


  numeroplan: number;

  numerofournisseur: number;

  fournisseurs: number[];
  categorie = new FormControl('parmesan', [Validators.required, Validators.minLength(1)]);
  frequence = new FormControl(10, [Validators.required, Validators.min(0)]);
  nbrcalories = new FormControl(10, [Validators.required, Validators.min(0)]);
  nbrpersonnes = new FormControl(10, [Validators.required, Validators.min(0)]);
  //prix: number;
  prix = new FormControl(10, [Validators.required, Validators.min(0)]);


  
  constructor(private communicationService: CommunicationService,@Inject(MAT_DIALOG_DATA) public data : PlanRepas){ 
      this.numeroplan = this.data.numeroplan;
      this.categorie.setValue(this.data.categorie);
      this.frequence.setValue(this.data.frequence);
      this.nbrcalories.setValue(this.data.nbrcalories);
      this.nbrpersonnes.setValue(this.data.nbrpersonnes);
      this.numerofournisseur = this.data.numerofournisseur;
      this.prix.setValue(this.data.prix);
  }

  



  ngOnInit(): void {
    this.getAllNbFournisseur();
  }

  isValid(): boolean{
    if(!this.numerofournisseur){
      return false;
    }
    if(! this.categorie.value || this.categorie.value.trim().length <1 || this.categorie.value.length > 20){
      return false;
    }
    if((!this.frequence.value || this.frequence.value < 0)){
      return false;
    }
    if(!this.nbrpersonnes.value || this.nbrpersonnes.value < 0){
      return false;
    }
    if(!this.nbrcalories.value || this.nbrcalories.value < 0){
      return false;
    }
    if(!this.prix.value || this.prix.value < 0){
      return false;
    }
    return true;
  }

  updatePlanRepas(): void {
    this.communicationService.updatePlanRepas({
      numeroplan: this.numeroplan,
      categorie: this.categorie.value,
      frequence: this.frequence.value,
      nbrcalories: this.nbrcalories.value,
      nbrpersonnes: this.nbrpersonnes.value,
      numerofournisseur: this.numerofournisseur,
      prix: this.prix.value,
      
    } as PlanRepas).subscribe((res)=> {
      if(res === -1){
        window.alert('Ce repas ne peut pas être modifié')
      }
      window.location.reload();});
  }

  getAllNbFournisseur(){
    this.communicationService.getAllNbFournisseur().subscribe((nbFournisseurs: number[])=>{
      this.fournisseurs = nbFournisseurs? nbFournisseurs : [];
    }
    )
  }

}
