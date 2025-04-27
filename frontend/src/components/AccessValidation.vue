<template>
    <section class="d-flex align-items-center min-vh-100 bg-light">
      <div class="container">
        <div class="row align-items-center">
          <!-- TEXTO -->
          <div class="col-md-6 mb-4 mb-md-0 text-center text-md-start">
            <h1 class="display-5 fw-bold">Acceso denegado al<br><span class="text-primary">sistema SIETE</span></h1>
            <p class="lead">
              Usted no está autorizado para acceder al sistema.
            </p>
            <p class="text-danger fw-semibold">
              {{ segundosMensaje }}
            </p>
          </div>

          <!-- IMÁGENES -->
          <div class="col-md-6 text-center">
            <img src="../assets/logoConta432x432.png" class="img-fluid mb-3" alt="Logo Conta" style="max-width: 200px;">
            <img src="../assets/fcea75px.png" class="img-fluid" alt="Logo FCEA" style="max-width: 200px;">
          </div>
        </div>
      </div>
    </section>
  </template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()
const segundos = ref(16)
const segundosMensaje = ref('')

const startTimer = () => {
  const interval = setInterval(() => {
    segundos.value--
    segundosMensaje.value = `En ${segundos.value} segundos será redirigido...`
    if (segundos.value <= 0) {
      clearInterval(interval)
      router.push('/')
    }
  }, 1000)
}

onMounted(() => {
  startTimer()
})
</script>
