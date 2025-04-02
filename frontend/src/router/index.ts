import { createRouter, createWebHashHistory, RouteRecordRaw } from 'vue-router'
import HomeView from '../views/HomeView.vue' // Importa el menu

const routes: Array<RouteRecordRaw> = [
  {
    path: '/',
    name: 'home',
    component: HomeView
  },
  {
    path: '/about',
    name: 'about',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "about" */ '../views/AboutView.vue')
  },
  // usuario
  {
    path: '/User',
    name: 'User',
    component: () => import(/* webpackChunkName: "about" */ '../views/GestUser.vue')
  },
  // empresa
  {
    path: '/company',
    name: 'company',
    component: () => import(/* webpackChunkName: "about" */ '../views/GestEmpresas.vue')
  }

]

const router = createRouter({
  history: createWebHashHistory(),
  routes
})

export default router
