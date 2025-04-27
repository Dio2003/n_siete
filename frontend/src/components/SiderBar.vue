<template>
    <!-- còdigo del menu vertical -->
    <div class="container-fluid">
        <div class="row">
            <nav id="sidebarMenu" class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse">
                <div class="position-sticky pt-3">
                    <ul class="nav flex-column">
                        <li class="nav-item border-bottom">
                            <router-link class="nav-link active" aria-current="page" to="/menu">
                                <Icon icon="mdi:home" class="me-2" width="24" height="24"  />
                                <span>Menu</span>
                            </router-link>
                        </li>
                        <!-- user -->
                        <li class="nav-item border-bottom">
                            <!-- el router es muy importante porque ue Router maneja las rutas sin recargar la página. -->
                            <router-link class="nav-link" to="/User">
                                <Icon icon="mdi:account" class="me-2" width="24" height="24"  />
                                <span>Usuario</span>
                            </router-link>
                        </li>
                        <!-- empresa -->
                        <li class="nav-item border-bottom">
                            <!-- el router es muy importante porque ue Router maneja las rutas sin recargar la página. -->
                            <router-link class="nav-link" to="/Company">
                                <Icon icon="mdi:office-building" class="me-2" width="24" height="24" />
                                <span>Empresas</span>
                            </router-link>
                        </li>
                    </ul>
                </div>
            </nav>
        </div>
    </div>
</template>

<script lang="ts" setup>
// Codigo para los iconos
import { Icon } from '@iconify/vue'

</script>

<style scoped>
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
 * Sidebar
 */

.sidebar {
    position: fixed;
    top: 0;
    bottom: 0;
    left: 0;
    z-index: 100;
    padding: 48px 0 0;
    box-shadow: inset -1px 0 0 rgba(0, 0, 0, 0.1);
    transition: all 0.3s ease-in-out; /* Transición suave */
}

@media (max-width: 767.98px) {
    .sidebar {
        top: 5rem;
    }
}

.sidebar-sticky {
    position: relative;
    top: 0;
    height: calc(100vh - 48px);
    padding-top: .5rem;
    overflow-x: hidden;
    overflow-y: auto;
    /* Scrollable contents if viewport is shorter than content. */
}

/* cambiar de color el siderbar */
.bg-light {
  background-color: #4F4F75 !important; /* Morado */
}

.sidebar .nav-link {
    font-weight: 500;
    color: #ffffff;
    padding: 15px 20px;
    display: flex;
    align-items: center;
    border-radius: 5px; /* Bordes redondeados */
    transition: background-color 0.3s ease, color 0.3s ease; /* Transiciones suaves */
}

.sidebar .nav-link:hover {
    background-color: rgba(255, 255, 255, 0.2); /* Fondo al pasar el mouse */
    color: #ffffff;
}

.sidebar .nav-link.active {
    background-color: #585896; /* Fondo para el enlace activo */
    color: #ffffff;
}

.sidebar .nav-link span {
    margin-left: 10px; /* Espaciado entre el icono y el texto */
    font-size: 1rem;
}

.sidebar .nav-item {
    margin-bottom: 10px; /* Espaciado entre elementos */
}

.sidebar-heading {
    font-size: 0.85rem;
    text-transform: uppercase;
    color: #ffffff;
    margin-bottom: 15px;
    padding-left: 20px;
}
</style>
