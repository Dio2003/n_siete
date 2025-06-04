<template>
    <!-- còdigo del menu vertical -->
    <div class="container-fluid">
        <div class="row">
            <nav id="sidebarMenu" class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse">
                <div class="position-sticky pt-3">
                    <ul class="nav flex-column">
                        <li class="nav-item border-bottom">
                            <router-link class="nav-link userprofile" aria-current="page" to="/profile">
                                <Icon icon="mdi:user" class="me-2" width="24" height="24" />
                                <span>{{ nombre }}</span>
                            </router-link>
                        </li>
                        <li class="nav-item border-bottom">
                            <router-link class="nav-link active" aria-current="page" to="/menu">
                                <Icon icon="mdi:home" class="me-2" width="24" height="24" />
                                <span>Menu</span>
                            </router-link>
                        </li>

                        <!-- user -->
                        <li class="nav-item border-bottom"  v-if="rol === 1">
                            <!-- el router es muy importante porque ue Router maneja las rutas sin recargar la página. -->
                            <router-link class="nav-link" to="/User">
                                <Icon icon="mdi:users" class="me-2" width="24" height="24" />
                                <span>Usuarios</span>
                            </router-link>
                        </li>

                        <!-- Salas - colapsable -->
                        <li class="nav-item border-bottom" v-if="rol === 2 || rol === 3">
                            <a class="nav-link d-flex justify-content-between align-items-center"
                                data-bs-toggle="collapse" href="#salasCollapse" role="button" aria-expanded="false"
                                aria-controls="salasCollapse">
                                <span><Icon icon="mdi:school-outline" class="me-2" width="24" height="24" />
                                Salas
                                <Icon icon="mdi:chevron-down" width="20" height="20" /></span>
                            </a>
                            <div class="collapse ps-4" id="salasCollapse">
                                <router-link  v-if="rol === 2" class="nav-link" to="/crearsala" >
                                    <Icon icon="mdi:create-new-folder-outline" class="me-2" width="20" height="20" />
                                    Crear
                                </router-link>
                                <router-link  v-if="rol === 3" class="nav-link" to="/ingresarsala">
                                    <Icon icon="mdi:blog-outline" class="me-2" width="20" height="20" />
                                    Ingresar
                                </router-link>
                            </div>
                        </li>

                        <!-- Mi Empresa - colapsable -->
                        <li class="nav-item border-bottom" v-if="rol === 2 || rol === 3">
                            <a class="nav-link d-flex justify-content-between align-items-center"
                                data-bs-toggle="collapse" href="#empresaCollapse" role="button" aria-expanded="false"
                                aria-controls="empresaCollapse">
                                <span><Icon icon="mdi:domain" class="me-2" width="24" height="24" />
                                Mi Empresa
                                <Icon icon="mdi:chevron-down" width="20" height="20" /></span>
                            </a>
                            <div class="collapse ps-4" id="empresaCollapse">
                                <router-link  v-if="rol === 2" class="nav-link" to="/Company">
                                    <Icon icon="mdi:office-building" class="me-2" width="20" height="20" />
                                    Empresas
                                </router-link>
                                <router-link v-if="rol === 3 || rol === 2" class="nav-link" to="/proveedor">
                                    <Icon icon="mdi:box-add" class="me-2" width="20" height="20" />
                                    Proveedores
                                </router-link>
                                <router-link v-if="rol === 3 || rol === 2" class="nav-link" to="/client">
                                    <Icon icon="mdi:account-cash" class="me-2" width="20" height="20" />
                                    Clientes
                                </router-link>
                                <!-- Plan de Cuentas -->
                                <router-link v-if="rol === 3 || rol === 2" class="nav-link" to="/account">
                                    <Icon icon="mdi:planner" class="me-2" width="20" height="20" />
                                    Cuentas
                                </router-link>
                            </div>
                        </li>

                        <!-- Libro IVA - colapsable -->
                        <li class="nav-item border-bottom">
                            <a class="nav-link d-flex justify-content-between align-items-center"
                                data-bs-toggle="collapse" href="#libroCollapse" role="button" aria-expanded="false"
                                aria-controls="libroCollapse">
                                <span><Icon icon="mdi:book-open-variant-outline" class="me-2" width="24" height="24" />
                                Libro IVA
                                <Icon icon="mdi:chevron-down" width="20" height="20" /></span>
                            </a>
                            <div class="collapse ps-4" id="libroCollapse">
                                <router-link class="nav-link" to="/compra">
                                    <Icon icon="mdi:invoice-text-edit-outline" class="me-2" width="20" height="20" />
                                    Compras
                                </router-link>
                                <router-link class="nav-link" to="/venta">
                                    <Icon icon="mdi:invoice-export-outline" class="me-2" width="20" height="20" />
                                    Ventas
                                </router-link>
                            </div>
                        </li>

                        <!-- contabilidad -->
                        <li class="nav-item border-bottom">
                            <a class="nav-link d-flex justify-content-between align-items-center"
                                data-bs-toggle="collapse" href="#ContaCollapse" role="button" aria-expanded="false"
                                aria-controls="ContaCollapse">
                                <span><Icon icon="mdi:chart-box-outline" class="me-2" width="24" height="24" />
                                Contabilidad
                                <Icon icon="mdi:chevron-down" width="20" height="20" /></span>
                            </a>
                            <div class="collapse ps-4" id="ContaCollapse">
                                <router-link class="nav-link" to="/asiento">
                                    <Icon icon="mdi:clipboard-text" class="me-2" width="20" height="20" />
                                    Asientos contables
                                </router-link>
                                <router-link class="nav-link" to="/librodiario">
                                    <Icon icon="mdi:book-open-page-variant" class="me-2" width="20" height="20" />
                                    Libro Diario
                                </router-link>
                                <router-link class="nav-link" to="/libromayor">
                                    <Icon icon="mdi:book-multiple" class="me-2" width="20" height="20" />
                                    Libro Mayor
                                </router-link>
                                <router-link class="nav-link" to="/balances">
                                    <Icon icon="mdi:chart-bar" class="me-2" width="20" height="20" />
                                    Balances
                                </router-link>
                            </div>
                        </li>

                        <!-- Herramientas - colapsable -->
                        <li class="nav-item border-bottom">
                            <a class="nav-link d-flex justify-content-between align-items-center"
                                data-bs-toggle="collapse" href="#ConfiguracionCollapse" role="button" aria-expanded="false"
                                aria-controls="ConfiguracionCollapse">
                                <span><Icon icon="mdi:cog-outline" class="me-2" width="24" height="24" />
                                Configuración
                                <Icon icon="mdi:chevron-down" width="20" height="20" /></span>
                            </a>
                            <div class="collapse ps-4" id="ConfiguracionCollapse">
                                <router-link class="nav-link" to="/config">
                                    <Icon icon="mdi:wrench-cog-outline" class="me-2" width="20" height="20" />
                                    Configuración
                                </router-link>
                                <router-link class="nav-link" to="/periodo">
                                    <Icon icon="mdi:calendar-month-outline" class="me-2" width="20" height="20" />
                                    Periodos
                                </router-link>
                                <router-link class="nav-link" to="/ayuda">
                                    <Icon icon="mdi:help" class="me-2" width="20" height="20" />
                                    Ayuda
                                </router-link>
                            </div>
                        </li>

                        <!-- Acerca de -->
                        <li class="nav-item border-bottom">
                            <!-- el router es muy importante porque ue Router maneja las rutas sin recargar la página. -->
                            <router-link class="nav-link" to="/acercade">
                                <Icon icon="mdi:chart-box-outline" class="me-2" width="24" height="24" />
                                <span>Acerca De</span>
                            </router-link>
                        </li>
                    </ul>
                </div>
            </nav>
        </div>
    </div>
</template>

<script lang="ts" setup>
// ----------------------IMPORTACIONES----------------------
// Codigo para los iconos
import { Icon } from '@iconify/vue'
import { ref, onMounted } from 'vue'
import axios from 'axios'
// ------------------------TREAR USUARIO QUE SE REGISTRA----------------------------
const nombre = ref('')
const rol = ref(0)

onMounted(() => {
  const storedUser = localStorage.getItem('usuario')
  if (storedUser) {
    const usuario = JSON.parse(storedUser)
    nombre.value = usuario.nombre
    rol.value = usuario.id_rol
  }
})
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
    transition: all 0.3s ease-in-out;
    /* Transición suave */
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
    background-color: #4F4F75 !important;
    /* Morado */
}

.sidebar .nav-link {
    font-weight: 500;
    color: #ffffff;
    padding: 15px 20px;
    display: flex;
    align-items: center;
    border-radius: 5px;
    /* Bordes redondeados */
    transition: background-color 0.3s ease, color 0.3s ease;
    /* Transiciones suaves */
}

.sidebar .nav-link:hover {
    background-color: rgba(255, 255, 255, 0.2);
    /* Fondo al pasar el mouse */
    color: #ffffff;
}

.sidebar .nav-link.active {
    background-color: #585896;
    /* Fondo para el enlace activo */
    color: #ffffff;
}

.sidebar .nav-link.userprofile {
    background-color: #d89139;
    /* Fondo para el perfil de usuario*/
    color: #ffffff;
}

.sidebar .nav-link span {
    margin-left: 10px;
    /* Espaciado entre el icono y el texto */
    font-size: 1rem;
}

.sidebar .nav-item {
    margin-bottom: 10px;
    /* Espaciado entre elementos */
}

.sidebar-heading {
    font-size: 0.85rem;
    text-transform: uppercase;
    color: #ffffff;
    margin-bottom: 15px;
    padding-left: 20px;
}

.usernav {
    position: fixed;
    left: 0;
    bottom: 0;
    text-align: center;
    padding: 10px;
}
</style>
