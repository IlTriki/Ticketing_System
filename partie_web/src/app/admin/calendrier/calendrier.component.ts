import { Component, OnInit } from '@angular/core';
import { CalendarEvent , CalendarMonthViewDay} from 'angular-calendar';
import { HttpClient } from '@angular/common/http';
import { CdkDragDrop, moveItemInArray } from '@angular/cdk/drag-drop'; 

interface Ticket {
  DateRdv: string;
  description: string;
}

@Component({
  selector: 'app-calendrier',
  templateUrl: './calendrier.component.html',
  styleUrls: ['./calendrier.component.scss']
})
export class CalendrierComponent implements OnInit {
  events: CalendarEvent[] = [];
  nordvs: any[] = [];
  viewDate: Date = new Date();
  selectedDate?: Date;

  constructor(private http: HttpClient) {}
  
  ngOnInit(): void {
    this.http.get<Ticket[]>('http://100.74.7.89:3000/rdv').subscribe(tickets => {
      this.events = [];
      for (let ticket of tickets) {
        let date = new Date(ticket.DateRdv);
        let localDate = new Date(date.getTime() - date.getTimezoneOffset() * 60000);
        console.log(localDate);
        this.events.push({
          start: localDate,
          title: ticket.description
        });
      }
    });
    this.http.get<any[]>('http://100.74.7.89:3000/nordv').subscribe(nordvs => {
      this.nordvs = nordvs;
    });
  }
  
  dragMoved(day: CalendarMonthViewDay): void {
    console.log('day:', day);
    console.log('day.date:', day.date);
    this.selectedDate = day.date;
  }

  drop(event: CdkDragDrop<string[]>) {
    console.log('Début du drop', event);
    
    moveItemInArray(this.nordvs, event.previousIndex, event.currentIndex);
    
    if (!this.selectedDate) {
      console.log('Aucune date sélectionnée');
      return;
    }
    
    let newRdv = {
      DateRdv: this.selectedDate.toISOString(), 
      description: this.nordvs[event.currentIndex].Probleme
    };
    
    this.http.post('http://100.74.7.89:3000/rdv', newRdv).subscribe(
      response => {
        console.log('Réponse du serveur', response);
        this.selectedDate = undefined; // Réinitialisez la date sélectionnée après le drop
      },
      error => console.log('Erreur lors de la requête POST', error)
    );
  }
}