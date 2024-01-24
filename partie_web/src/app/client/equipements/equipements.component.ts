import { Component } from '@angular/core';
import { OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { HttpClient } from '@angular/common/http';


interface Equipements {
    Adresse: string;
    Lieu: string;
    DateInstallation: string;
    Connecte: number;
    DerniereMaintenance: string;
    Note:string;
    Nom:string;
  }

@Component({
    selector: 'app-equipements',
    templateUrl: './equipements.component.html',
    styleUrls: ['./equipements.component.scss']
})
export class EquipementsComponent implements OnInit{
    
    clientId = 1;
    private equipements: Equipements[] = [];

    constructor(private route: ActivatedRoute,  private http: HttpClient) { }

    
    ngOnInit(): void {
        this.route.params.subscribe(params => {
            this.clientId = params['id'];
            
            this.http.get<Equipements[]>(`your_url:port/materielleClient/${1}`).subscribe(equipement => {
                this.equipements = equipement;
                console.log(equipement)
                console.log(this.clientId)
            });
        });
        
    }

    
}
