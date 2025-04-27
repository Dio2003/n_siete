<template>
  <div class="menu">
    <Navbar />
    <Siderbar />
    <img alt="Vue logo" src="../assets/logo.png">
    <HelloWorld msg="Proximo menu del sistema"/>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
import HelloWorld from '@/components/HelloWorld.vue' // @ is an alias to /src
// asi se importar
import Navbar from '@/components/NavBar.vue'
// importar el siderbar
import Siderbar from '@/components/SiderBar.vue'

export default defineComponent({
  name: 'HomeView',
  components: {
    HelloWorld,
    Navbar, // Agrega Navbar aquí
    Siderbar // Agrega Siderbar aquí
  }
})
</script>
