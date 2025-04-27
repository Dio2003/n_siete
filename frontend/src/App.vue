<template>
  <!-- <router-view /> -->
  <div class="content">
    <router-view />
  </div>
  <footer class="footer">
    © Sistema SIETE, hecho por los estudiantes de IIE 2025
  </footer>
</template>

<script lang="ts" setup>

</script>

<style>
html, body, #app {
  height: 100%;
  margin: 0;
  padding: 0;
}

#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  background-color: #ffffff;
  display: flex;
  flex-direction: column;
}
.content {
  flex: 1; /* Esto hará que el contenido crezca y empuje el footer hacia abajo */
  display: flex;
  flex-direction: column;
}

.footer {
  position: fixed;
  left: 0;
  bottom: 0;
  background-color: #2c3e50;
  color: white;
  text-align: center;
  padding: 10px;
  width: 100%;
}
</style>
