import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { AdminRoutingModule } from './admin-routing.module';
import { AdminComponent } from './admin.component';
import { MenuModule } from './menu/menu.module';
import { TicketSystemComponent } from './ticket-system/ticket-system.component';
import { MessagerieComponent } from './messagerie/messagerie.component';
import { FormsModule } from '@angular/forms';
import { CalendrierModule } from './calendrier/calendrier.module';
import { EditTicketComponent } from './edit-ticket/edit-ticket.component';

@NgModule({
  declarations: [
    AdminComponent,
    TicketSystemComponent,
    MessagerieComponent,
    EditTicketComponent,

  ],
  imports: [
    CommonModule,
    AdminRoutingModule,
    MenuModule,
    FormsModule,
    CalendrierModule
  ]
})
export class AdminModule { }

