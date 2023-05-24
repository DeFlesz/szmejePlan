// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

function updateTheme() {
    const theme = window.matchMedia(query).matches ? 'dark' : 'light'
    document.querySelector('html').setAttribute('data-bs-theme', theme)
}

updateTheme();

window.matchMedia(query).addEventListener('change', () => {
    updateTheme();
})
