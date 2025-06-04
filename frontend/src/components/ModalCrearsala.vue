<template>
  <!-- MODAL CREAR SALA -->
  <!-- NOTA: Este Modal es tambien para Ingresar a la sala -->
  <div class="modal fade show d-block" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog" style="max-width: 500px;">
      <div class="modal-content text-white p-4" style="background-color: #4F4F75; border-radius: 10px;">

        <!-- TITULO -->
        <div class="modal-header border-bottom">
          <h1 class="modal-title fs-3 fw-semibold" id="staticBackdropLabel"> {{ tituloModal }}</h1>
          <button type="button" class="btn-close bg-white" @click="cerrarModal" aria-label="Close"></button>
        </div>

        <!-- FORMULARIO -->
        <form id="formcrearSala" class="needs-validation" novalidate  @submit.prevent="guardarOmodificar">
          <!-- CUERPO DEL MODAL -->
          <div class="modal-body">

            <div class="row">
              <!-- PROFESOR -->
              <div class="col-md-12 mb-3 text-start">
                <label for="nombreProfesor" class="form-label">Profesor</label>
                <input readonly v-model="nombreProfesor" type="text" class="form-control" id="nombreProfesor"
                  name="nombreProfesor">
              </div>
              <!-- Nombre de la sala -->
              <div class="col-md-12 mb-3 text-start">
                <label for="NombreSala" class="form-label">Nombre de la sala</label>
                <input :disabled="props.deshabilitarCampos" type="text"
                  :class="['form-control color-input', { 'is-invalid': errores.NombreSala }]"
                  placeholder="Ingrese el nombre" v-model="NombreSala" maxlength="50"
                  @input="NombreSala = NombreSala.replace(/[^A-Za-zÁÉÍÓÚÑáéíóúñ ]/g, ''); errores.NombreSala = validarNombre()"
                  @blur="errores.NombreSala = validarNombre()" id="NombreSala" name="NombreSala">
                <div class="invalid-feedback">
                  {{ errores.NombreSala }}
                </div>
              </div>
              <!-- contraseña -->
              <div class="col-md-12 mb-3 text-start">
                <label for="password" class="form-label">Contraseña</label>
                <input type="text" :class="['form-control color-input', { 'is-invalid': errores.password }]"
                  placeholder="Ingrese una contraseña" v-model="password" maxlength="50"
                  @input="errores.password = validarContraNueva()" @blur="errores.password = validarContraNueva()"
                  id="password" name="password">
                <div class="invalid-feedback">
                  {{ errores.password }}
                </div>
              </div>
              <!-- confirmar contraseña -->
              <div v-if="mostrarConfirmar" class="col-md-12 mb-3 text-start">
                <label for="confirmPassword" class="form-label">Confirmar Contraseña</label>
                <input type="text" :class="['form-control color-input', { 'is-invalid': errores.confirmPassword }]"
                  placeholder="Repita la contraseña" v-model="confirmPassword" maxlength="50"
                  @input="errores.confirmPassword = validarContraRepetida()"
                  @blur="errores.confirmPassword = validarContraRepetida()" id="confirmPassword" name="confirmPassword">
                <div class="invalid-feedback">
                  {{ errores.confirmPassword }}
                </div>
              </div>
            </div>

          </div>
          <!-- PIE DEL MODAL -->
          <div class="modal-footer border-0  border-bottom">
            <button v-if="mostrarCrear" type="submit" class=" btn btn-success me-2" id="">Crear</button>
            <button v-if="mostrarIngresar" type="submit" class=" btn btn-success me-2"
              @click="IngresarSala()">Ingresar</button>
            <button type="button" class=" btn btn-danger" id="">Cancelar</button>
          </div>

        </form>

      </div>
    </div>
  </div>
</template>

<script lang="ts" setup>
// importaciones de vue
import { defineEmits, onMounted, ref, defineProps, computed } from 'vue'

// Importar libreria de alertas
import Swal from 'sweetalert2'

// 1ro importar la libreria de Axios
import axios, { AxiosError } from 'axios'

// ------------------CODIGO DE EVENTOS EMITIDOS----------------------------------------|

const emit = defineEmits(['cerrar', 'actualizartabla']) // Emitir eventos al padre para cerrar el modal y actualizar la tabla

// --------------------------CODIGO DE ALERTAS -----------------------------------------------------------|

// Función para mostrar toasts (mensaje emergente)
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
// --------------------------FIN CODIGO DE ALERTAS -------------------------------------------------------|

// ------------------COIDIGO PARA CERRAR EL MODAL----------------------------------------|

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

// -------------------CODIGOS PARA CAMBIAR EL TITULO------------------------------------------|
// Importante para que el titulo cambie segun modificar o cargar
const props = defineProps({
  tituloModal: String,
  mostrarConfirmar: {
    type: Boolean,
    default: true // Por defecto no mostrar el campo de confirmar contraseña
  },
  mostrarCrear: {
    type: Boolean,
    default: true // Por defecto no mostrar el campo de confirmar contraseña
  },
  mostrarIngresar: {
    type: Boolean,
    default: true // Por defecto no mostrar el campo de confirmar contraseña
  },
  deshabilitarCampos: {
    type: Boolean,
    default: false // Por defecto los campos están habilitados
  },
  sala: Object // para recibir los datos de la empresa desde la tabla
})

const sala = ref({ ...props.sala }) // Crear una referencia reactiva a los datos de la sala

// -------------------FIN CODIGOS PARA CAMBIAR EL TITULO------------------------------------------|

// -------------------CODIGOS PARA VALIDAR EL FORMULARIO------------------------------------------|

const enviado = ref(false)

const errores = ref({
  NombreSala: '',
  password: '',
  confirmPassword: ''
})

const NombreSala = computed({
  get: () => sala.value.sala,
  set: (val) => {
    sala.value.sala = val
  }
})
const password = computed({
  get: () => sala.value.contra,
  set: (val) => {
    sala.value.contra = val
  }
})

const confirmPassword = ref('')

const validarNombre = () => {
  const nomb = NombreSala.value.trim().replace(/\s+/g, ' ')
  if (!nomb) return 'Por favor, ingrese el nombre.'
  if (nomb.length < 5) return 'El nombre debe tener al menos 5 caracteres.'
  if (!/^[A-Za-zÁÉÍÓÚÑáéíóúñ ]+$/.test(nomb)) return 'Solo se permiten letras.'
  NombreSala.value = nomb
  return ''
}

const validarContraNueva = () => {
  const passwordd = password.value

  if (!passwordd) return 'La contraseña es obligatoria.'
  if (passwordd.length < 4) return 'Debe tener al menos 8 caracteres.'
  if (!/[A-Z]/.test(passwordd)) return 'Debe tener al menos una letra mayúscula.'
  if (!/[0-9]/.test(passwordd)) return 'Debe tener al menos un número.'
  return ''
}

const validarContraRepetida = () => {
  if (!confirmPassword.value) return 'Debe repetir la nueva contraseña.'
  if (confirmPassword.value !== password.value) return 'Las contraseñas no coinciden.'
  return ''
}
// --------------------FIN CODIGOS PARA VALIDAR EL FORMULARIO------------------------------------------|
// -----------------------LOGICA PARA GUARDAR O MODIFICAR LOS DARTOS-----------------------

// ---------------------CODIGOS PARA CARGAR LOS DATOS DE LA SALA------------------------------------------|
// TAER EL NOMBRE DEL PROFESOR QUE ESTA CARGANDO LA SALA
const nombreProfesor = ref('') // Variable para almacenar el nombre del profesor
const id = ref(0) // eslint-disable-line camelcase
const id_rol = ref(0) // eslint-disable-line camelcase

onMounted(() => {
  CargarCampos()
})

const CargarCampos = async () => {
  const storedUser = localStorage.getItem('usuario')
  if (storedUser) {
    const usuario = JSON.parse(storedUser)
    // Asignar los datos del usuario a las variables
    id.value = usuario.id_usuario // Asignar el id_usuario
    id_rol.value = usuario.id_rol

    if (id_rol.value === 2) {
      nombreProfesor.value = usuario.nombre
    } else {
      nombreProfesor.value = sala.value.nombre
    }
  }
}

// ---------------------FIN CODIGOS PARA CARGAR LOS DATOS DE LA SALA--------------------------------------|

// ---------------------CONFIGURACION PAR EJECUTAR GUARDAR O MODIFICAR------------------------------------|
const guardarOmodificar = async () => {
  // Ejecutar las validaciones antes de guardar o modificar
  enviado.value = true
  errores.value.NombreSala = validarNombre()
  errores.value.password = validarContraNueva()
  errores.value.confirmPassword = validarContraRepetida()

  const tieneErrores = Object.values(errores.value).some(e => e !== '')
  if (tieneErrores) {
    makeToast('Error', 'Por favor corrija los campos marcados.', 'error')
    return
  }

  // guardar o modificar
  if (sala.value.id_sala) {
    // Si existe id_empresa, es una modificación
    modificar()
  } else {
    // Si no existe, es un nuevo registro
    guardar()
  }
}
// ---------------------FIN CONFIGURACION PAR EJECUTAR GUARDAR O MODIFICAR------------------------------------|

// ---------------------CODIGOS PARA GUARDAR LOS DATOS DEL USUARIO------------------------------------------|

const guardar = async () => {
  try {
    // Obtener el token del almacenamiento local
    const token = localStorage.getItem('token') // O usa Vuex o cualquier otro método para obtenerlo

    // Configuración de los encabezados para incluir el token
    const config = {
      headers: {
        Authorization: `Bearer ${token}` // Añadir el token al encabezado
      }
    }

    const response = await axios.post('http://localhost:3000/api/crearsalas', {
      sala: NombreSala.value,
      contra: password.value,
      id_usuario: id.value,
      estado: true // Estado por defecto
    }, config) // enviar el token en la configuración de la solicitud
    // mensajes de éxito
    console.log(response.data)
    // Limpiar el formulario después de guardar
    limpiarFormulario()
    // Quitar la clase 'was-validated' para evitar que se activen las validaciones después de limpiar
    const formElement = document.getElementById('formcrearSala') as HTMLFormElement | null
    if (formElement) {
      formElement.classList.remove('was-validated')
    }
    console.log('Datos enviados al backend para cargar:', sala.value)
    // cerrar el modal
    emit('cerrar') // Emitimos el evento para que el padre lo maneje y cierre el modal
    makeToast('Éxito', 'La sala se guardó correctamente', 'success') // Mensaje de éxito
    emit('actualizartabla') // Emitir evento para actualizar la tabla
  } catch (error) {
    console.log('Datos enviados:', {
      sala: sala.value.sala,
      contra: sala.value.contra,
      id_usuario: sala.value.id_usuario,
      estado: true // Estado por defecto
    })
    console.error('Error al cargar los datos de la sala en la base de datos:', error)
    Swal.fire({
      icon: 'error',
      title: 'Error',
      text: 'No se pudo cargar los datos de la sala.'
    })
  }
}

// ---------------------CODIGOS PARA MODIFICAR LOS DATOS DEL USUARIO------------------------------------------|
const modificar = async () => {
  try {
    // Obtener el token del almacenamiento local
    const token = localStorage.getItem('token') // O usa Vuex o cualquier otro método para obtenerlo

    // Configuración de los encabezados para incluir el token
    const config = {
      headers: {
        Authorization: `Bearer ${token}` // Añadir el token al encabezado
      }
    }

    const response = await axios.put(`http://localhost:3000/api/crearsalas/${sala.value.id_sala}`, {
      id_sala: sala.value.id_sala,
      sala: NombreSala.value,
      contra: password.value,
      id_usuario: id.value,
      estado: true // Estado por defecto
    }, config) // lo mismo con guardar, para enviar el token en la configuración de la solicitud
    // mensajes de éxito
    console.log(response.data.body)
    // Limpiar el formulario después de guardar
    limpiarFormulario()
    // Quitar la clase 'was-validated' para evitar que se activen las validaciones después de limpiar
    const formElement = document.getElementById('formempresa') as HTMLFormElement | null
    if (formElement) {
      formElement.classList.remove('was-validated')
    }
    console.log('Datos enviados al backend para modificar:', sala.value)
    emit('actualizartabla') // Emitir evento para actualizar la tabla
    // cerrar el modal
    emit('cerrar') // Emitimos el evento para que el padre lo maneje y cierre el modal
    makeToast('Éxito', 'La sala se modificó correctamente', 'success')
  } catch (error) {
    console.error('Error al modificar los datos de la sala en la base de datos:', error)
    Swal.fire({
      icon: 'error',
      title: 'Error',
      text: 'No se pudo modificar los datos de la sala.'
    })
  }
}
// --------------------FIN CODIGOS PARA MODIFICAR EL FORMULARIO------------------------------------------|

// --------------------CODIGO PARA INGRESAR A UNA SALA------------------------------------------|

const IngresarSala = async () => {
  try {
    const response = await axios.get(`http://localhost:3000/api/crearsalas/${sala.value.id_sala}`)
    const contraCorrecta = response.data.contra

    if (contraCorrecta === password.value) {
      try {
        // Obtener el token del almacenamiento local
        const token = localStorage.getItem('token') // O usa Vuex o cualquier otro método para obtenerlo

        // Configuración de los encabezados para incluir el token
        const config = {
          headers: {
            Authorization: `Bearer ${token}` // Añadir el token al encabezado
          }
        }

        const response = await axios.post('http://localhost:3000/api/ingresarsalas', {
          id_sala: sala.value.id_sala,
          id_usuario: id.value,
          baja: true, // Estado por defecto
          estado: true // Estado por defecto
        }, config) // enviar el token en la configuración de la solicitud
        // mensajes de éxito
        console.log(response.data)
        // Limpiar el formulario después de guardar
        limpiarFormulario()
        // Quitar la clase 'was-validated' para evitar que se activen las validaciones después de limpiar
        const formElement = document.getElementById('formcrearSala') as HTMLFormElement | null
        if (formElement) {
          formElement.classList.remove('was-validated')
        }
        console.log('Datos enviados al backend para cargar:', sala.value)
        // cerrar el modal
        emit('cerrar') // Emitimos el evento para que el padre lo maneje y cierre el modal
        makeToast('Éxito', 'Ingreso a la sala exitoso', 'success') // Mensaje de éxito
        emit('actualizartabla') // Emitir evento para actualizar la tabla
      } catch (error) {
        console.log('Datos enviados:', {
          sala: sala.value.sala,
          contra: sala.value.contra,
          id_usuario: sala.value.id_usuario,
          estado: true // Estado por defecto
        })
        const err = error as AxiosError<any> // decís que es un error de Axios

        const mensaje: string = err.response?.data?.msg || 'No se pudo ingresar a la sala.'
        Swal.fire({
          icon: 'error',
          title: 'Error',
          text: mensaje
        })
      }
    } else {
      // Contraseña incorrecta
      Swal.fire({
        icon: 'error',
        title: 'Error',
        text: 'La contraseña ingresada es incorrecta.'
      })
    }
  } catch (error) {
    console.error('Error al comparar la contraseña:', error)
    Swal.fire({
      icon: 'error',
      title: 'Error',
      text: 'La contraseña ingresada es incorrecta.'
    })
  }
}
// --------------------FIN DE CODIGO PARA INGRESAR A UNA SALA------------------------------------------|

// ---------------------------CODIGO PARA LIMPAR EL FORMULARIO -------------------------------------------|
const limpiarFormulario = () => {
  NombreSala.value = ''
  password.value = ''
  confirmPassword.value = ''
}
// ---------------------------FIN CODIGO PARA LIMPAR EL FORMULARIO ---------------------------------------|
</script>

<style scoped></style>
