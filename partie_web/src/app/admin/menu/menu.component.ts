import { Component ,Output, EventEmitter} from '@angular/core';
import { MenuService } from '../../menu.service';
import { MsalService } from '@azure/msal-angular';

@Component({
  selector: 'app-menu',
  templateUrl: './menu.component.html',
  styleUrls: ['./menu.component.scss'],
})
export class MenuComponent {
  menuOpen = false; // Variable pour suivre l'état du menu
  pageName = '';
  constructor(private authService: MsalService, private menuService: MenuService) {
    this.menuService.selectedMenu$.subscribe(menu => {
      switch(menu) {
        case 'tickets':
          this.pageName = 'Liste Tickets';
          break;
        case 'messagerie':
          this.pageName = 'Messagerie';
          break;
        case 'calendrier':
          this.pageName = 'Calendrier';
          break; 
        default:
          this.pageName = 'Accueil';
      }
    });
  }

  @Output() menuSelected = new EventEmitter<'tickets' | 'messagerie' | 'calendrier'>();
  
  selectMenu(menu: 'tickets' | 'messagerie' | 'calendrier') {
    this.menuSelected.emit(menu);
    this.menuService.setSelectedMenu(menu);
  }
  
  toggleMenu() {
    this.menuOpen = !this.menuOpen; // Change l'état du menu lorsqu'on clique sur le bouton
  }

  logout() {
    this.authService.logout();
  }
}