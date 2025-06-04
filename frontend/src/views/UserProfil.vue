<template>
  <div class="profile d-flex flex-column">
    <!-- Componentes -->
    <Navbar />
    <Siderbar />

    <!-- Abrir el modal de cambiar contraseña -->
    <CambiarContra v-if="mostrarModal" @cerrar="cerrarModal" />

    <!-- Contenido principal -->
    <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 overflow-auto">
      <div class="d-flex justify-content-between align-items-center pt-4 pb-2 mb-4 border-bottom">
        <h1 class="fw-bold">Perfil</h1>
      </div>

      <div class="bg-light p-4 rounded shadow-sm">
        <form id="formUser" class="needs-validation" @submit.prevent="modificar" novalidate>
          <div class="row mb-4 align-items-center">
            <!-- Imagen -->
            <div class="col-md-4 text-center mb-3 mb-md-0">
              <Icon icon="mdi:user" class="text-secondary" width="200" height="200" />
            </div>

            <!-- Datos -->
            <div class="col-md-8">
              <h2 class="fs-4 fw-semibold mb-3 border-bottom pb-2">Detalles del Usuario</h2>
              <p v-if="editMode" class="alert alert-warning mt-2">
                <i class="bi bi-pencil-fill me-2"></i>
                Estás en modo edición. Los campos están habilitados para modificación.
              </p>

              <div class="row g-3">
                <!-- Cedula -->
                <div class="col-md-4">
                  <div class="form-floating">
                    <input type="text" :class="['form-control color-input', { 'is-invalid': errores.cedula }]"
                      id="cedula" placeholder="Cédula" v-model="cedula" :disabled="!editMode" inputmode="numeric"
                      maxlength="10" @input="cedula = cedula.replace(/\D/g, ''); errores.cedula = validarCedula()"
                      @blur="errores.cedula = validarCedula()" />
                    <label for="cedula">Cédula</label>
                    <div class="invalid-feedback">
                      {{ errores.cedula }}
                    </div>
                  </div>
                </div>

                <!-- Nombre -->
                <div class="col-md-8">
                  <div class="form-floating">
                    <input type="text" :class="['form-control color-input', { 'is-invalid': errores.nombre }]"
                      id="nombre" placeholder="Nombre" v-model="nombre" :disabled="!editMode" maxlength="100"
                      @input="nombre = nombre.replace(/[^A-Za-zÁÉÍÓÚÑáéíóúñ ]/g, ''); errores.nombre = validarNombre()"
                      @blur="errores.nombre = validarNombre()" />
                    <label for="nombre">Nombre Completo</label>
                    <div class="invalid-feedback">
                      {{ errores.nombre }}
                    </div>
                  </div>
                </div>

                <!-- Rol -->
                <div class="col-md-4">
                  <div class="form-floating">
                    <input type="text" class="form-control color-input" id="rol" placeholder="Rol" v-model="rol"
                      readonly />
                    <label for="rol">Rol</label>
                  </div>
                </div>

                <!-- Teléfono -->
                <div class="col-md-4">
                  <div class="form-floating">
                    <input type="text" :class="['form-control color-input', { 'is-invalid': errores.telefono }]"
                      id="telefono" placeholder="Teléfono" v-model="telefono" :disabled="!editMode" maxlength="15"
                      @input="telefono = telefono.replace(/\D/g, ''); errores.telefono = validarTelefono()"
                      @blur="errores.telefono = validarTelefono()" />
                    <label for="telefono">Teléfono</label>
                    <div class="invalid-feedback">
                      {{ errores.telefono }}
                    </div>
                  </div>
                </div>

                <!-- Correo -->
                <div class="col-md-4">
                  <div class="form-floating">
                    <input type="email" :class="['form-control color-input', { 'is-invalid': errores.correo }]"
                      id="correo" placeholder="Correo" v-model="correo" :disabled="!editMode"
                      @input=" errores.correo = validarCorreo()" @blur="errores.correo = validarCorreo()" />
                    <label for="correo">Correo</label>
                    <div class="invalid-feedback">
                      {{ errores.correo }}
                    </div>
                  </div>
                </div>

                <!-- Empresa -->
                <div class="col-md-4 w-100">
                  <div class="form-floating">
                    <input v-model="empresa" type="text" class="form-control color-input" id="empresa"
                      placeholder="empresa" readonly />
                    <label for="empresa">Empresa</label>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <hr class="my-4" />

          <!-- Botones -->
          <div class="d-flex justify-content-end gap-3">

            <!-- botones principales -->
            <template v-if="!editMode">
              <button type="button" class="btn btn-success px-4" @click="enableEditMode">Modificar Perfil</button>
              <button type="button" class="btn btn-warning px-4" @click="abrirModal">Cambiar Contraseña</button>
            </template>

            <!-- botones secundarios -->
            <template v-else>
              <button type="submit" class="btn btn-success px-4">Guardar Cambios</button>
              <button type="button" class="btn btn-danger px-4" @click="cancelEditMode">Cancelar</button>
            </template>
          </div>
        </form>
      </div>
    </main>
  </div>
</template>

<script lang="ts" setup>

// ----------------------IMPORTACIONES----------------------
import { Icon } from '@iconify/vue'
import Navbar from '@/components/NavBar.vue'
import Siderbar from '@/components/SiderBar.vue'
import CambiarContra from '@/components/ChangePassword.vue'

import { ref, onMounted } from 'vue'

// Importar libreria de alertas
import Swal from 'sweetalert2'

// Importar libreria de axios
import axios from 'axios'

// --------Obtner y mostrar los datos del usuario al iniciar sesion--------------
const cedula = ref('')
const nombre = ref('')
const rol = ref('')
const telefono = ref('')
const correo = ref('')
const contra = ref('') // para el cambio de contraseña
const empresa = ref('') // para el cambio de contraseña

// Obtener el id del usuario para las modificaciones
const id = ref(0) // eslint-disable-line camelcase
const idRol = ref(0) // eslint-disable-line camelcase

onMounted(() => {
  CargarCampos()
})
onMounted(() => {
  CargarEmpresa()
})

const CargarCampos = async () => {
  const storedUser = localStorage.getItem('usuario')
  if (storedUser) {
    const usuario = JSON.parse(storedUser)

    // Obtener el nombre del rol
    const roles: Record<number, string> = {
      1: 'ADMINISTRADOR',
      2: 'PROFESOR',
      3: 'ALUMNO'
    }

    // Asignar los datos del usuario a las variables
    cedula.value = usuario.cedula
    nombre.value = usuario.nombre

    // Asignar el nombre del rol segun la id_rol
    rol.value = typeof usuario.id_rol === 'object'
      ? usuario.id_rol?.nombre ?? 'Desconocido'
      : roles[Number(usuario.id_rol)] ?? 'Desconocido'

    telefono.value = usuario.telefono
    correo.value = usuario.correo
    id.value = usuario.id_usuario // Asignar el id_usuario
    contra.value = usuario.contra // Asignar la contraseña (si es necesario)
    idRol.value = usuario.id_rol // Asignar el id_rol
  }
}
// cargar empresa
const CargarEmpresa = async () => {
  if (rol.value === 'ALUMNO') {
    try {
      const response = await axios.get(`http://localhost:3000/api/empresas/usuario/${id.value}`)
      console.log('Datos obtenidos de la API para empresas:', response.data)
      empresa.value = response.data.nombre
    } catch (error) {
      console.error(error) // Manejo de errores
      makeToast('Error', 'Error al conseguir las empresas', 'error')
    }
  }
}
// -----------------------LOGICA PARA LA MODIFICACION DEL PERFIL-----------------------

// agregar un ref para controlar que los campos esten habilitados o no
const editMode = ref(false) // primeramente debe estar desbilitado hasta que el usuario queirea modifcar sus datos

// funcion para manejar el modo de edicion
const enableEditMode = () => {
  editMode.value = true // habilitar el modo de edicion
}

// funcion para cancelar el modo de edicion
const cancelEditMode = () => {
  Swal.fire({
    title: '¿Está seguro de que desea cancelar la carga?',
    icon: 'warning',
    showCancelButton: true, // Muestra el botón de cancelar
    confirmButtonText: 'Aceptar',
    cancelButtonText: 'Cancelar',
    reverseButtons: true // Invierte el orden de los botones (Aceptar primero, Cancelar después)
  }).then((result) => {
    if (result.isConfirmed) {
      // Si el usuario hace clic en "Aceptar"
      makeToast('Éxito', 'La acción ha sido cancelada correctamente', 'success')
      editMode.value = false // deshabilitar el modo de edicion
    }
  })
}

// ------------------------VALIDACIONES----------------------

const enviado = ref(false)

const errores = ref({
  cedula: '',
  nombre: '',
  telefono: '',
  correo: ''
})

const validarCedula = () => {
  const ced = cedula.value.trim()
  if (!ced) return 'Por favor, ingrese el número de cédula.'
  if (!/^\d{6,10}$/.test(ced)) return 'La cédula debe contener entre 6 y 10 dígitos numéricos.'
  cedula.value = ced
  return ''
}

const validarNombre = () => {
  const nomb = nombre.value.trim().replace(/\s+/g, ' ')
  if (!nomb) return 'Por favor, ingrese el nombre.'
  if (nomb.length < 5) return 'El nombre debe tener al menos 5 caracteres.'
  if (!/^[A-Za-zÁÉÍÓÚÑáéíóúñ ]+$/.test(nomb)) return 'Solo se permiten letras.'
  nombre.value = nomb
  return ''
}

const validarTelefono = () => {
  const tel = telefono.value.trim()
  if (!tel) return 'Por favor, ingrese el número de teléfono.'
  if (!/^\d{8,15}$/.test(tel)) return 'El teléfono debe contener entre 8 y 15 dígitos.'
  telefono.value = tel
  return ''
}

const validarCorreo = () => {
  const corr = correo.value.trim()
  if (!corr) return 'Por favor, ingrese el correo.'
  const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
  if (!regex.test(corr)) return 'Formato de correo inválido.'
  correo.value = corr.toLowerCase()
  return ''
}

// -----------------------LOGICA PARA EL CAMBIO DE DATOS-----------------------
const modificar = async () => {
  // Validar los campos antes de enviar el formulario
  enviado.value = true
  errores.value.cedula = validarCedula()
  errores.value.nombre = validarNombre()
  errores.value.telefono = validarTelefono()
  errores.value.correo = validarCorreo()

  const tieneErrores = Object.values(errores.value).some(e => e !== '')
  if (tieneErrores) {
    makeToast('Error', 'Por favor corrija los campos marcados.', 'error')
    return
  }

  // Si no hay errores, modificar los datos
  try {
    // Obtener el token del almacenamiento local
    const token = localStorage.getItem('token') // O usa Vuex o cualquier otro método para obtenerlo

    // Configuración de los encabezados para incluir el token
    const config = {
      headers: {
        Authorization: `Bearer ${token}` // Añadir el token al encabezado
      }
    }
    const response = await axios.put(`http://localhost:3000/api/usuarios/${id.value}`, {
      nombre: nombre.value,
      cedula: cedula.value,
      correo: correo.value,
      telefono: telefono.value,
      id_rol: idRol.value,
      contra: contra.value,
      estado: true
    }, config)
    // actualizar los datos del usuario
    localStorage.setItem('usuario', JSON.stringify({
      id_usuario: id.value,
      nombre: nombre.value,
      cedula: cedula.value,
      correo: correo.value,
      telefono: telefono.value,
      id_rol: idRol.value,
      contra: contra.value
    }))
    CargarCampos()

    // desabilitar el modo de edicion
    editMode.value = false // deshabilitar el modo de edicion

    // impedir que se activen las validaciones después de modificar
    const formElement = document.getElementById('formUser') as HTMLFormElement | null
    if (formElement) {
      formElement.classList.remove('was-validated') // Quitar la clase 'was-validated' para evitar que se activen las validaciones después de limpiar
    }

    makeToast('Éxito', 'El usuario se modificó correctamente', 'success')
  } catch (error) {
    console.error('Error al modificar los datos del usuario en la base de datos:', error)
    Swal.fire({
      icon: 'error',
      title: 'Error',
      text: 'No se pudo modificar los datos del usuario.'
    })
  }
}
// -----------------------LOGICA PARA EL CAMBIO DE CONTRASEÑA-----------------------

// ------------- Función para mostrar toasts (mensaje emergente) ------------------------------------------------|
const makeToast = (titulo: string, texto: string, tipo: 'success' | 'error' | 'warning' | 'info' | 'question') => {
  console.log(`Toast: ${titulo} - ${texto} (${tipo})`)
  Swal.fire({
    title: titulo,
    text: texto,
    icon: tipo, // 'success', 'error', 'warning', 'info', 'question'
    // confirmButtonText: 'OK',
    position: 'center', // Posición del Toast
    timer: 3000, // Duración antes de cerrarse automáticamente (en milisegundos)
    showConfirmButton: false // Para mostrar un botón de confirmación
  })
}

// -----------------------LOGICA PARA ABRIR Y CERRAR EL MODAL-----------------------
// Estado para controlar la visibilidad del modal
const mostrarModal = ref(false)

// abrir
const abrirModal = () => {
  mostrarModal.value = true // Asegurar que se muestra el modal
}

// cerrar
const cerrarModal = () => {
  mostrarModal.value = false
}
</script>

<style scoped>
.color-input {
  background-color: #f0f2f5;
  border: 1px solid #ced4da;
  border-radius: 0.5rem;
}

/* color del boton de cambiar contrasña */
.btn-warning {
  background-color: #FFC107 !important;
  color: #ffffff !important;
}

.btn-warning:hover {
  background-color: #FFA000 !important;
  color: #ffffff !important;
}
</style>
