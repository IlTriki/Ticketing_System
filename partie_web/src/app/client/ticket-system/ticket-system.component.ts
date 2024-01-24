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
  selector: 'app-ticket-system',
  templateUrl: './ticket-system.component.html',
  styleUrls: ['./ticket-system.component.scss']
})
export class TicketSystemComponent implements OnInit {
  tickets: Ticket[] = [];
  searchTerm: string = '';
  selectedTab: 'all' | 'open' | 'doing' |'closed' = 'open';


  constructor(private http: HttpClient) { }
  ngOnInit() {
    this.getTickets();
  }

  statuses = [
    {value: 'Ouverts', label: 'Ouverts', selected: false},
    {value: 'En cours', label: 'En Cours', selected: false},
    {value: 'Terminés', label: 'Terminés', selected: false}
  ];

  priorities = [
    {value: 'Rouge', label: 'Elevé', selected : false},
    {value: 'Orange', label: 'Moyenne', selected : false},
    {value: 'Vert', label: 'Terminés', selected : false},
  ]


get filteredTickets() {
  let filteredTickets = this.tickets;

  if (this.searchTerm) {
    filteredTickets = filteredTickets.filter(ticket => ticket.Probleme.includes(this.searchTerm));
  }

  const selectedStatuses = this.statuses.filter(status => status.selected).map(status => status.value);
  if (selectedStatuses.length > 0) {
    filteredTickets = filteredTickets.filter(ticket => selectedStatuses.includes(ticket.EtatTicket));
  }

  const selectedPriority = this.priorities.filter(prio => prio.selected).map(prio => prio.value);
  if (selectedPriority.length > 0) {
    filteredTickets = filteredTickets.filter(ticket => selectedPriority.includes(ticket.Priority));
  }

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
    this.http.get<Ticket[]>('your_url:port/tickets').subscribe(data => {
      this.tickets = data;
    });
  }
}