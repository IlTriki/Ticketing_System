import { HttpClient } from '@angular/common/http';
import { Component } from '@angular/core';

@Component({
  selector: 'app-forgot-password',
  templateUrl: './forgot-password.component.html',
  styleUrls: ['./forgot-password.component.scss']
})
export class ForgotPasswordComponent {
  login: string = "";
  private apiUrl = 'http://100.74.7.89:3000'; 

  constructor(private http: HttpClient) {}

  submit() {
    this.http.post(`${this.apiUrl}/forgot-password`, { login: this.login }).subscribe(response => {
      console.log('Réponse du serveur :', response);
});
  }
}