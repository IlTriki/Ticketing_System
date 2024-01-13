import { Component } from '@angular/core';
import { MenuService } from '../menu.service'; 
import { OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Router } from '@angular/router';
import { environment } from 'src/environments/environments';
import { MsalService } from '@azure/msal-angular';


@Component({
  selector: 'app-admin',
  templateUrl: './client.component.html',
  styleUrls: ['./client.component.scss']
})
export class ClientComponent implements OnInit {
  selectedMenu: 'tickets' | 'messagerie' | 'equipements' = 'tickets';
  private id = "";
  constructor(
    private http: HttpClient,
    private router:Router,
    private authService:MsalService, 
    private menuService: MenuService) { }

  selectMenu(menu: 'tickets' | 'messagerie' | 'equipements') {
    this.selectedMenu = menu;
    this.menuService.setSelectedMenu(menu);
  }

  ngOnInit(): void {
    this.http.get(environment.apiConfig.uri + "\\appRoleAssignments", { responseType: 'json' }).subscribe(
      (rolesParApp:any) => {
        rolesParApp.value.map((app:any) => {
          this.id =  app.appRoleId;
          if(this.id != "69bc4d78-ee63-414f-a00b-724174266998"){
            this.router.navigate([""]);
          }
        })
      }
    )
  }
}