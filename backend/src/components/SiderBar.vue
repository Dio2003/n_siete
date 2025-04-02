<template>
    <!-- còdigo del menu vertical -->
    <div class="container-fluid">
        <div class="row">
            <nav id="sidebarMenu" class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse">
                <div class="position-sticky pt-3">
                    <ul class="nav flex-column">
                        <li class="nav-item border-bottom">
                            <a class="nav-link active" aria-current="page" href="#">
                                <span data-feather="home"></span>
                                Menu
                            </a>
                        </li>
                        <!-- user -->
                        <li class="nav-item border-bottom">
                            <!-- el router es muy importante porque ue Router maneja las rutas sin recargar la página. -->
                            <router-link class="nav-link" to="/User">
                                <span data-feather="file"></span>
                                Usuario
                            </router-link>
                        </li>
                        <!-- empresa -->
                        <li class="nav-item border-bottom">
                            <!-- el router es muy importante porque ue Router maneja las rutas sin recargar la página. -->
                            <router-link class="nav-link" to="/Company">
                                <span data-feather="file"></span>
                                Empresas
                            </router-link>
                        </li>
                    </ul>
                </div>
            </nav>
        </div>
    </div>
</template>

<script lang="ts" setup>
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
    /* rtl:raw:
  right: 0;
  */
    bottom: 0;
    /* rtl:remove */
    left: 0;
    z-index: 100;
    /* Behind the navbar */
    padding: 48px 0 0;
    /* Height of navbar */
    box-shadow: inset -1px 0 0 rgba(0, 0, 0, .1);
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
}

.sidebar .nav-link .feather {
    margin-right: 4px;
    color: #727272;
}

.sidebar .nav-link.active {
    color: #c51d0e;
}

.sidebar .nav-link:hover .feather,
.sidebar .nav-link.active .feather {
    color: inherit;
}

.sidebar-heading {
    font-size: .75rem;
    text-transform: uppercase;
}
</style>
