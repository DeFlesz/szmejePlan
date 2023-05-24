import './assets/main.css'

import "bootstrap/dist/css/bootstrap.min.css"
import "bootstrap"

import { createApp } from 'vue'
import App from './App.vue'
import router from './router'

const app = createApp(App)
const query = '(prefers-color-scheme: dark)'


function updateTheme() {
    const theme = window.matchMedia(query).matches ? 'dark' : 'light'
    document.querySelector('html').setAttribute('data-bs-theme', theme)
}

updateTheme();

window.matchMedia(query).addEventListener('change', () => {
    updateTheme();
})

app.use(router)

app.mount('#app')
