import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { CalendrierComponent } from './calendrier.component';
import { CalendarModule, DateAdapter } from 'angular-calendar';
import { adapterFactory } from 'angular-calendar/date-adapters/date-fns';
import { registerLocaleData } from '@angular/common';
import localeFr from '@angular/common/locales/fr';
import { LOCALE_ID } from '@angular/core';
import { DragDropModule } from '@angular/cdk/drag-drop'; // Ajoutez cette ligne

registerLocaleData(localeFr);

@NgModule({
  declarations: [CalendrierComponent],
  imports: [
    CommonModule,
    CalendarModule.forRoot({ provide: DateAdapter, useFactory: adapterFactory }),
    DragDropModule // Ajoutez cette ligne
  ],
  providers: [
    { provide: LOCALE_ID, useValue: 'fr' }
  ],
  exports: [CalendrierComponent]
})
export class CalendrierModule { }