<template>
  <!-- Modal de CARGAR UNA NUEVA EMPRESA -->
  <div class="modal fade show d-block" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
      <div class="modal-content text-white p-4" style="background-color: #4F4F75; border-radius: 10px;">
        <!-- Encabezado -->
        <div class="modal-header border-bottom">
          <h1 class="modal-title fs-3 fw-semibold" id="staticBackdropLabel"> {{ tituloModal }}</h1>
          <button type="button" class="btn-close bg-white" @click="cerrarModal" aria-label="Close"></button>
        </div>
        <form action="#" id="formusuario" class="needs-validation" @submit.prevent="guardarOmodificar" novalidate>
          <!-- Cuerpo del Modal -->
          <div class="modal-body">
            <p class="text-start mb-5">{{ subtituloModal }}</p>
            <div class="row">

              <!-- cedula -->
              <div class="col-md-6 mb-3 text-start">
                <label for="cedula" class="form-label">Nº de cedula</label>
                <input type="text" id="cedula" v-model="usuario.cedula" :class="['form-control', { 'is-invalid': errores.cedula }]" maxlength="10"
                placeholder="Ingrese el CI" inputmode="numeric" @input="soloNumeros('cedula', 10)"
                required>
                <div class="invalid-feedback">
                  {{ errores.cedula }}
                </div>
              </div>

              <!-- ROL -->
              <div class="col-md-6 mb-3 ms-auto text-start">
                <label for="rol" class="form-label">Seleccionar Rol</label>
                <select id="rol" name="rol" v-model="usuario.id_rol" :class="['form-control', { 'is-invalid': errores.id_rol }]" required>
                  <option value="0" disabled>Seleccionar</option>
                  <option v-for="roles in rolesuser" :key="roles.id_rol" :value="roles.id_rol">
                    {{ roles.nombre_rol || 'Sin rol' }} <!-- Mostrar un mensaje si no hay nombre -->
                  </option>
                </select>
                <div class="invalid-feedback">
                  {{ errores.id_rol }}
                </div>
              </div>

              <!-- NOMBRE -->
              <div class="col-md-6 mb-3 text-start">
                <label for="nombre" class="form-label">Nombre Completo</label>
                <input type="text" id="nombre" v-model="usuario.nombre" :class="['form-control', { 'is-invalid': errores.nombre }]"
                  placeholder="Ingrese el nombre de usuariuo" required>
                <div class="invalid-feedback">
                  {{ errores.nombre }}
                </div>
              </div>

              <!-- TELEFONO -->
              <div class="col-md-6 mb-3 text-start">
                <label for="telefono" class="form-label">Nº de telefono</label>
                <input type="text" id="telefono" v-model="usuario.telefono" :class="['form-control', { 'is-invalid': errores.telefono }]"
                  placeholder="Ingrese el numero"  @input="soloNumerostelefono('telefono', 10)" required>
                <div class="invalid-feedback">
                  {{ errores.telefono }}
                </div>
              </div>

              <!-- CORREO -->
              <div class="col-md-6 mb-3 text-start">
                <label for="correo" class="form-label">Correo</label>
                <input type="email" id="correo" v-model="usuario.correo" :class="['form-control', { 'is-invalid': errores.correo }]"
                  placeholder="Ej: usuario@gmail.com" required>
                <div class="invalid-feedback">
                  {{ errores.correo }}
                </div>
              </div>

            </div>
          </div>
          <!-- Pie del Modal -->
          <div class="modal-footer border-0">
            <button type="button" class="btn btn-danger" @click="cerrarModal">Cancelar</button>
            <button type="submit" class="btn btn-success" id="btnGuardar">Guardar</button>
          </div>
        </form>
      </div>
    </div>
  </div>

</template>

<script lang="ts" setup>
// IMPORTACIONES
import { defineEmits, onMounted, ref, defineProps } from 'vue'
import { useRouter } from 'vue-router'

// Importar libreria de alertas
import Swal from 'sweetalert2'

// ----------------- IMPORTAR CON EL SERVIDOR CON AXIOS------------------------

// 1ro importar la libreria de Axios
import axios from 'axios'

// Definir el evento `cerrar` que el padre escuchará
const emit = defineEmits(['cerrar', 'actualizartabla'])

// Importante para que el titulo cambie segun modificar o cargar
const props = defineProps({
  tituloModal: String,
  subtituloModal: String,
  usuario: Object // para recibir los datos del usuario desde la tabla
})

const usuario = ref({ ...props.usuario }) // Crear una referencia reactiva a los datos de la empresa

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

/* -------------------VALIDACIONES---------------------- */
// Validar formulario

const enviado = ref(false)

const errores = ref({
  cedula: '',
  id_rol: '',
  nombre: '',
  telefono: '',
  correo: ''
})

const validarCedula = () => {
  const ced = usuario.value.cedula.trim()
  if (!ced) return 'Por favor, ingrese el número de cédula.'
  if (!/^\d{6,10}$/.test(ced)) return 'La cédula debe contener entre 6 y 10 dígitos numéricos.'
  usuario.value.cedula = ced
  return ''
}

const soloNumeros = (campo: string, maxLong: number) => {
  usuario.value[campo] = usuario.value[campo]
    .replace(/\D/g, '') // elimina todo lo que no es dígito
    .slice(0, maxLong) // recorta si se pasa del máximo
}
const soloNumerostelefono = (campo: string, maxLong: number) => {
  usuario.value[campo] = usuario.value[campo]
    .replace(/\D/g, '') // elimina todo lo que no es dígito
    .slice(0, maxLong) // recorta si se pasa del máximo
}

const validarRol = () => {
  if (!usuario.value.id_rol || usuario.value.id_rol === 0) {
    return 'Por favor, seleccione un rol.'
  }
  return ''
}

const validarNombre = () => {
  const nombre = usuario.value.nombre.trim().replace(/\s+/g, ' ')
  if (!nombre) return 'Por favor, ingrese el nombre.'
  if (nombre.length < 3) return 'El nombre debe tener al menos 3 caracteres.'
  if (!/^[A-Za-zÁÉÍÓÚÑáéíóúñ ]+$/.test(nombre)) return 'Solo se permiten letras.'
  usuario.value.nombre = nombre
  return ''
}

const validarTelefono = () => {
  const tel = usuario.value.telefono.trim()
  if (!tel) return 'Por favor, ingrese el número de teléfono.'
  if (!/^\d{8,15}$/.test(tel)) return 'El teléfono debe contener entre 8 y 15 dígitos.'
  usuario.value.telefono = tel
  return ''
}

const validarCorreo = () => {
  const correo = usuario.value.correo.trim()
  if (!correo) return 'Por favor, ingrese el correo.'
  const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
  if (!regex.test(correo)) return 'Formato de correo inválido.'
  usuario.value.correo = correo.toLowerCase()
  return ''
}

// ------------------------- FIN VALIDACIONES ------------------------|

// -----------------------VERIFICAR DUPLICADOS -----------------------|

interface UsuarioDatos {
  id_usuario: number // eslint-disable-line camelcase
  cedula: string
  correo: string
}

const verificarUsuarioDuplicado = async () => {
  try {
    const { data } = await axios.get('http://localhost:3000/api/usuarios')
    const usuariosRegistrados = data.usuarios

    const cedula = usuario.value.cedula.trim()
    const correo = usuario.value.correo.trim().toLowerCase()

    const cedulaExistente = usuariosRegistrados.some((u: UsuarioDatos) => u.cedula === cedula)
    const correoExistente = usuariosRegistrados.some((u: UsuarioDatos) => u.correo.toLowerCase() === correo)

    return { cedulaExistente, correoExistente }
  } catch (error) {
    console.error('Error al consultar usuarios:', error)
    return { cedulaExistente: false, correoExistente: false }
  }
}

// ----------------------FIN VERIFICAR DUPLICADOS --------------------|

// ---------------------CONFIGURACION PAR EJECUTAR GUARDAR O MODIFICAR------------------------------------|
const guardarOmodificar = async () => {
  enviado.value = true
  errores.value.cedula = validarCedula()
  errores.value.id_rol = validarRol()
  errores.value.nombre = validarNombre()
  errores.value.telefono = validarTelefono()
  errores.value.correo = validarCorreo()

  const tieneErrores = Object.values(errores.value).some(e => e !== '')
  if (tieneErrores) {
    makeToast('Error', 'Por favor corrija los campos marcados.', 'error')
    return
  }

  if (usuario.value.id_usuario) {
    modificar()
  } else {
    const { cedulaExistente, correoExistente } = await verificarUsuarioDuplicado()
    if (cedulaExistente) {
      errores.value.cedula = 'Ya existe un usuario con esta cédula.'
      makeToast('Error', 'Cédula ya registrada.', 'error')
      return
    }
    if (correoExistente) {
      errores.value.correo = 'Ya existe un usuario con este correo.'
      makeToast('Error', 'Correo ya registrado.', 'error')
      return
    }

    guardar()
  }
}

// ---------------------HASTA ACÁ LA CONFIGURACION PAR EJECUTAR GUARDAR O MODIFICAR-----------------------|

// -----------------CONFIGURACION DE AXIOS-------------------|
// router para elegir donde volver a la hora de guardar
const router = useRouter()

// ------------------------FUNCION PARA GUARDAR LA EMPRESA EN LA BD---------------------------------------|

const guardar = async () => {
  // Obtener el token del almacenamiento local
  const token = localStorage.getItem('token') // O usa Vuex o cualquier otro método para obtenerlo

  // Configuración de los encabezados para incluir el token
  const config = {
    headers: {
      Authorization: `Bearer ${token}` // Añadir el token al encabezado
    }
  }

  try {
    const response = await axios.post('http://localhost:3000/api/usuarios', {
      cedula: usuario.value.cedula,
      nombre: usuario.value.nombre,
      telefono: usuario.value.telefono,
      correo: usuario.value.correo,
      id_rol: usuario.value.id_rol,
      contra: usuario.value.contra,
      estado: true
    }, config)
    // mensajes de éxito
    console.log(response.data)
    router.push('/user') // Redirigir a la página de usuario después de guardar
    // Limpiar el formulario después de guardar
    limpiarFormulario()
    const formElement = document.getElementById('formusuario') as HTMLFormElement | null
    if (formElement) {
      formElement.classList.remove('was-validated') // Quitar la clase 'was-validated' para evitar que se activen las validaciones después de limpiar
    }
    console.log('Datos enviados al backend para cargar usuario:', usuario.value)
    // cerrar el modal
    emit('cerrar') // Emitimos el evento para que el padre lo maneje y cierre el modal
    makeToast('Éxito', 'El usuario se guardó correctamente', 'success')
    emit('actualizartabla')
  } catch (error) {
    console.error('Error al cargar los datos del usuario en la base de datos:', error)
    Swal.fire({
      icon: 'error',
      title: 'Error',
      text: 'No se pudo cargar los datos del usuario.'
    })
  }
}

// ---------------------------FIN FUNCION PARA GUARDAR LA EMPRESA EN LA BD--------------------------------|

// ------------------------FUNCION PARA MODIFICAR LA EMPRESA EN LA BD---------------------------------------|

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
    const response = await axios.put(`http://localhost:3000/api/usuarios/${usuario.value.id_usuario}`, {
      nombre: usuario.value.nombre,
      cedula: usuario.value.cedula,
      correo: usuario.value.correo,
      id_rol: usuario.value.id_rol,
      telefono: usuario.value.telefono
    }, config)
    // mensajes de éxito
    console.log(response.data)
    router.push('/user') // Redirigir a la página de empresas después de guardar
    // Limpiar el formulario después de guardar
    limpiarFormulario()
    const formElement = document.getElementById('formusuario') as HTMLFormElement | null
    if (formElement) {
      formElement.classList.remove('was-validated') // Quitar la clase 'was-validated' para evitar que se activen las validaciones después de limpiar
    }
    console.log('Datos enviados al backend para modificar el usuario:', usuario.value)

    // Actualizar el usuario modificado en la lista local
    emit('actualizartabla')
    // cerrar el modal
    emit('cerrar') // Emitimos el evento para que el padre lo maneje y cierre el modal
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

// ------------------------FIN FUNCION PARA MODIFICAR LA EMPRESA EN LA BD-----------------------------------|

// ----------------------------OBTENER PERIODOS DE LA BD--------------------------------------------------|

// Definir la estructura del tipo rol
interface Rol {
  id_rol: number // eslint-disable-line camelcase
  nombre_rol: string // eslint-disable-line camelcase
}

// Lista de períodos obtenidos de la BD
const rolesuser = ref<Rol[]>([])

const getRolByDB = async () => {
  try {
    const response = await axios.get('http://localhost:3000/api/roles')
    console.log('Datos obtenidos de la API para roles:', response.data)
    rolesuser.value = response.data.roles // Almacenar la lista de períodos
  } catch (error) {
    console.error(error) // Manejo de errores
    makeToast('Error', 'Error al conseguir los roles', 'error')
  }
}

// Llamar a la función al montar el componente
onMounted(() => {
  getRolByDB()
})

// --------------------------FIN DE OBTENER PERIODOS DE LA BD---------------------------------------------|

// ---------------------------CODIGO PARA LIMPAR EL FORMULARIO -------------------------------------------|
const limpiarFormulario = () => {
  Object.assign(usuario.value, {
    id: 0,
    cedula: 0,
    nombre: '',
    telefono: '',
    correo: '',
    id_rol: 0, // eslint-disable-line camelcase
    estado: ''
  })
}
// ---------------------------FIN CODIGO PARA LIMPAR EL FORMULARIO --------------------------------------------------

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

</script>

<style scoped>
.bg-color {
  background-color: #4F4F75;
  color: #ffff;
}

.btn-color {
  color: #ffff;
}
</style>
