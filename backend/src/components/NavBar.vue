<template>
  <!-- Codigo del navegador de arriba -->
  <header class="navbar navbar-white sticky-top bg-dark flex-md-nowrap p-0 shadow">
    <!-- VOLVER AL MENU -->
    <router-link class="navbar-brand col-md-3 col-lg-2 me-0 px-3" to="/home">
    SIETE</router-link>
    <!-- Boton para cuando se achica el menu -->
    <button class="navbar-toggler position-absolute d-md-none collapsed" type="button" data-bs-toggle="collapse"
      data-bs-target="#sidebarMenu" aria-controls="sidebarMenu" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <!-- div para salir del menu -->
    <div class="navbar-nav w-100">
    </div>
    <div class="navbar-nav">
      <div class="nav-item text-nowrap">
        <a class="nav-link px-3" href="#">salir</a>
      </div>
    </div>
  </header>
</template>

<script lang="ts" setup>
</script>

<style scoped>
/* EL scoped es para que los estilos que se pongan acá solo afecten a este archivo */
.bd-placeholder-img {
  font-size: 1.125rem;
  text-anchor: middle;
  -webkit-user-select: none;
  -moz-user-select: none;
  user-select: none;
}

@media (min-width: 768px) {
  .bd-placeholder-img-lg {
    font-size: 3.5rem;
  }
}

/*
 * Navbar
 */

.navbar-brand {
  padding-top: .75rem;
  padding-bottom: .75rem;
  font-size: 1rem;
  background-color:rgb(255, 255, 255); /* COLOR DE LA BARRA DE NAVEGACION DONDE ESTÁ EL LOGO DE */
  box-shadow: inset -1px 0 0 rgba(0, 0, 0, .25);
}

/* cambiar de color el navbar */
.bg-dark {
  background-color: #ffffff !important; /* Morado claro */
}

.navbar .navbar-toggler {
  top: .25rem;
  right: 1rem;
}

</style>
