import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { AdminRoutingModule } from './client-routing.module';
import { ClientComponent } from './client.component';
import { MenuModule } from './menu/menu.module';
import { TicketSystemComponent } from './ticket-system/ticket-system.component';
import { MessagerieComponent } from './messagerie/messagerie.component';
import { FormsModule } from '@angular/forms';
import { EquipementsComponent } from './equipements/equipements.component';


@NgModule({
  declarations: [
    ClientComponent,
    TicketSystemComponent,
    MessagerieComponent,
    EquipementsComponent,

  ],
  imports: [
    CommonModule,
    AdminRoutingModule,
    MenuModule,
    FormsModule
  ]
})
export class ClientModule { }

