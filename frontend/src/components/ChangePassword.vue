<template>
    <div class="modal fade show d-block" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog" style="max-width: 500px;">
            <div class="modal-content text-white p-4" style="background-color: #4F4F75; border-radius: 10px;">

                <div class="modal-header border-bottom">
                    <h1 class="modal-title fs-3 fw-semibold" id="staticBackdropLabel"> Cambiar Contraseña</h1>
                    <button type="button" class="btn-close bg-white" @click="cerrarModal" aria-label="Close"></button>
                </div>

                <!-- Formulario para cambiar la contraseña -->
                <form id="formpass" @submit.prevent="cambiarContra" novalidate :class="{ 'was-validated': enviado }">

                    <!-- Cuerpo del Modal -->
                    <div class="modal-body">
                        <div class="row">
                            <!-- Contraseña actual -->
                            <div class="col-md-12 mb-3 text-start ">
                                <div class="form-floating">
                                    <input type="text"
                                        :class="['form-control color-input', { 'is-invalid': errores.contraactual }]"
                                        id="contraactual" placeholder="Contraseña Actual" v-model="contraactual"
                                        maxlength="100"
                                        @input="errores.contraactual = validarContraActual()"
                                        @blur="errores.contraactual = validarContraActual()" />
                                    <label for="nombre">Contraseña Actual</label>
                                    <div class="invalid-feedback">
                                        {{ errores.contraactual }}
                                    </div>
                                </div>
                            </div>
                            <!-- Nueva Contraseña -->
                            <div class="col-md-12 mb-3 text-start">
                                <div class="form-floating">
                                    <input type="text"
                                        :class="['form-control color-input', { 'is-invalid': errores.nuevacontra }]"
                                        id="nuevacontra" placeholder="Nueva Contraseña" v-model="nuevacontra"
                                        maxlength="100"
                                        @input="errores.nuevacontra = validarContraNueva()"
                                        @blur="errores.nuevacontra = validarContraNueva()" />
                                    <label for="nuevacontra">Nueva Contraseña</label>
                                    <div class="invalid-feedback">
                                        {{ errores.nuevacontra }}
                                    </div>
                                </div>
                            </div>
                            <!-- Repetir Contraseña  -->
                            <div class="col-md-12 mb-3 text-start">
                                <div class="form-floating">
                                    <input type="text"
                                        :class="['form-control color-input', { 'is-invalid': errores.repetircontra }]"
                                        id="repetircontra" placeholder="Contraseña Actual" v-model="repetircontra"
                                        maxlength="100"
                                        @input="errores.repetircontra = validarContraRepetida()"
                                        @blur="errores.repetircontra = validarContraRepetida()" />
                                    <label for="repetircontra">Contraseña Actual</label>
                                    <div class="invalid-feedback">
                                        {{ errores.repetircontra }}
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>

                    <!-- Pie del Modal -->
                    <div class="modal-footer border-0">
                        <button type="button" class="btn btn-danger" @click="cerrarModal">Cancelar</button>
                        <button type="submit" class="btn btn-success" id="btnGuardar">Cambiar Contraseña</button>
                    </div>

                </form>
            </div>
        </div>
    </div>
</template>
<script lang="ts" setup>
// IMPORTACIONES
import { ref, onMounted, defineEmits } from 'vue'

// Importar libreria de alertas
import Swal from 'sweetalert2'

// Importar libreria de axios
import axios from 'axios'

// --------------------------CODIGO DE LOS EVENTOS EMITIDOS ---------------------------------------------|
const emit = defineEmits(['cerrar'])
// -------------- VALIDACIONES ------------------ //

// obtener la antigua contraseña
const contrabd = ref('') // para el cambio de contraseña

// Obtener el id del usuario para las modificaciones
const id = ref(0) // eslint-disable-line camelcase

onMounted(() => {
  CargarCampos()
})

const CargarCampos = async () => {
  const storedUser = localStorage.getItem('usuario')
  if (storedUser) {
    const usuario = JSON.parse(storedUser)
    id.value = usuario.id_usuario // Asignar el id_usuario
    contrabd.value = usuario.contra // Asignar la contraseña (si es necesario)
  }
}

// validar campos de la contraseña

// validar para que los campos de contraseña actual, nueva y repetir no esten vacios. Validar que la nueva contraseña y repetir contraseña sean iguales y Validar que la
// contraseña actual sea igual a la de la base de datos, tambien validar que la nueva contraseña tenga al menos 8 caracteres, una mayuscula, un numero y un caracter especial
// tambien validar que la nueva contraseña no sea igual a la contraseña actual

const enviado = ref(false)

const errores = ref({
  contraactual: '',
  nuevacontra: '',
  repetircontra: ''
})

const contraactual = ref('')
const nuevacontra = ref('')
const repetircontra = ref('')

const validarContraActual = () => {
  if (!contraactual.value) return 'La contraseña actual es obligatoria.'
  // if (contraactual.value !== contrabd.value) return 'La contraseña actual no coincide.'
  return ''
}
const validarContraNueva = () => {
  const password = nuevacontra.value

  if (!password) return 'La nueva contraseña es obligatoria.'
  if (password === contraactual.value) return 'La nueva contraseña no puede ser igual a la actual.'
  if (password.length < 8) return 'Debe tener al menos 8 caracteres.'
  if (!/[A-Z]/.test(password)) return 'Debe tener al menos una letra mayúscula.'
  if (!/[0-9]/.test(password)) return 'Debe tener al menos un número.'
  if (!/[!@#$%^&*(),._?":{}|<>]/.test(password)) return 'Debe tener al menos un carácter especial.'
  return ''
}
const validarContraRepetida = () => {
  if (!repetircontra.value) return 'Debe repetir la nueva contraseña.'
  if (repetircontra.value !== nuevacontra.value) return 'Las contraseñas no coinciden.'
  return ''
}

// ---------------------------CODIGO PARA CERRAR EL MODAL ----------------------------------|

const cerrarModal = () => {
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
      emit('cerrar') // Emitimos el evento para que el padre lo maneje y cierre el modal
    }
  })
}

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

// --------------LOGICA PARA CAMBIAR CONTRASEÑA------------------ //
const cambiarContra = async () => {
  // Validar los campos antes de enviar el formulario
  enviado.value = true
  errores.value.contraactual = validarContraActual()
  errores.value.nuevacontra = validarContraNueva()
  errores.value.repetircontra = validarContraRepetida()

  const tieneErrores = Object.values(errores.value).some(e => e !== '')
  if (tieneErrores) {
    makeToast('Error', 'Por favor corrija los campos marcados.', 'error')
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
    const response = await axios.put(`http://localhost:3000/api/usuarios/cambioContra/${id.value}`, {
      contra: repetircontra.value
    }, config)
    // Limpiar los campos después de enviar el formulario
    contraactual.value = ''
    nuevacontra.value = ''
    repetircontra.value = ''

    // cerrar el modal
    emit('cerrar')
    // impedir que se activen las validaciones después de modificar
    const formElement = document.getElementById('formUser') as HTMLFormElement | null
    if (formElement) {
      formElement.classList.remove('was-validated') // Quitar la clase 'was-validated' para evitar que se activen las validaciones después de limpiar
    }

    makeToast('Éxito', 'La contraseña se modificó correctamente', 'success')
  } catch (error) {
    console.error('Error al modificar la contraseña en la base de datos:', error)
    Swal.fire({
      icon: 'error',
      title: 'Error',
      text: 'No se pudo modificar la contraseña'
    })
  }
}

</script>
<style scoped></style>
