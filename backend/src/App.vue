<template>
  <!-- 1-este navbar es para llamar al componente NavBar.vue que cree -->
  <Navbar />
  <Siderbar />
  <!-- averiguar que hace, creo que es importante -->
  <router-view />
</template>

<script lang="ts" setup>
// asi se importar
import Navbar from './components/NavBar.vue'
// importar el siderbar
import Siderbar from './components/SiderBar.vue'
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}

/* nav {
  padding: 30px;
}

nav a {
  font-weight: bold;
  color: #2c3e50;
}

nav a.router-link-exact-active {
  color: #42b983;
} */

</style>
