import { Component, OnInit } from '@angular/core';
import { MsalBroadcastService, MsalService } from '@azure/msal-angular';
import {
  AuthenticationResult,
  EventMessage,
  EventType,
  InteractionStatus,
} from '@azure/msal-browser';
import { filter } from 'rxjs/operators';
import { Router } from '@angular/router';
import { HttpClient } from '@angular/common/http';
import { environment } from 'src/environments/environments';

@Component({
  selector: 'app-public',
  templateUrl: './public.component.html',
  styleUrls: ['./public.component.scss']
})
export class PublicComponent {
  id: string = "";


  constructor(
    private authService: MsalService,
    private msalBroadcastService: MsalBroadcastService,
    private router: Router,
    private http: HttpClient,
  ) {}

  ngOnInit(): void {
    this.msalBroadcastService.msalSubject$
      .pipe(
        filter((msg: EventMessage) => msg.eventType === EventType.LOGIN_SUCCESS)
      )
      .subscribe((result: EventMessage) => {
        const payload = result.payload as AuthenticationResult;
        this.authService.instance.setActiveAccount(payload.account);
      });

    
      this.authService.handleRedirectObservable().subscribe({
        next: (result: AuthenticationResult) => {
          this.http
            .get(environment.apiConfig.uri + '\\appRoleAssignments', {
              responseType: 'json',
            })
            .subscribe((rolesParApp: any) => {
              rolesParApp.value.map((app: any) => this.id = app.appRoleId);
              if (this.id == '817ed289-d44f-41b9-a8b9-b334728ae4d2') {
                //Technicien
                this.router.navigate(['technicien']);
              } else if (this.id =='4d2c506e-393b-48f0-a1d5-071ec67a8f1a') {
                //CallDesk
                this.router.navigate(['admin']);
              } else if (this.id =='69bc4d78-ee63-414f-a00b-724174266998') {
                //Client
                this.router.navigate(['client']);
              }
            });
        },
      });
      
  }
}
