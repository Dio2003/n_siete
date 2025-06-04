<template>
    <div class="ingresarsala">
        <!-- Componentes -->
        <Navbar />
        <Siderbar />
        <!-- MODAL -->
        <ModalIngresar :sala="selectedItemIngresar" v-if="mostrarModal" @cerrar="cerrarModal" :tituloModal="tituloModal" :mostrarConfirmar="false" :mostrarCrear="false" :deshabilitarCampos="true"/>
        <ModalMisSalas v-if="mostrarModalMisSalas" @cerrar="cerrarModalMisSalas"/>
        <!-- Contenido Principal -->
        <main class="col-md-9 ms-sm-auto  col-lg-10 px-md-4 overflow-auto">
            <!-- TITULO -->
            <div
                class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h2>Ingresar a sala de estudio</h2>
            </div>

            <!-- SECCION DE BUSQUEDA Y FILTRO -->
            <div class="d-flex flex-wrap align-items-center gap-2 mb-3 pt-3 pb-3 color-div pe-3 ps-3 rounded shadow-sm">

                <!-- Grupo de búsqueda -->
                <div class="d-flex align-items-center gap-2 flex-grow-1">
                    <span class="input-group-text">
                        <Icon icon="mdi:search" width="20" height="20" />
                    </span>
                    <!-- cuadro de busqueda -->
                    <input type="text" class="form-control fixed-width-input color-input" id="customSearchInput"
                        placeholder="Seleccione un filtro para buscar" />

                    <!-- Botón de filtro -->
                    <button class="btn btn-outline-secondary" data-bs-toggle="dropdown" aria-expanded="false">
                        Filtros
                        <Icon icon="mdi:filter" width="24" height="24" />
                    </button>
                    <ul class="dropdown-menu" aria-labelledby="dropdown03" id="filterDropdown">
                        <li><a class="dropdown-item" data-col="1">Nombre</a></li>
                        <li><a class="dropdown-item" data-col="2">Profesor</a></li>
                    </ul>
                </div>

                <!-- Botón de Ingresar a sala-->
                <div class="btn-toolbar">
                    <div class="btn-group w-100 w-md-auto">
                        <button type="button" class="btn btn-sm btn-secondary" @click="abrirModalMisSalas()">
                            Mis Salas
                            <Icon icon="mdi:plus" width="24" height="24" />
                        </button>
                    </div>
                </div>

            </div>

            <!-- CODIGOS DE LA TABLA -->
            <div class="body table-responsive  table table-hover table-bordered shadow-sm">
                <div>
                    <DataTable :options="tableOptions" id="tableIngresar" :key="datatableKey"
                        class="display table pretty thead th responsive nowrap table-striped table-hover table-bordered"
                        cellspacing="0" width="100%">
                        <thead>
                            <tr>
                                <th scope="col">N°</th>
                                <th scope="col">SALA</th>
                                <th scope="col">PROFESOR</th>
                                <th scope="col">Ingresar</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="item in items" :key="item.id_sala">
                                <td>{{ item.id_sala}}</td>
                                <td>{{ item.sala}}</td>
                                <td>{{ item.nombre }}</td> <!-- este traer el nombre del profesor de la tabla de usuarios -->
                                <td>
                                    <button class="btn btn-edit" @click="editar(item, 'ingresar')">
                                      <Icon icon="mdi:pencil" width="20" height="20" />
                                    </button>
                                </td>
                            </tr>
                        </tbody>
                    </DataTable>
                </div>
            </div>

        </main>
    </div>
</template>

<script lang="ts" setup>
// ----------------------IMPORTACIONES----------------------
// importaciones de vue
import { ref, onMounted } from 'vue'

import Navbar from '@/components/NavBar.vue'
import Siderbar from '@/components/SiderBar.vue'

// importar el modal de cuentas
import ModalIngresar from '@/components/ModalCrearsala.vue'
import ModalMisSalas from '@/components/ModalMisSalas.vue'

// Codigo para los iconos
import { Icon } from '@iconify/vue'

// 1ro importar la libreria de Axios
import axios from 'axios'

// Importar libreria de alertas
import Swal from 'sweetalert2'

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
  dom: '<"top d-flex justify-content-between align-items-center"l>rt<"bottom d-flex justify-content-between"ip>',
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

// -----------DEFINCION DE LA INTERFAZ PARA LOS DATOS ---------------------------------------------------|

interface Detallesala {
  id_sala: number // eslint-disable-line camelcase
  sala: string
  nombre: string // del profesor
}

// variable para almacenar los datos
const items = ref<Detallesala[]>([])
// -------HASTA ACÁ DEFINCION DE LA INTERFAZ PARA LOS DATOS -------------------------------------------------|

// -------HASTA ACÁ DEFINCION DE LA INTERFAZ PARA LOS DATOS -------------------------------------------------|

// FUNCION DE LA PETICION CON AXIOS
const getDatos = async () => {
  try {
    const response = await axios.get('http://localhost:3000/api/crearsalas')
    // Asignar los datos a la variable items
    items.value = response.data.salas.map((sala: any) => ({
      ...sala,
      nombre: sala.Usuario ? sala.Usuario.nombre : 'Desconocido'
    }))
    console.log('Datos de la sala:', response.data.salas) // Verificar los datos obtenidos
    // Destruir DataTable si ya existe
    datatableKey.value++
  } catch (error) {
    console.error('Error al obtener los datos de la sala:', error)
    Swal.fire({
      icon: 'error',
      title: 'Error',
      text: 'No se pudo cargar los datos de la sala.'
    })
  }
}

onMounted(() => {
  getDatos() // Luego obtiene los datos
})

// -----------------------------CODIGO DEL MODAL----------------------------------------|

const mostrarModal = ref(false) // Variable para controlar la visibilidad del modal
const mostrarModalMisSalas = ref(false) // Variable para controlar la visibilidad del modal

// ABRIR EL MODAL Y EDITAR TEXTOS
const tituloModal = ref('Ingresar a Sala') // Título del modal

// Función para abrir el modal
const abrirModal = (accion: string) => {
  if (accion === 'cargar') {
    tituloModal.value = 'Ingresar a Sala'
  }
  mostrarModal.value = true // Asegurar que se muestra el modal
}
// Función para abrir el modal MIS SALAS
const abrirModalMisSalas = () => {
  mostrarModalMisSalas.value = true // Asegurar que se muestra el modal
}

// Función para cerrar el modal
const cerrarModal = () => {
  mostrarModal.value = false
}
// Función para cerrar el modal
const cerrarModalMisSalas = () => {
  mostrarModalMisSalas.value = false
}

// -------------------------HASTA ACÁ CODIGO DEL MODAL----------------------------------------|

// ----------------CODIGO PARA SELECCIONAR UNA FILA DE LA TABLA PARA MODIFICARLA--------------------------------|

const selectedItemIngresar = ref<Detallesala>({
  id_sala: 0,
  sala: '',
  nombre: ''
}) // Variable para almacenar el elemento seleccionado

const editar = (item: Detallesala, accion: string) => {
  if (accion === 'ingresar') {
    tituloModal.value = 'Ingresar a Sala'
  }
  console.log('Datos del item:', item) // Ver los datos que se están pasando

  if (item) {
    // Clonamos el objeto pero eliminamos la contraseña si existiera
    const itemClonado = { ...item }
    delete (itemClonado as any).contra // Por si acaso vino con ese campo
    selectedItemIngresar.value = itemClonado
  } else {
    console.error('El item no contiene datos válidos')
  }
  mostrarModal.value = true // Asegurar que se muestra el modal
}
// -----------------HASTA ACÁ EL CODIGO PARA SELECCIONAR UNA FILA DE LA TABLA PARA MODIFICARLA ------------------|

</script>

<style scoped>
/* del datatable */
@import url('datatables.net-bs5');
@import url('datatables.net-autofill-bs5');
@import url('datatables.net-buttons-bs5');
@import url('datatables.net-responsive-bs5');
@import url('datatables.net-select-bs5');

/* -----------ESTILOS DE LA SECCION DE BUSQUEDA Y FILTROS--------------- */
/* Estilo del boton de cargar nueva empresa */
.btn-secondary {
  background-color: #7839CD;
  border: none;
  color: #ffffff;
}

.btn-edit {
  background-color: #4F4F75;
  border: none;
  color: #ffffff;
}

.btn-edit:hover {
  background-color: #121236;
  border: none;
  color: #ffffff;
}

.btn-delete {
  background-color: #FF5733;
  border: none;
  color: #ffffff;
}

.btn-delete:hover {
  background-color: #4d1002;
  border: none;
  color: #ffffff;
}

.color-div {
  background-color: #f8f9fa;
  border: 1px solid #dee2e6;
  box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
}

/* Estilo del input de busqueda y filtro */
.color-input {
  background-color: #e9ecef;
  border: 1px solid #ced4da;
}

.fixed-width-input {
  min-width: 230px;
  /* Tamaño mínimo */
  max-width: 500px;
  /* Tamaño máximo */
  width: 50%;
  /* Opcional, dependiendo del diseño */
}

button {
  max-width: 100%;
  white-space: nowrap;
  /* Evita que el texto dentro del botón haga que crezca */
}

@media (max-width: 768px) {
  button {
    font-size: 14px;
    padding: 5px 10px;
    /* Reduce el padding para pantallas pequeñas */
  }
}

@media (max-width: 768px) {
  .table-responsive {
    overflow-x: auto;
    display: block;
    white-space: nowrap;
  }
}

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
