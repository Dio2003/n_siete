<template>
  <div class="menu">
    <Navbar />
    <Siderbar />
    <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 overflow-auto">
      <div class="container py-4">
        <!-- Bienvenida -->
        <div class="mb-4">
          <h2 class="h4 fw-semibold text-dark">¡Hola, {{ nombre }}!</h2>
          <p class="text-muted">{{ fechaActual }}</p>
        </div>

        <!-- Tarjetas resumen -->
        <div class="row mb-4">
          <div class="col-12 col-sm-6 col-lg-3 mb-3">
            <div class="card shadow-sm p-3">
              <div class="d-flex align-items-center">
                <i class="mdi mdi-cash text-success fs-4 me-3"></i>
                <div>
                  <p class="text-muted small mb-0">Asientos registrados</p>
                  <p class="fw-bold mb-0">{{ totalAsientos }}</p>
                </div>
              </div>
            </div>
          </div>

          <div class="col-12 col-sm-6 col-lg-3 mb-3">
            <div class="card shadow-sm p-3">
              <div class="d-flex align-items-center">
                <i class="mdi mdi-book text-primary fs-4 me-3"></i>
                <div>
                  <p class="text-muted small mb-0">Cuentas</p>
                  <p class="fw-bold mb-0">{{ totalCuentas }}</p>
                </div>
              </div>
            </div>
          </div>

          <div class="col-12 col-sm-6 col-lg-3 mb-3">
            <div class="card shadow-sm p-3">
              <div class="d-flex align-items-center">
                <i class="mdi mdi-chart-bar text-info fs-4 me-3"></i>
                <div>
                  <p class="text-muted small mb-0">Balance actual</p>
                  <p class="fw-bold mb-0">{{ balanceActual }}</p>
                </div>
              </div>
            </div>
          </div>

          <div class="col-12 col-sm-6 col-lg-3 mb-3">
            <div class="card shadow-sm p-3">
              <div class="d-flex align-items-center">
                <i class="mdi mdi-history text-warning fs-4 me-3"></i>
                <div>
                  <p class="text-muted small mb-0">Últimos movimientos</p>
                  <p class="fw-bold mb-0">{{ ultimosMovimientos }}</p>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Accesos rápidos -->
        <div class="row mb-4">
          <div class="col-12 col-sm-6 col-lg-3 mb-3">
            <router-link to="/asientos" class="btn btn-outline-primary w-100 d-flex align-items-center justify-content-center py-3 shadow-sm rounded">
              <Icon icon="mdi:plus-box" width="20" height="20" class="me-2" />
              Registrar Asiento
            </router-link>
          </div>
          <div class="col-12 col-sm-6 col-lg-3 mb-3">
            <router-link to="/libro-diario" class="btn btn-outline-secondary w-100 d-flex align-items-center justify-content-center py-3 shadow-sm rounded">
              <Icon icon="mdi:book-open" width="20" height="20" class="me-2" />
              Ver Libro Diario
            </router-link>
          </div>
          <div class="col-12 col-sm-6 col-lg-3 mb-3">
            <router-link to="/libro-mayor" class="btn btn-outline-success w-100 d-flex align-items-center justify-content-center py-3 shadow-sm rounded">
              <Icon icon="mdi:book-multiple" width="20" height="20" class="me-2" />
              Ver Libro Mayor
            </router-link>
          </div>
          <div class="col-12 col-sm-6 col-lg-3 mb-3">
            <router-link to="/balances" class="btn btn-outline-info w-100 d-flex align-items-center justify-content-center py-3 shadow-sm rounded">
              <Icon icon="mdi:chart-line" width="20" height="20" class="me-2" />
              Ver Balances
            </router-link>
          </div>
        </div>

        <!-- Ayuda o tutorial -->
        <div class="alert alert-warning border-start border-4 rounded">
          <strong>¿Nuevo por aquí?</strong>
          <p class="mb-1">Te recomendamos leer nuestra
            <router-link to="/ayuda" class="text-decoration-underline">guía para empezar</router-link>.
          </p>
        </div>
      </div>
    </main>
  </div>
</template>

<script lang="ts" setup>
import Navbar from '@/components/NavBar.vue'
import Siderbar from '@/components/SiderBar.vue'
import { Icon } from '@iconify/vue'
import { ref, onMounted } from 'vue'

const nombre = ref('')
const fechaActual = ref('')

const totalAsientos = ref(12)
const totalCuentas = ref(5)
const balanceActual = ref('$4,500')
const ultimosMovimientos = ref(4)

onMounted(() => {
  const fecha = new Date()
  fechaActual.value = fecha.toLocaleDateString('es-ES', {
    weekday: 'long', year: 'numeric', month: 'long', day: 'numeric'
  })
  const storedUser = localStorage.getItem('usuario')
  if (storedUser) {
    const usuario = JSON.parse(storedUser)
    nombre.value = usuario.nombre
  }
})
</script>

<style scoped>
.container {
  max-width: 1200px;
  margin: auto;
}
</style>
