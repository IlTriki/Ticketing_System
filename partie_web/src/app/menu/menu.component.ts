import { Component } from '@angular/core';
import { AuthService } from '../auth.service';

@Component({
  selector: 'app-menu',
  templateUrl: './menu.component.html',
  styleUrl: './menu.component.scss',
})
export class MenuComponent {
  menuOpen = false; // Variable pour suivre l'état du menu

  constructor(private authService: AuthService) {}

  toggleMenu() {
    this.menuOpen = !this.menuOpen; // Change l'état du menu lorsqu'on clique sur le bouton
  }

  logout() {
    this.authService.logout();
  }
}
