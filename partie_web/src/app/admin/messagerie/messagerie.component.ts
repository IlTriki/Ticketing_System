import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';

interface Ticket {
  Id: number;
  DateCreation: string;
  IdClient: number;
  Probleme: string;
  description: string;
  IdMaterielle: number;
  EtatTicket: string;
  Priority:string;
}

@Component({
  selector: 'app-messagerie',
  templateUrl: './messagerie.component.html',
  styleUrls: ['./messagerie.component.scss']
})
export class MessagerieComponent implements OnInit {
  tickets: Ticket[] = [];
  selectedTab: 'all' | 'open' | 'doing' |'closed' = 'all';


  constructor(private http: HttpClient) { }
  ngOnInit() {
    this.getTickets();
  }
  get filteredTickets() {
    let filteredTickets = this.tickets;
    if (this.selectedTab !== 'all') {
      filteredTickets = filteredTickets.filter(ticket => this.mapTabToStatus(this.selectedTab) === ticket.EtatTicket);
    }
  
    return filteredTickets;
  }

  mapTabToStatus(tab: 'all' | 'open' | 'doing' | 'closed'): string {
    switch (tab) {
      case 'open':
        return 'Ouverts';
      case 'doing':
        return 'En cours';
      case 'closed':
        return 'Terminés';
      default:
        return '';
    }
  }
  
    getTickets() {
      this.http.get<Ticket[]>('http://100.74.7.89:3000/tickets').subscribe(data => {
        this.tickets = data;
      });
    }
  }