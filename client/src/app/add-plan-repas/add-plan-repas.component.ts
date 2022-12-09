import { Component, OnInit } from '@angular/core';
import { FormControl, Validators } from '@angular/forms';
import { PlanRepas } from '../interfaces/interface-plan-repas';
import { CommunicationService } from '../services/communication.service';

@Component({
  selector: 'app-add-plan-repas',
  templateUrl: './add-plan-repas.component.html',
  styleUrls: ['./add-plan-repas.component.css']
})
export class AddPlanRepasComponent implements OnInit {

  fournisseurs: number[];
  categorie = new FormControl('parmesan', [Validators.required, Validators.minLength(1)]);
  frequence = new FormControl(10, [Validators.required, Validators.min(0)]);
  nbrcalories = new FormControl(10, [Validators.required, Validators.min(0)]);
  nbrpersonnes = new FormControl(10, [Validators.required, Validators.min(0)]);
  //prix: number;
  prix = new FormControl(10, [Validators.required, Validators.min(0)]);

  numerofournisseur: number;
constructor(private communicationService: CommunicationService){ 
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

  addPlanRepas(): void {
    this.communicationService.insertPlanRepas({
      categorie: this.categorie.value,
      frequence: this.frequence.value,
      nbrcalories: this.nbrcalories.value,
      nbrpersonnes: this.nbrpersonnes.value,
      numerofournisseur: this.numerofournisseur,
      prix: this.prix.value,
      
    } as PlanRepas).subscribe((res :number)=> {
      if(res === -1){
        window.alert('Ce repas ne peut pas être ajouté')
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
