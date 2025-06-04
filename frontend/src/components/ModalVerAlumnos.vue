<template>
  <!-- MODAL REGISTRAR AS -->
  <div class="modal fade show d-block" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl">
      <div class="modal-content text-white p-4" style="background-color: #4F4F75; border-radius: 10px;">

        <!-- TITULO -->
        <div class="modal-header border-bottom">
          <h1 class="modal-title fs-3 fw-semibold" id="staticBackdropLabel">LISTA DE ALUMNOS</h1>
          <button type="button" class="btn-close bg-white" @click="cerrarModal" aria-label="Close"></button>
        </div>

        <!-- FORMULARIO -->
        <form action="">
          <!-- CUERPO DEL MODAL -->
          <div class="modal-body">

            <div class="row">
              <!-- SALA DE CLASE -->
              <div class="col-md-6 mb-3 text-start w-100">
                <label for="nombre_sala" class="form-label">Sala de Clase</label>
                <input v-model="sala.sala" type="text" class="form-control" id="nombre_sala" name="nombre_sala"
                  readonly>
              </div>
              <!-- titulo -->
              <p class="text-center modal-title fs-5 p-2 fw-semibold">Asignar Empresa al Alumno</p>
              <!-- Empresa -->
              <div class="col-md-4 mb-4 text-start">
                <label for="nombre_empresa" class="form-label">Empresa</label>
                <select v-model="idEmpresaSeleccionada" class="form-select" name="nombre_empresa" id="nombre_empresa">
                  <option value="0" disabled selected>Seleccionar</option>
                  <option v-for="item in empresa" :key="item.id_empresa" :value="item.id_empresa">
                    {{ item.nombre || 'Sin nombre' }}
                  </option>
                </select>
              </div>
              <!-- NRO CEDULA -->
              <div class="col-md-2 mb-4 text-start">
                <label for="cedula" class="form-label">Nº Cedula</label>
                <input v-model="cedula" type="text" class="form-control" id="cedula" name="cedula" readonly>
              </div>
              <!-- Alumno -->
              <div class="col-md-5 mb-4 text-start">
                <label for="nombreAlumno" class="form-label">Alumno</label>
                <input v-model="nombreAlumno" type="text" class="form-control" id="nombreAlumno" name="nombreAlumno"
                  readonly>
              </div>
              <!-- BOTON DE AGREGAR -->
              <div class="col-md-1 mb-4 me d-flex align-items-end">
                <button type="button" class=" btn btn-warning" id="" @click="asignarEmpresa">Agregar</button>
              </div>
              <!-- titulo -->
              <p class="text-center modal-title fs-5 p-2 fw-semibold">Lista de Alumnos</p>
              <!-- TABLA -->
              <div class="col-md-12 mb-3">
                <div class="table-container table table-hover table-bordered shadow-sm">
                  <DataTable :options="tableOptions" id="tableAsiento" :key="datatableKey"
                    class="display table thead th nowrap table-striped table-hover table-bordered" cellspacing="0"
                    width="100%">
                    <thead>
                      <tr>
                        <th scope="col">Item</th>
                        <th scope="col">Cedula</th>
                        <th scope="col">Alumno</th>
                        <th scope="col">Empresa Asignada</th>
                        <th scope="col">Eliminar</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr v-for="item in items" :key="item.id_detalleSala" @click="seleccionarAlumno(item)">
                        <td>{{ item.id_detalleSala }}</td>
                        <td>{{ item.cedula }}</td>
                        <td>{{ item.alumno }}</td>
                        <td>{{ item.nombre_empresa }}</td>
                        <td>
                          <!-- <button class="btn btn-edit" @click="eliminar(item, 'eliminar')">
                                                      <Icon icon="mdi:pencil" width="20" height="20" />
                                                    </button> -->
                        </td>
                      </tr>
                    </tbody>
                  </DataTable>
                </div>
              </div>
            </div>

          </div>
          <!-- PIE DEL MODAL -->
          <div class="modal-footer border-0">
            <button type="button" class=" btn btn-danger" id="">Cerrar</button>
          </div>

        </form>

      </div>
    </div>
  </div>
</template>

<script lang="ts" setup>
// importaciones de vue
import { defineEmits, onMounted, ref, defineProps } from 'vue'

// Importar libreria de alertas
import Swal from 'sweetalert2'

// 1ro importar la libreria de Axios
import axios, { AxiosError } from 'axios'

// importar el datatable
import jszip from 'jszip'
import DataTable from 'datatables.net-vue3'
import DataTablesCore from 'datatables.net-bs5'
import 'datatables.net-autofill-bs5'
import 'datatables.net-buttons-bs5'
import 'datatables.net-buttons/js/buttons.html5.mjs'
import 'datatables.net-buttons/js/buttons.print.mjs'
// import DateTime from 'datatables.net-datetime'
import 'datatables.net-responsive-bs5'
import 'datatables.net-select-bs5'

// ----------------------------CODIGO DEL DATATABLE----------------------------------------------------------|
DataTablesCore.Buttons.jszip(jszip)
DataTable.use(DataTablesCore)

// el datatableKey es para que se vuelva a cargar el datatable cada vez que se cambia el valor de la variable
const datatableKey = ref(0)

const tableOptions = ref({
  dom: '<"top d-flex justify-content-between align-items-center"lf>rt<"bottom d-flex justify-content-between"ip>',
  language: {
    // desabilitia la opcion de buscar en la tabla
    zeroRecords: 'No se encontraron resultados',
    lengthMenu: 'Mostrar _MENU_ registros por página',
    info: 'Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros',
    infoEmpty: 'Mostrando registros del 0 al 0 de un total de 0 registros',
    infoFiltered: '(filtrado de un total de _MAX_ registros)',
    paginate: {
      first: 'Primero',
      previous: 'Anterior',
      next: 'Siguiente',
      last: 'Último'
    },
    buttons: {
      copyTitle: 'Copiado al portapapele',
      copySuccess: {
        1: 'Se ha copiado 1 registro al portapapeles',
        _: 'Se han copiado %d registros al portapapeles'
      }
    }
  },
  buttons: [
    'copy', 'csv', 'excel', 'pdf', 'print' // Botones de exportación
  ]
})
// ----------------------------HASTA ACÁ EL DATATABLE------------------------------------------------------------|

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
    title: '¿Está seguro de que desea cancelar?',
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

// -----------DEFINCION DE LA INTERFAZ PARA LOS DATOS ---------------------------------------------------|

// Importante para que el titulo cambie segun modificar o cargar
const props = defineProps({
  sala: Object // para recibir los datos de la empresa desde la tabla
})

const sala = ref({ ...props.sala }) // Crear una referencia reactiva a los datos de la sala

interface DetalleSala {
  id_detalleSala: number // eslint-disable-line camelcase
  cedula: string
  alumno: string
  nombre_empresa: string // eslint-disable-line camelcase
}

// variable para almacenar los datos
const items = ref<DetalleSala[]>([])
// -------HASTA ACÁ DEFINCION DE LA INTERFAZ PARA LOS DATOS -------------------------------------------------|

// FUNCION DE LA PETICION CON AXIOS
const getDatos = async () => {
  try {
    const response = await axios.get(`http://localhost:3000/api/ingresarsalas/alumnos/${sala.value.id_sala}`) // Obtener los datos de la sala
    items.value = response.data.detallesala.map((detallesala: any) => ({
      ...detallesala,
      id_detalleSala: detallesala.Usuario ? detallesala.Usuario.id_usuario : 'Desconocido',
      cedula: detallesala.Usuario ? detallesala.Usuario.cedula : 'Desconocido',
      alumno: detallesala.Usuario ? detallesala.Usuario.nombre : 'Desconocido'
    })) // Asignar los datos a la variable items
    // Destruir DataTable si ya existe
    datatableKey.value++
  } catch (error) {
    console.error('Error al obtener los datos de la sala:', error)
    Swal.fire({
      icon: 'error',
      title: 'Error',
      text: 'No se pudo cargar los datos de las salas.'
    })
  }
}

onMounted(() => {
  getDatos() // Luego obtiene los datos
})
// ----------------------------OBTENER EMPRESAS DE LA BD PARA EL SELECT-----------------------------------|

// Definir la estructura
interface Empresas {
  id_empresa: number // eslint-disable-line camelcase
  nombre: string // eslint-disable-line camelcase
}

// Lista de Sucursal obtenidos de la BD
const empresa = ref<Empresas[]>([])
const idEmpresaSeleccionada = ref<number | null>(null)

const getByDB = async () => {
  try {
    const response = await axios.get('http://localhost:3000/api/empresas')
    console.log('Datos obtenidos de la API para empresas:', response.data)
    empresa.value = response.data.empresas
  } catch (error) {
    console.error(error) // Manejo de errores
    makeToast('Error', 'Error al conseguir las empresas', 'error')
  }
}

// Llamar a la función al montar el componente
onMounted(() => {
  getByDB()
})
// --------------------------CARGAR DATOS DE LA TABLA AL IMPUT---------------------------------------------|
const id = ref('')
const cedula = ref('')
const nombreAlumno = ref('')

const seleccionarAlumno = (item: any) => {
  id.value = item.id_detalleSala
  cedula.value = item.cedula
  nombreAlumno.value = item.alumno
}

// --------------------------FIN DE OBTENER EMPRESAS DE LA BD---------------------------------------------|
/* const recargartabla = () => {
  axios.get(`http://localhost:3000/api/empresas/${id.value}`)
    .then(response => {
      console.log('Respuesta de empresa:', response.data) // 👈 Ver qué estructura tiene

      const empresa = response.data.empresa || response.data // Depende cómo devuelva el backend

      if (!empresa) {
        throw new Error('No se encontró la empresa')
      }

      items.value = [{
        ...empresa,
        nombre_empresa: empresa.nombre || 'Desconocido'
      }] // ⚠️ es un solo objeto, así que usamos un array con un solo elemento

      datatableKey.value++
    })
} */

// --------------------------ASIGNAR LA EMPRESA--------------------------------------------|
const asignarEmpresa = async () => {
  try {
    // Obtener el token del almacenamiento local
    const token = localStorage.getItem('token') // O usa Vuex o cualquier otro método para obtenerlo

    // Configuración de los encabezados para incluir el token
    const config = {
      headers: {
        Authorization: `Bearer ${token}` // Añadir el token al encabezado
      }
    }

    const response = await axios.patch(`http://localhost:3000/api/empresas/actualizar/${idEmpresaSeleccionada.value}`, {
      id_usuario: id.value
    }, config) // enviar el token en la configuración de la solicitud
    makeToast('Éxito', 'Empresa Asignada', 'success') // Mensaje de éxito
    // Actualizar la tabla después de asignar la empresa
    // recargartabla()
  } catch (error) {
    const err = error as AxiosError<any> // decís que es un error de Axios
    const mensaje: string = err.response?.data?.msg || 'No se pudo asignar la empresa.'
    Swal.fire({
      icon: 'error',
      title: 'Error',
      text: mensaje
    })
  }
}

</script>

<style scoped>
/* del datatable */
@import url('datatables.net-bs5');
@import url('datatables.net-autofill-bs5');
@import url('datatables.net-buttons-bs5');
@import url('datatables.net-responsive-bs5');
@import url('datatables.net-select-bs5');

/* Estilo de la tabla */
.table {
  border-radius: 8px;
  /* Bordes ligeramente redondeados */
  overflow: hidden;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  /* Sombra más sutil */
  border: 1px solid #dee2e6;
  /* Borde para un diseño limpio */
}

.table th {
  background-color: #4F4F75;
  /* Fondo oscuro para encabezados */
  color: #4F4F75;
  text-align: center;
  font-weight: 600;
}

.table td {
  text-align: center;
  /* Centrar el contenido */
  vertical-align: middle;
  /* Alinear verticalmente */
  color: #495057;
}

.table td.number {
  text-align: center;
}

.table-striped tbody tr:nth-of-type(odd) {
  background-color: #f8f9fa;
  /* Color alternativo más claro */
}

.table-hover tbody tr:hover {
  background-color: #e2e6ea;
  /* Color al pasar el mouse más sutil */
}

.table-bordered {
  border: 1px solid #4F4F75;
  /* Bordes definidos */
}

.table thead th {
  border-bottom: 2px solid #dee2e6;
  /* Borde inferior más grueso */
}
</style>
