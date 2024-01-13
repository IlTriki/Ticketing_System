import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { ClientComponent } from './client.component';
import { MessagerieComponent } from './messagerie/messagerie.component';
import { ConversationComponent } from './conversation/conversation.component';
import { EquipementsComponent } from './equipements/equipements.component';

const routes: Routes = [
  { path: '', component: ClientComponent },
  { path: 'messagerie', component: MessagerieComponent},
  { path: 'conversation/:id', component: ConversationComponent },
  { path: 'equipements', component: EquipementsComponent},

];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class AdminRoutingModule { }