import { createRouter, createWebHashHistory, RouteRecordRaw } from 'vue-router'
import HomeView from '../views/LoginSystem.vue' // Importa el menu

const routes: Array<RouteRecordRaw> = [
  // Inicio de Sesion prueba
  {
    path: '/',
    name: 'home',
    component: HomeView
  },
  // Menu Principal
  {
    path: '/menu',
    name: 'menu',
    component: () => import(/* webpackChunkName: "about" */ '../views/MainMenu.vue')
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
    component: () => import(/* webpackChunkName: "about" */ '../views/GestCompany.vue')
  },
  // Cambiar Contraseña
  {
    path: '/changePass',
    name: 'changePass',
    component: () => import(/* webpackChunkName: "about" */ '../components/ChangePassword.vue')
  },
  // seguridad
  {
    path: '/security',
    name: 'security',
    component: () => import(/* webpackChunkName: "about" */ '../components/AccessValidation.vue')
  },
  // proveedores
  {
    path: '/proveedor',
    name: 'proveedor',
    component: () => import(/* webpackChunkName: "about" */ '../views/GestProveedor.vue')
  },
  // clientes
  {
    path: '/client',
    name: 'client',
    component: () => import(/* webpackChunkName: "about" */ '../views/GestClient.vue')
  },
  // Plan de Cuentas
  {
    path: '/account',
    name: 'account',
    component: () => import(/* webpackChunkName: "about" */ '../views/PlanAccounts.vue')
  },
  // Perfil
  {
    path: '/profile',
    name: 'profile',
    component: () => import(/* webpackChunkName: "about" */ '../views/UserProfil.vue')
  },
  // ASIENTO
  {
    path: '/asiento',
    name: 'asiento',
    component: () => import(/* webpackChunkName: "about" */ '../views/AsientoContable.vue')
  },
  // COMPRA
  {
    path: '/compra',
    name: 'compra',
    component: () => import(/* webpackChunkName: "about" */ '../views/GestCompra.vue')
  },
  // Venta
  {
    path: '/venta',
    name: 'venta',
    component: () => import(/* webpackChunkName: "about" */ '../views/GestVenta.vue')
  },
  // Crear sala
  {
    path: '/crearsala',
    name: 'crearsala',
    component: () => import(/* webpackChunkName: "about" */ '../views/SalaCrear.vue')
  },
  // Ingresar Sala
  {
    path: '/ingresarsala',
    name: 'ingresarsala',
    component: () => import(/* webpackChunkName: "about" */ '../views/SalaIngresar.vue')
  }
]

const router = createRouter({
  history: createWebHashHistory(),
  routes
})

// Aquí agregamos el guardia de navegación
router.beforeEach((to, from, next) => {
  const token = localStorage.getItem('token') // o como guardes tu token

  // Si NO hay token y la ruta NO es home o accessValidation, redirige
  if (!token && to.name !== 'home' && to.name !== 'security') {
    next({ name: 'security' })
  } else {
    next() // Si todo está bien, sigue normalmente
  }
})

export default router
