import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { AuthService } from '../auth.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent {
  form: FormGroup = this.fb.group({
    username: ['', Validators.required],
    password: ['', Validators.required]
  });

  constructor(private authService: AuthService, private fb: FormBuilder, private router: Router) { }

  login() {
    this.authService.login(this.form.value.username, this.form.value.password).subscribe(response => {
      if (response.success) {
        this.router.navigateByUrl('/admin');
      } else {
        alert(response.message);
      }
    });
  }
  forgotPassword() {
    this.router.navigateByUrl('/forgot-password');
  }
}