<template>
  <!--
  DOCUMENTACION PARA QUE SE ENTIENDA TODO LO QUE HACE ESTE CODIGO

  ----------------LEER--------------------------------------------

  Componente: ModalCompany.vue
  Descripción: Este componente representa un modal reutilizable para registrar o editar una empresa.
  Funcionalidades:
    - Permite crear una nueva empresa o modificar una existente.
    - Incluye validación de campos (nombre, sigla, periodo).
    - Verifica duplicados antes de guardar.
    - Usa SweetAlert2 para confirmar cancelación.
    - Se comunica con GestCompany.vue padre mediante eventos emitidos.

  ----------------ESTE CODIGO UTILIZA PROPS PARA COMUNICARSE CON GestCompany.vue------------------

  ---¿QUÉ SON LOS Props?
  Los props son como mensajes que un componente en este caso ModalCompany.vue recibe de su “padre” GestCompany.vue

  Sirven para que un componente hijo, por ejemplo, un modal o una tarjeta,
  reciba indicaciones de su padre como por ejemplo necesitá que ese componente hijo muestre información distinta
  según lo que diga el componente padre que lo está usando.

  Entonces… el componente padre GestCompany.vue le manda “props” al componente hijo ModalCompany.vue para decirle:
  ➡️ "Mostrá este título",
  ➡️ "Usá este color",
  ➡️ "Trabajá con estos datos", etc.

  Eso es lo que hace el props, para ese trabajo se utiliza para cambiar Titulos, subtitiulos entre otras cosas que
  voy a explicar

  ----Props recibidos:
    - tituloModal: string -> Título dinámico del modal (cargar/modificar)
    - subtituloModal: string -> Subtítulo dinámico
    - empresa: objeto -> el componente padre GestCompany.vue al hacer click en modificar le pasa los datos de la empresa
                        de la fila seleccionada a travez del props, eso es lo que facilita la modificación

   ----------------ESTE CODIGO UTILIZA EVENTOS EMITIDOS PARA COMUNICARSE CON GestCompany.vue------------------

   ---¿QUÉ SON LOS EVENTOS EMITIDOS?
   Es lo opuesto a los props
   Emitir un evento es la forma que tiene un componente hijo de decirle algo a su padre.

  Así como el padre le manda props al hijo, el hijo puede "emitir" eventos para avisarle cosas al padre, como por ejemplo:
  ➡️ "Se hizo clic en este botón",
  ➡️ "Cambié algo",
  ➡️ "Ya terminé", etc.

  ---Eventos emitidos en este codigo:
    - cerrar -> Indica que se debe cerrar el modal
    - actualizartabla -> Notifica al padre ModalCompany.vue que debe actualizar los datos mostrados

  EN LOS COMENTARIOS SIGUIENTES INTENTARE EXPLICAR PASO A PASO ASI PARA QUE NO HAYA CONFUCIONES
-->
  <!-- Modal de CARGAR UNA NUEVA EMPRESA -->
  <div class="modal fade show d-block" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
      <div class="modal-content text-white p-4" style="background-color: #4F4F75; border-radius: 10px;">

        <!-- Encabezado -->
        <!-- Descripción: en esta parte es donde aparece el primer titulo del Modal
         el {{ tituloModal }} es un props que viene del padre GestCompany.vue y lo que hace es recibir el titulo y
         mostrarlo, si recibe "Modificar" muestra el tutulo de Modificar y si es "Cargar" muestra el titulo de cargar -->
        <div class="modal-header border-bottom">
          <h1 class="modal-title fs-3 fw-semibold" id="staticBackdropLabel"> {{ tituloModal }}</h1>
          <button type="button" class="btn-close bg-white" @click="cerrarModal" aria-label="Close"></button>
          <!-- @click="cerrarModal": es para cerrar el modal y lo que hace es mostrar un mensaje de confirmación y al confirmar
           que si o aceptar, le manda un emit de cerrar (que es un evento emitido) para que GestCompany.vue cierre el modal -->
        </div>

        <!-- FORMULARIO -->
         <!-- Descripción:
           1. @submit.prevent="guardarOmodificar" : esto esta conectado a la funcion para guardar cuando se hace click en el boton guardar se activa
           2. :class="{ 'was-validated': enviado }": este class tiene que ver con las validaciones,
           Definela variable "enviado" en falso para el estado de validación y se activa cada que se hace click en el boton de guardar
           se asegura de que esten bien validados los datos antes de guardarlos  -->
        <form id="formempresa" @submit.prevent="guardarOmodificar" novalidate :class="{ 'was-validated': enviado }">

          <!-- Cuerpo del Modal -->
          <div class="modal-body">
            <!-- {{ subtituloModal }}: tambien es un prps para cambiar el subtitulo del modal segun sea modifcacion o carga -->
            <p class="text-start mb-5">{{ subtituloModal }}</p>

            <div class="row">

              <!-- NOMBRE DE LA EMPRESA -->
               <!-- Descripción:
                1. v-model="empresa.empresa": esta parte es un prps del objeto empresa linea 197, lo que hace es mostrar el dato
                de la tabla, (en este caso el nombre de la empresa) cuando se modifica ademas se utiliza en el momento de guardar
                o modificar tambien
                2. :class="['form-control', { 'is-invalid': errores.empresa }]": esta parte:{ 'is-invalid': errores.empresa }]": el "errores" es una
                variable reactiva: Una variable reactiva es una que Vue está observando, y si cambia su valor, Vue actualiza automáticamente la interfaz
                esta parte se usa para las validaciones, Vue observa el cambio y segun los criterios de validacion muestra un mensaje de muy corto o debe ser numerico o cosas asi -->
              <div class="col-md-6 mb-3 text-start">
                <label for="empresa" class="form-label">Nombre de la Empresa</label>
                <input type="text" id="empresa" name="empresa" v-model="empresa.empresa"
                  :class="['form-control', { 'is-invalid': errores.empresa }]"
                  placeholder="Ingrese el nombre de la empresa" required>
                <div class="invalid-feedback">
                  {{ errores.empresa }} <!-- acá muestra el mensaja -->
                </div>
              </div>

              <!-- Es lo mismo para todos los campos del formulario -->

              <!-- PERIODO -->
              <div class="col-md-6 mb-3 ms-auto text-start">
                <label for="id_periodo" class="form-label">Seleccionar Periodo</label>
                <!-- el select, este por ejemplo trae datos de la base de datos, en el script hay una parte que dice
                 getPeriodos que se encarga de traer los datos de la bd para mostrarlos en este select, ¿y cómo hace eso? -->
                <select id="id_periodo" name="id_periodo" v-model="empresa.id_periodo"
                  :class="['form-select', { 'is-invalid': errores.id_periodo }]" required>
                  <!-- primero, la opcion por defecto siempres es "Seleccionar" con valor 0,
                   (no es posible guardar ésta opcion en la bd) -->
                  <option value="0" disabled selected>Seleccionar</option>
                  <!-- segundo, aquí es como se codifica para que se muestre los periodos de la bd
                    En esta sección del código se utiliza la directiva v-for para iterar sobre una lista de periodos.
                    Por cada elemento del array periodos, se genera dinámicamente una opción en un <select>.
                    v-for="periodo in periodos": recorre cada objeto de la lista periodos.
                    :key="periodo.id_periodo": asigna una clave única a cada elemento,
                    :value="periodo.id_periodo": define el valor que se guarda al seleccionar una opción.
                    En este caso, el ID del periodo.
                    Esto permite al usuario elegir un periodo de una lista desplegable,
                    guardando el id_periodo correspondiente en una variable reactiva para su posterior uso.-->
                  <option v-for="periodo in periodos" :key="periodo.id_periodo" :value="periodo.id_periodo">
                    {{ periodo.nombre_periodo || 'Sin nombre' }} <!-- Mostrar un mensaje si no hay nombre -->
                  </option>
                </select>
                <div class="invalid-feedback">
                  {{ errores.id_periodo }} <!-- acá muestra el mensaja -->
                </div>
              </div>

              <!-- SIGLA -->
              <div class="col-md-6 mb-3 text-start">
                <label for="sigla" class="form-label">Sigla</label>
                <input type="text" id="sigla" name="sigla" v-model="empresa.sigla"
                  :class="['form-control', { 'is-invalid': errores.sigla }]" placeholder="Ej: S.A." required>
                <div class="invalid-feedback">
                  {{ errores.sigla }} <!-- acá muestra el mensaja -->
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
/* En esta sección se importan las librerías y funciones necesarias para que el componente funcione correctamente:

➡️ defineProps: permite recibir propiedades (props) desde el componente padre.
➡️ defineEmits: define los eventos personalizados que el componente puede emitir.
➡️ ref: se usa para declarar variables reactivas.
➡️ onMounted: ejecuta una función automáticamente cuando el componente se monta.

➡️ useRouter (desde vue-router):Permite acceder al enrutador de Vue para navegar entre páginas o rutas desde el código JavaScript.

➡️ Swal (desde sweetalert2):
Se importa esta librería externa para mostrar alertas estilizadas y mensajes interactivos al usuario.

➡️ axios:
Es una librería para hacer solicitudes HTTP (como GET, POST, etc.) al servidor o API. Se usa para conectarse con servicios externos o backend. */

import { defineEmits, onMounted, ref, defineProps } from 'vue'
import { useRouter } from 'vue-router'

// Importar libreria de alertas
import Swal from 'sweetalert2'

// 1ro importar la libreria de Axios
import axios from 'axios'

// -------------------CODIGOS PARA CAMBIAR EL TITULO------------------------------------------|

/* descripción: esta es la forma en la que con los prpos el modal recibe lo que le manda GestCompany.vue */

// Importante para que el titulo cambie segun modificar o cargar
const props = defineProps({
  tituloModal: String,
  subtituloModal: String,
  empresa: Object // para recibir los datos de la empresa desde la tabla
})

const empresa = ref({ ...props.empresa }) // Crear una referencia reactiva a los datos de la empresa

// --------------------------CODIGO DE LOS EVENTOS EMITIDOS ---------------------------------------------|

/* Descripcion: así es como el modal le manda a GestCompany.vue la informacion para que cierr o actualice la tabla */

const emit = defineEmits(['cerrar', 'actualizartabla']) // Emitir eventos al padre para cerrar el modal y actualizar la tabla

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
// ------------------------------- FIN CODIGOS DEL MODAL ----------------------------------------------|

// --------------------------------------VALIDACIONES--------------------------------------------------|

// Definir la variable para el estado de validación
const enviado = ref(false)

// definir reactividad para los errores
const errores = ref({
  empresa: '',
  id_periodo: '',
  sigla: ''
})

// Funciones de validacion por campo

// Empresa
const validarNombreEmpresa = () => {
  const nombre = empresa.value.empresa.trim().replace(/\s+/g, ' ')
  if (!nombre) return 'Por favor ingrese el nombre de la empresa.'
  if (nombre.length < 3) return 'Debe tener al menos 3 caracteres.'
  if (nombre.length > 100) return 'Máximo 100 caracteres.'
  const regex = /^[A-Za-z0-9ÁÉÍÓÚÑáéíóúñ.,&\- ]+$/
  if (!regex.test(nombre)) return 'Contiene caracteres inválidos.'
  empresa.value.empresa = nombre // Limpiar
  return ''
}
// Periodo
const validarPeriodo = () => {
  const valor = empresa.value.id_periodo
  if (!valor || valor === '0') return 'Por favor seleccione un periodo.'
  return ''
}
// Sigla
const validarSigla = () => {
  const sigla = empresa.value.sigla
    .toUpperCase()
    .replace(/\s+/g, '') // quitar espacios
    .replace(/\.{2,}/g, '.') // evitar múltiples puntos seguidos
    .replace(/(^\.|\.$)/g, '') // quitar punto inicial o final extra

  if (!sigla) return 'Por favor, ingrese la sigla.'

  // Validar: una o más letras en mayúscula seguidas de punto, ej: S.A. o C.L.E.Y.
  const regex = /^([A-Z]\.){1,6}$/
  if (!regex.test(sigla + '.')) return 'Formato inválido. El Formato es letra seguido de un punto Ej: S.A.'

  // Guardar sigla normalizada
  empresa.value.sigla = sigla + '.' // aseguramos que tenga punto al final

  return ''
}

// ------------------------------- FIN VALIDACIONES ------------------------------------------------------|

// ------------------CODIGO PARA VERIFICAR QUE NO SE CARGUE DOS VECES LA MISMA EMPRESA--------------------|

/* descripción: estos codigos son para que no se guarde la empresa dos veces o mas veces en la base de datos */

interface DatosEmpresa {
  empresa: string;
  sigla: string;
  id_periodo: number; // eslint-disable-line camelcase
}

const verificarDuplicados = async () => {
  // companyConsult() consulta a la bd las empresas registradas
  const empresasRegistradas: DatosEmpresa[] = await companyConsult()

  const nombreNormalizado = empresa.value.empresa.trim().replace(/\s+/g, ' ').toLowerCase()
  const siglaNormalizada = empresa.value.sigla.trim().toUpperCase()
  const periodo = empresa.value.id_periodo

  // valida que no hayan empresas con el mismo nombre
  const mismoNombre = empresasRegistradas.some(e =>
    e.empresa.trim().replace(/\s+/g, ' ').toLowerCase() === nombreNormalizado
  )
  // valida que no haya datos en la bd con la misma combinancion de empresa-sigla-periodo
  const mismaCombinacion = empresasRegistradas.some((e: DatosEmpresa) =>
    e.empresa.trim().replace(/\s+/g, ' ').toLowerCase() === nombreNormalizado &&
    e.sigla.trim().toUpperCase() === siglaNormalizada &&
    e.id_periodo === periodo
  )

  return { mismoNombre, mismaCombinacion } // envia las validaciones a la funcion de gurdar para verificar antes
}

// consultar empresas en la bd
const companyConsult = async () => {
  try {
    const response = await axios.get('http://localhost:3000/api/empresas')
    return response.data.empresas
  } catch (error) {
    console.error('Error al obtener los datos de la empresa:', error)
  }
}

// -----------------FIN DE CODIGO PARA VERIFICAR QUE NO SE CARGUE DOS VECES LA MISMA EMPRESA--------------|

// ---------------------CONFIGURACION PAR EJECUTAR GUARDAR O MODIFICAR------------------------------------|
const guardarOmodificar = async () => {
  // Ejecutar las validaciones antes de guardar o modificar
  enviado.value = true
  errores.value.empresa = validarNombreEmpresa()
  errores.value.id_periodo = validarPeriodo()
  errores.value.sigla = validarSigla()
  const tieneErrores = Object.values(errores.value).some(e => e !== '')
  if (tieneErrores) {
    makeToast('Error', 'Por favor corrija los campos marcados.', 'error')
    return
  }

  // guardar o modificar
  if (empresa.value.id_empresa) {
    // Si existe id_empresa, es una modificación
    modificar()
  } else {
    // verifiar para que no se carguen duplicados en la bd
    const { mismoNombre, mismaCombinacion } = await verificarDuplicados()
    if (mismaCombinacion) {
      makeToast('Error', 'Ya existe una empresa registrada con la misma sigla y periodo', 'error')
      return
    }

    if (mismoNombre) {
      makeToast('Error', 'Ya existe una empresa registrada con ese nombre.', 'error')
      errores.value.empresa = 'El nombre de la empresa ya está en uso.'
      return
    }
    // Si no existe, es un nuevo registro
    guardar()
  }
}
// ---------------------HASTA ACÁ LA CONFIGURACION PAR EJECUTAR GUARDAR O MODIFICAR-----------------------|

// -----------------------------CONFIGURACION DE AXIOS----------------------------------------------------|
// router para elegir donde volver a la hora de guardar
const router = useRouter()

// ------------------------FUNCION PARA GUARDAR LA EMPRESA EN LA BD---------------------------------------|

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

    const response = await axios.post('http://localhost:3000/api/empresas', {
      empresa: empresa.value.empresa,
      sigla: empresa.value.sigla,
      id_periodo: empresa.value.id_periodo,
      estado: true // Estado por defecto
    }, config) // enviar el token en la configuración de la solicitud
    // mensajes de éxito
    console.log(response.data)
    router.push('/company') // Redirigir a la página de empresas después de guardar
    // Limpiar el formulario después de guardar
    limpiarFormulario()
    // Quitar la clase 'was-validated' para evitar que se activen las validaciones después de limpiar
    const formElement = document.getElementById('formempresa') as HTMLFormElement | null
    if (formElement) {
      formElement.classList.remove('was-validated')
    }
    console.log('Datos enviados al backend para cargar:', empresa.value)
    // cerrar el modal
    emit('cerrar') // Emitimos el evento para que el padre lo maneje y cierre el modal
    makeToast('Éxito', 'La empresa se guardó correctamente', 'success') // Mensaje de éxito
    emit('actualizartabla') // Emitir evento para actualizar la tabla
  } catch (error) {
    console.log('Datos enviados:', {
      empresa: empresa.value.empresa,
      sigla: empresa.value.sigla,
      id_periodo: empresa.value.id_periodo,
      estado: true
    })
    console.error('Error al cargar los datos de la empresa en la base de datos:', error)
    Swal.fire({
      icon: 'error',
      title: 'Error',
      text: 'No se pudo cargar los datos de la empresa.'
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

    const response = await axios.put(`http://localhost:3000/api/empresas/${empresa.value.id_empresa}`, {
      empresa: empresa.value.empresa,
      sigla: empresa.value.sigla,
      id_periodo: empresa.value.id_periodo
    }, config) // lo mismo con guardar, para enviar el token en la configuración de la solicitud
    // mensajes de éxito
    console.log(response.data.body)
    router.push('/company') // Redirigir a la página de empresas después de guardar
    // Limpiar el formulario después de guardar
    limpiarFormulario()
    // Quitar la clase 'was-validated' para evitar que se activen las validaciones después de limpiar
    const formElement = document.getElementById('formempresa') as HTMLFormElement | null
    if (formElement) {
      formElement.classList.remove('was-validated')
    }
    console.log('Datos enviados al backend para modificar:', empresa.value)
    emit('actualizartabla') // Emitir evento para actualizar la tabla
    // cerrar el modal
    emit('cerrar') // Emitimos el evento para que el padre lo maneje y cierre el modal
    makeToast('Éxito', 'La empresa se modificó correctamente', 'success')
  } catch (error) {
    console.error('Error al modificar los datos de la empresa en la base de datos:', error)
    Swal.fire({
      icon: 'error',
      title: 'Error',
      text: 'No se pudo cargar los datos de la empresa.'
    })
  }
}

// ------------------------FIN FUNCION PARA MODIFICAR LA EMPRESA EN LA BD---------------------------------|

// ----------------------------OBTENER PERIODOS DE LA BD PARA EL SELECT-----------------------------------|

// Definir la estructura del tipo Periodo
interface Periodo {
  id_periodo: number // eslint-disable-line camelcase
  nombre_periodo: string // eslint-disable-line camelcase
}

// Lista de períodos obtenidos de la BD
const periodos = ref<Periodo[]>([])

const getPeriodoByDB = async () => {
  try {
    const response = await axios.get('http://localhost:3000/api/periodos')
    console.log('Datos obtenidos de la API para periodos:', response.data.periodos)
    periodos.value = response.data.periodos // Almacenar la lista de períodos
  } catch (error) {
    console.error(error) // Manejo de errores
    makeToast('Error', 'Error al conseguir los roles', 'error')
  }
}

// Llamar a la función al montar el componente
onMounted(() => {
  getPeriodoByDB()
})

// --------------------------FIN DE OBTENER PERIODOS DE LA BD---------------------------------------------|

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

// ---------------------------CODIGO PARA LIMPAR EL FORMULARIO -------------------------------------------|
const limpiarFormulario = () => {
  Object.assign(empresa.value, {
    empresa: '',
    sigla: '',
    id_periodo: 0
  })
}
// ---------------------------FIN CODIGO PARA LIMPAR EL FORMULARIO ---------------------------------------|

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
