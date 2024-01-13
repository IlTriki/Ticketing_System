import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { MsalGuard } from '@azure/msal-angular';
import { FailedLoginComponent } from './failed-login/failed-login.component';
import { TechnicienComponent } from './technicien/technicien.component';

const routes: Routes = [
  {
    path: '', 
    loadChildren:()=>import('./public/public.module').then(m=>m.PublicModule)
  },

  {
    path: 'admin', 
    loadChildren:()=>import('./admin/admin.module').then(m=>m.AdminModule), 
    canActivate: [MsalGuard]
  },
  {
    path: 'technicien', 
    component: TechnicienComponent,
    canActivate: [MsalGuard]
  },
  {
    path: 'client', 
    loadChildren:()=>import('./client/client.module').then(m=>m.ClientModule),
    canActivate: [MsalGuard]
  },
  
  {
    path:"failed-login",
    component: FailedLoginComponent
  },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
