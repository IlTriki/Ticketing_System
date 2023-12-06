import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Router } from '@angular/router';
import { tap } from 'rxjs/operators';

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  private apiUrl = 'http://100.74.7.89:3000'; 

  constructor(private http: HttpClient, private router: Router) { }

  login(username: string, password: string): Observable<any> {
    return this.http.post<any>(`${this.apiUrl}/login`, { login: username, mot_de_passe: password }).pipe(
      tap(response => {
        if (response.success) {
          localStorage.setItem('authToken', response.token);
        }
      })
    );
  }

  logout() {
    localStorage.removeItem('authToken');
    this.router.navigateByUrl('/login');
  }

  isLoggedIn(): boolean {
    return localStorage.getItem('authToken') !== null;
  }
}