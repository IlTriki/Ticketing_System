import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { AdminRoutingModule } from './admin-routing.module';
import { AdminComponent } from './admin.component';
import { MenuModule } from '../menu/menu.module';
import { TicketSystemComponent } from './ticket-system/ticket-system.component';

@NgModule({
  declarations: [
    AdminComponent,
    TicketSystemComponent
  ],
  imports: [
    CommonModule,
    AdminRoutingModule,
    MenuModule
  ]
})
export class AdminModule { }

