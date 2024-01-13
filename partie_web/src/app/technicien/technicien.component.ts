import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Router } from '@angular/router';
import { environment } from 'src/environments/environments';
import { MsalService } from '@azure/msal-angular';
import {MatButtonModule} from '@angular/material/button';
import {MatDividerModule} from '@angular/material/divider';
import {MatToolbarModule} from '@angular/material/toolbar';

@Component({
  selector: 'app-technicien',
  templateUrl: './technicien.component.html',
  styleUrls: ['./technicien.component.scss'],
  standalone: true,
  imports:[MatButtonModule, MatDividerModule, MatToolbarModule]
})
export class TechnicienComponent /*implements OnInit*/{
  id="";
  nom="";
  prenom="";

  constructor(
    private http: HttpClient,
    private router:Router,
    private authService:MsalService
  ) { }
  
  ngOnInit(): void {
    
    this.http.get(environment.apiConfig.uri + "\\appRoleAssignments", { responseType: 'json' }).subscribe(
      (rolesParApp:any) => {
        rolesParApp.value.map((app:any) => {
          this.id =  app.appRoleId;
          if(this.id != "817ed289-d44f-41b9-a8b9-b334728ae4d2"){
            this.router.navigate([""]);
          }
        })
      }
    )
  }
  

  logout(){
    this.authService.logoutRedirect()
  }
}

