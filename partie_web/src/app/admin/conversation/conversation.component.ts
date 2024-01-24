import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { HttpClient } from '@angular/common/http';
import { Location } from '@angular/common';
import { environment } from 'src/environments/environments';

interface Name {
  "@odata.context": string;
  displayName: string;
}

@Component({
  selector: 'app-conversation',
  templateUrl: './conversation.component.html',
  styleUrls: ['./conversation.component.scss']
})
export class ConversationComponent implements OnInit {
  ticketId: string = "";
  messages: {sender: string, text: string}[] = [];
  newMessage: string = '';
  identity: Name = {
    "@odata.context": "",
    displayName: ""
  };
  

  constructor(private route: ActivatedRoute, private http: HttpClient, private location: Location) { }

  ngOnInit(): void {
    this.http.get(environment.apiConfig.uri + "?$select=displayName", { responseType: 'json' }).subscribe(
      (name:any) => {
        this.identity = name;
      }
    )

    this.route.params.subscribe(params => {
      this.ticketId = params['id'];
      this.http.get<{sender: string, text: string}[]>(`your_url:port/conversation/${this.ticketId}`).subscribe(messages => {
        this.messages = messages;
      });
    });
  }
  
  sendMessage(): void {
    this.messages.push({sender: this.identity.displayName, text: this.newMessage});
    this.http.post(`your_url:port/conversation/${this.ticketId}`, {sender: this.identity.displayName, text: this.newMessage}).subscribe(() => {
      this.newMessage = '';
    });
  }

  goBack(): void {
    this.location.back();
  }
}