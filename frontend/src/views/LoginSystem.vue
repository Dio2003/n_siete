<template>
  <div class="login-wrapper">
    <div class="login-card">
      <!-- Lado izquierdo -->
      <div class="login-left">
        <img src="../assets/logoConta432x432.png" alt="Logo" class="logo" />
        <h2 class="welcome-text fw-bold">Bienvenido</h2>
        <p class="description ">Al Sistema Integrado de Educación, Tecnología y Estados Contables</p>
      </div>

      <!-- Lado derecho -->
      <div class="login-right">
        <form class="login-form" @submit.prevent="login">
          <!-- <div class="form-group">
            <label for="cedula">Cédula de Identidad</label>
            <input type="email" id="cedula" class="form-control" placeholder="Ingrese su cédula" />
          </div> -->
          <div class="form-group">
            <label for="correo">Correo</label>
            <input type="email" id="correo"  v-model="correo" class="form-control" placeholder="correo" />
          </div>
          <div class="form-group">
            <label for="passwordInput">Contraseña</label>
            <div class="input-group">
              <input :type="showPassword ? 'text' : 'password'" class="form-control" id="password"
                placeholder="Ingrese su contraseña"  v-model="contra"/>
              <button type="button" class="btn btn-outline-secondary" @click="togglePassword">
                <i :class="showPassword ? 'bi bi-eye-slash' : 'bi bi-eye'"></i>
              </button>
            </div>
          </div>
          <div class="form-group remember">
            <input type="checkbox" id="remember" />
            <label for="remember">Recordarme</label>
          </div>
          <button type="submit" class="login-btn">Iniciar Sesión</button>
        </form>
        <div class="p-4">
          <router-link  to="/changePass" >Olvidé mi contraseña</router-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts" setup>
// 1ro importar la libreria de Axios
import axios from 'axios'
import { useRouter } from 'vue-router'
import { ref } from 'vue'
// Importar libreria de alertas
import Swal from 'sweetalert2'

const router = useRouter()

const showPassword = ref(false)
const togglePassword = () => {
  showPassword.value = !showPassword.value
}

// -------------------CONCECTAR A LA API------------------- //
const correo = ref('')
const contra = ref('')

// Método para realizar el login
const login = async () => {
  try {
    // Realizar la solicitud POST a la API para hacer el login
    const response = await axios.post('http://localhost:3000/api/auth/login', {
      correo: correo.value,
      contra: contra.value
    })

    // Si la respuesta es exitosa, guardamos el token en el localStorage
    if (response.data && response.data.token) {
      localStorage.setItem('token', response.data.token) // O sessionStorage.setItem() si prefieres usar sessionStorage
      console.log('Token guardado:', response.data.token)

      // Redirigir a la página principal o cualquier otra página
      router.push('/menu') // Cambia esta ruta por la que necesites

      // Mostrar mensaje de éxito
      Swal.fire({
        icon: 'success',
        title: '¡Éxito!',
        text: 'Has iniciado sesión correctamente.'
      })
    }
  } catch (error) {
    console.error('Error al iniciar sesión:', error)
    // Mostrar mensaje de error con Swal
    Swal.fire({
      icon: 'error',
      title: 'Error',
      text: 'Correo o contraseña incorrectos.'
    })
  }
}

</script>

<style scoped>
.login-wrapper {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  background-color: #4f4f75;
  padding: 1rem;
}

.login-card {
  display: flex;
  width: 900px;
  max-width: 100%;
  height: 500px;
  border-radius: 20px;
  overflow: hidden;
  box-shadow: 0 20px 50px rgba(0, 0, 0, 0.2);
  background-color: white;
}

.login-left {
  flex: 1;
  background-color: #dfdddd;
  color: rgb(20, 19, 19);
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  padding: 2rem;
  text-align: center;
}

.login-left .logo {
  width: 150px;
  margin-bottom: 1.5rem;
}

.welcome-text {
  font-size: 2rem;
  margin-bottom: 0.5rem;
}

.description {
  font-size: 1rem;
  line-height: 1.4;
}

.login-right {
  flex: 1;
  padding: 3rem;
  display: flex;
  flex-direction: column;
  justify-content: center;
  background-color: #3E3E5C;
  color: white;
}

.login-form {
  display: flex;
  flex-direction: column;
}

.form-group {
  margin-bottom: 1.5rem;
}

.form-group label {
  margin-bottom: 0.5rem;
  display: block;
  font-weight: bold;
}

.form-control {
  padding: 0.75rem;
  border: none;
  border-radius: 8px;
  width: 100%;
}

.remember {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  margin-bottom: 1.5rem;
}

.login-btn {
  background-color: #448d62;
  color: white;
  border: none;
  padding: 0.75rem;
  border-radius: 10px;
  font-size: 1rem;
  cursor: pointer;
  transition: 0.3s ease;
}

.login-btn:hover {
  background-color: #195428;
}

/* 🌐 Responsive design */
@media (max-width: 768px) {
  .login-card {
    flex-direction: column;
    height: auto;
  }

  .login-left,
  .login-right {
    flex: unset;
    width: 100%;
    padding: 2rem;
  }

  .login-left .logo {
    width: 100px;
  }

  .welcome-text {
    font-size: 1.5rem;
  }

  .login-right {
    padding-top: 1rem;
  }

  .form-control {
    font-size: 1rem;
  }
}

.input-group .btn {
  border-top-left-radius: 0;
  border-bottom-left-radius: 0;
}
</style>
