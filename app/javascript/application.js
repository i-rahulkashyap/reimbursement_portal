// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"
document.addEventListener('DOMContentLoaded', function() {
  setTimeout(function() {
    var alerts = document.querySelectorAll('.alert');
    alerts.forEach(function(alert) {
      var bsAlert = new bootstrap.Alert(alert);
      bsAlert.close();
    });
  }, 3000);
});


document.addEventListener('turbo:load', () => {
  const flashMessages = document.querySelectorAll('.alert');
  flashMessages.forEach((flash) => {
    setTimeout(() => {
      flash.style.display = 'none';
    }, 5000);
  });
});


document.addEventListener('DOMContentLoaded', function() {
  const hamburger = document.querySelector('.hamburger');
  const navLinks = document.querySelector('.nav-links');
  
  hamburger.addEventListener('click', function() {
    navLinks.classList.toggle('active');
  });
});