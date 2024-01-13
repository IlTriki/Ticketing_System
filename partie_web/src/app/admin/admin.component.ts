import { Component } from '@angular/core';
import { MenuService } from '../menu.service'; 
import { OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Router } from '@angular/router';
import { environment } from 'src/environments/environments';
import { MsalService } from '@azure/msal-angular';


@Component({
  selector: 'app-admin',
  templateUrl: './admin.component.html',
  styleUrls: ['./admin.component.scss']
})
export class AdminComponent implements OnInit {
  selectedMenu: 'tickets' | 'messagerie' | 'calendrier' = 'tickets';
  private id = "";
  constructor(
    private http: HttpClient,
    private router:Router,
    private authService:MsalService, 
    private menuService: MenuService) { }

  selectMenu(menu: 'tickets' | 'messagerie') {
    this.selectedMenu = menu;
    this.menuService.setSelectedMenu(menu);
  }

  ngOnInit(): void {
    this.http.get(environment.apiConfig.uri + "\\appRoleAssignments", { responseType: 'json' }).subscribe(
      (rolesParApp:any) => {
        rolesParApp.value.map((app:any) => {
          this.id =  app.appRoleId;
          if(this.id != "4d2c506e-393b-48f0-a1d5-071ec67a8f1a"){
            this.router.navigate([""]);
          }
        })
      }
    )
  }
}