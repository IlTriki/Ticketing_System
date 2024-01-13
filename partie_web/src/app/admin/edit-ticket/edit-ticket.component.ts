import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { HttpClient } from '@angular/common/http';

interface Ticket {
  Id: number;
  DateCreation: string;
  IdClient: number;
  Probleme: string;
  description: string;
  IdMaterielle: number;
  EtatTicket: string;
  Priority: string;
}

@Component({
  selector: 'app-edit-ticket',
  templateUrl: './edit-ticket.component.html',
  styleUrls: ['./edit-ticket.component.scss']
})
export class EditTicketComponent implements OnInit {
  ticketId: number | null = null;
  ticket: Ticket | null = null;

  constructor(private route: ActivatedRoute, private http: HttpClient, private router: Router) { }

  ngOnInit() {
    let id = this.route.snapshot.paramMap.get('id');
    this.ticketId = id ? +id : null;
    if (this.ticketId !== null) {
      this.getTicket();
    }
  }

  getTicket() {
    if (this.ticketId !== null) {
      this.http.get<Ticket>(`http://100.74.7.89:3000/tickets/${this.ticketId}`).subscribe(data => {
        this.ticket = data;
      });
    }
  }

  updateTicket() {
    if (this.ticketId !== null && this.ticket !== null) {
      this.http.put(`http://100.74.7.89:3000/tickets/${this.ticketId}`, this.ticket).subscribe(() => {
        alert('Ticket mis à jour avec succès');
        this.router.navigate(['/ticket-system']);
      });
    }
  }
}