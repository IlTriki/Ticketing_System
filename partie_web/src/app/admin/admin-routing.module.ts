import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AdminComponent } from './admin.component';
import { MessagerieComponent } from './messagerie/messagerie.component';
import { ConversationComponent } from './conversation/conversation.component';
import { EditTicketComponent } from './edit-ticket/edit-ticket.component';

const routes: Routes = [
  { path: '', component: AdminComponent },
  { path: 'messagerie', component: MessagerieComponent},
  { path: 'conversation/:id', component: ConversationComponent },
  { path: 'edit-ticket/:id', component: EditTicketComponent },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class AdminRoutingModule { }