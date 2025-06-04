<template>
  <header class="navbar navbar-white sticky-top bg-dark flex-md-nowrap p-0 shadow">
    <!-- Logo -->
    <router-link class="navbar-brand col-md-3 col-lg-2 me-0 px-3" to="/menu">
      <img src="../assets/logoConta432x432.png" alt="" width="45" />
    </router-link>

    <!-- Espaciado central -->
    <div class="navbar-nav w-100 d-none d-md-block"></div>

    <!-- Enlaces visibles en pantallas medianas o grandes -->
    <div class="navbar-nav d-none d-md-flex flex-row align-items-center me-3">

      <!-- Rol -->
      <p class="nav-link px-3 pt-4 d-flex align-items-center gap-1">
        <Icon icon="mdi:account-tag-outline" width="20" height="20" />
        <span>{{ rol }}</span>
      </p>

      <!-- Perfil -->
      <router-link class="nav-link px-3 d-flex align-items-center gap-1" to="/profile">
        <Icon icon="mdi:account-circle-outline" width="20" height="20" />
        <span>Perfil</span>
      </router-link>

      <a class="nav-link px-3 d-flex align-items-center gap-1" href="#">
        <Icon icon="mdi:bell-outline" width="20" />
        Notificaciones
      </a>
      <button class="nav-link px-3 d-flex align-items-center gap-1" @click="logout">
        <Icon icon="mdi:logout" width="20" />
        <span>Salir</span>
      </button>
    </div>

    <!-- Botón del sidebar (hamburguesa) para pantallas pequeñas -->
    <div class="d-flex align-items-center ms-auto me-2">
      <button class="navbar-toggler d-md-none collapsed me-2" type="button" data-bs-toggle="collapse"
        data-bs-target="#sidebarMenu" aria-controls="sidebarMenu" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>

      <!-- Dropdown para pantallas pequeñas -->
      <div class="dropdown d-md-none">
        <button class="btn btn-light d-flex align-items-center p-1 rounded" type="button" id="userMenuButton"
          data-bs-toggle="dropdown" aria-expanded="false">
          <Icon icon="mdi:dots-vertical" width="24" />
        </button>
        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userMenuButton">
          <li>
            <!-- Rol -->
            <p class="dropdown-item d-flex align-items-center gap-2">
              <Icon icon="mdi:account-tag-outline" width="20" height="20" />
              <span>{{ rol }}</span>
            </p>
          </li>
          <li>
            <!-- Perfil -->
            <router-link class="dropdown-item d-flex align-items-center gap-2" to="/profile">
              <Icon icon="mdi:account-circle-outline" width="20" height="20" />
              <span>Perfil</span>
            </router-link>
          </li>
          <li>
            <a class="dropdown-item d-flex align-items-center gap-2" href="#">
              <Icon icon="mdi:bell-outline" width="20" />
              Notificaciones
            </a>
          </li>
          <li>
            <router-link class="dropdown-item d-flex align-items-center gap-2" to="/home">
              <Icon icon="mdi:logout" width="20" />
              <span>Salir</span>
            </router-link>
          </li>
        </ul>
      </div>
    </div>

  </header>
</template>

<script lang="ts" setup>
// IMPORTACIONES
import router from '@/router'
import { Icon } from '@iconify/vue'
import { ref, onMounted } from 'vue'

// ------------Logica para cerrar sesión-------------- //
const logout = () => {
  // Eliminar el token del localStorage o sessionStorage
  localStorage.removeItem('token') // O sessionStorage.removeItem() si usaste sessionStorage
  console.log('Token eliminado')
  // Redirigir a la página de inicio de sesión o cualquier otra página
  router.push('/')
}

// ------------Logica para obtener el rol-------------- //
const rol = ref('')

onMounted(() => {
  const storedUser = localStorage.getItem('usuario')
  if (storedUser) {
    const usuario = JSON.parse(storedUser)

    // Obtener el nombre del rol
    const roles: Record<number, string> = {
      1: 'ADMINISTRADOR',
      2: 'PROFESOR',
      3: 'ALUMNO'
    }
    // Asignar el nombre del rol segun la id_rol
    rol.value = typeof usuario.id_rol === 'object'
      ? usuario.id_rol?.nombre ?? 'Desconocido'
      : roles[Number(usuario.id_rol)] ?? 'Desconocido'
  }
})
</script>

<style scoped>
.bd-placeholder-img {
  font-size: 1.125rem;
  text-anchor: middle;
  user-select: none;
}

@media (min-width: 768px) {
  .bd-placeholder-img-lg {
    font-size: 3.5rem;
  }
}

.navbar-brand {
  padding-top: .75rem;
  padding-bottom: .75rem;
  font-size: 1rem;
  background-color: rgb(255, 255, 255);
  box-shadow: inset -1px 0 0 rgba(0, 0, 0, .25);
}

.bg-dark {
  background-color: #ffffff !important;
}

.navbar .navbar-toggler {
  top: .25rem;
  right: 1rem;
}

.nav-link {
  color: #000000;
}

.dropdown-toggle::after {
  display: none;
}

.dropdown .btn {
  background-color: transparent;
  border: none;
  box-shadow: none;
}
</style>
