import { createRouter, createWebHistory } from 'vue-router'
import Classes from '../views/Classes.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'classes',
      component: Classes
    }
  ]
})

export default router
