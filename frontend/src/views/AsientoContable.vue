<template>
    <div class="asiento">
        <!-- Componentes -->
        <Navbar />
        <Siderbar />
        <!-- MODAL -->
        <ModalAsiento v-if="mostrarModal" @cerrar="cerrarModal" :tituloModal="tituloModal"/>
        <!-- Contenido Principal -->
        <main class="col-md-9 ms-sm-auto  col-lg-10 px-md-4 overflow-auto">
            <!-- TITULO -->
            <div
                class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h2>Asiento Contable</h2>
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
                        <li><a class="dropdown-item" data-col="1">Nro Asiento</a></li>
                        <li><a class="dropdown-item" data-col="2">Documento</a></li>
                        <li><a class="dropdown-item" data-col="3">Sucursal</a></li>
                        <li><a class="dropdown-item" data-col="4">Fecha</a></li>
                    </ul>
                </div>

                <!-- Botón de Registrar Asiento -->
                <div class="btn-toolbar">
                    <div class="btn-group w-100 w-md-auto">
                        <button type="button" class="btn btn-sm btn-secondary"  @click="abrirModal('cargar')">
                            Registrar Asiento
                            <Icon icon="mdi:plus" width="24" height="24" />
                        </button>
                    </div>
                </div>

            </div>

            <!-- CODIGOS DE LA TABLA -->
            <div class="body table-responsive  table table-hover table-bordered shadow-sm">
                <div>
                    <DataTable :options="tableOptions" id="tableAsiento" :key="datatableKey"
                        class="display table pretty thead th responsive nowrap table-striped table-hover table-bordered"
                        cellspacing="0" width="100%">
                        <thead>
                            <tr>
                                <th scope="col">N° ASIENTO</th>
                                <th scope="col">FECHA</th>
                                <th scope="col">DOCUMENTO</th>
                                <th scope="col">SUCURSAL</th>
                                <th scope="col">CONCEPTO</th>
                                <th scope="col">TIPO ASIENTO</th>
                                <th scope="col">Ver Detalles</th>
                                <th scope="col">Modificar</th>
                                <th scope="col">Eliminar</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="item in items" :key="item.id_asiento">
                                <td>{{ item.id_asiento}}</td>
                                <td>{{ item.fecha}}</td>
                                <td>{{ item.documento }}</td>
                                <td>{{ item.nombre_sucursal }}</td>
                                <td>{{ item.concepto }}</td>
                                <td>{{ item.tipoasiento }}</td>
                                <td>
                                   <!--  <button class="btn btn-edit" >
                    <Icon icon="mdi:more-horiz" width="20" height="20" />
                  </button> -->
                                </td>
                                <td>
                                    <!-- <button class="btn btn-edit" @click="editar(item, 'modificar')">
                    <Icon icon="mdi:pencil" width="20" height="20" />
                  </button> -->
                                </td>
                                <td>
                                    <!-- <button class="btn btn-delete" @click="eliminar(item)">
                    <Icon icon="mdi:trash-can" width="20" height="20" />
                  </button> -->
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
import ModalAsiento from '@/components/ModalAsiento.vue'

// Codigo para los iconos
import { Icon } from '@iconify/vue'

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
  dom: '<"top d-flex justify-content-between align-items-center"lB>rt<"bottom d-flex justify-content-between"ip>',
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

// -----------DEFINCION DE LA INTERFAZ PARA LOS DATOS DE ASIENTOS CONTABLES---------------------------|

interface Asiento {
  id_asiento: number // eslint-disable-line camelcase
  fecha: string
  documento: string
  nombre_sucursal: string // eslint-disable-line camelcase
  concepto: string
  tipoasiento: string
}

// variable para almacenar los datos
const items = ref<Asiento[]>([])
// -------HASTA ACÁ DEFINCION DE LA INTERFAZ PARA LOS DATOS DE ASIENTOS CONTABLES---------------------------|

// -----------------------------CODIGO DEL MODAL----------------------------------------|

const mostrarModal = ref(false) // Variable para controlar la visibilidad del modal

// ABRIR EL MODAL Y EDITAR TEXTOS
const tituloModal = ref('Registrar Asiento') // Título del modal

// Función para abrir el modal
const abrirModal = (accion: string) => {
  if (accion === 'cargar') {
    tituloModal.value = 'Registrar Asiento'
  }
  mostrarModal.value = true // Asegurar que se muestra el modal
}

// Función para cerrar el modal
const cerrarModal = () => {
  mostrarModal.value = false
}

// -------------------------HASTA ACÁ CODIGO DEL MODAL----------------------------------------|

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
