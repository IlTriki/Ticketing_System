import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class MenuService {
  private selectedMenuSubject = new BehaviorSubject<string>('');
  selectedMenu$ = this.selectedMenuSubject.asObservable();

  setSelectedMenu(menu: string) {
    this.selectedMenuSubject.next(menu);
  }
}