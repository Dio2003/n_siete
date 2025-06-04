<template>
  <!-- DIV PARA LA NAVEGACION POR EL MENU -->
  <div class="Company">
    <!-- Descripcion: esta es la forma en la que se importan componentes en vue -->
    <Navbar />
    <Siderbar />
    <!-- LLAMAR AL COMPONENTE DE MODAL CARGA -->
    <!-- Mostrar el modal solo si `mostrarModal` es true -->
     <!-- descripción: en esta importacion del modal se pasan mas datos desde el padre que es este componente al hijo que es el modalCompany.vue
      explicacion:
      --:empresa="selectedItem" : este codigo es un objeto, funciona para pasarle los datos seleccionados de la tabla al modal para las modificaciones
      -- :tituloModal="tituloModal" :subtituloModal="subtituloModal" : estos dos le pasan los titulos y subtitulos para cambiar segun se modifique o se cargue una nueva empresa
      -- v-if="mostrarModal": este codigo se usa para mostrar el modal, en primera instancia se encuentra en false pero en la funcion mostrar modal se cambia a true y el v-if siempre esta escuchando para cambiar
      -- @cerrar="cerrarModal" @actualizartabla="recargartabla()" : son eventos emitidos, son instruccione que el hijo modalCompany.vue le envia al padre GestCompany.vue para que cierren el modal o actualicen la tabla   -->
    <ModalEmpresa :empresa="selectedItem" :tituloModal="tituloModal" :subtituloModal="subtituloModal"
      v-if="mostrarModal" @cerrar="cerrarModal" @actualizartabla="recargartabla()" />
    <main class="col-md-9 ms-sm-auto  col-lg-10 px-md-4 overflow-auto">
      <!-- TITULO -->
      <div
        class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
        <h2>Empresas</h2>
      </div>

      <!-- SECCION DE BUSQUEDA Y FILTRO -->
      <div class="d-flex flex-wrap align-items-center gap-2 mb-3 pt-3 pb-3 color-div pe-3 ps-3 rounded shadow-sm">

        <!-- Grupo de búsqueda -->
        <div class="d-flex align-items-center gap-2 flex-grow-1">
          <span class="input-group-text">
            <Icon icon="mdi:search" width="20" height="20" />
          </span>
          <!-- ese codigo es del buscador y lo bueno de este codigo es que este buscador se conecta con la tabla, pues las datatable suele tener un buscador propio
           y eso es lo que hice, saque el buscador del datatable y utilicé este input para filtrar la tabla, todo se conecta a su id:  id="customSearchInput"-->
          <input type="text" class="form-control fixed-width-input color-input" id="customSearchInput"
            placeholder="Seleccione un filtro para buscar" />

          <!-- Botón de filtro -->
           <!-- y tambien se conecata con este filtro con su id id="filterDropdown" y filtra de acuendo a el numero de las columnas  data-col="1" -->
          <button class="btn btn-outline-secondary" data-bs-toggle="dropdown" aria-expanded="false">
            Filtros
            <Icon icon="mdi:filter" width="24" height="24" />
          </button>
          <ul class="dropdown-menu" aria-labelledby="dropdown03" id="filterDropdown">
            <li><a class="dropdown-item" data-col="1">Empresa</a></li>
            <li><a class="dropdown-item" data-col="2">Sigla</a></li>
            <li><a class="dropdown-item" data-col="3">Periodo</a></li>
          </ul>
        </div>

        <!-- Botón de carga, baja en pantallas pequeñas -->
         <!-- este boton es para abrir el modal de carga, con el codigo:
           @click="abrirModal('cargar')" : lo que hace es llamar a la funcion abrirModal y le pasa un dato llamado 'cargar' que es en realidad la forma en la que el
           padre GestCompany.vue le manda a su hijo ModalComany a tra vez de los props que debe mostrar el titulo de Cargar una nueva empresa-->
        <div class="btn-toolbar">
          <div class="btn-group w-100 w-md-auto">
            <button type="button" class="btn btn-sm btn-secondary" @click="abrirModal('cargar')">
              Cargar Nueva Empresa
              <Icon icon="mdi:plus" width="24" height="24" />
            </button>
          </div>
        </div>

      </div>

      <!-- CODIGOS DE LA TABLA -->
      <div class="body table-responsive  table table-hover table-bordered shadow-sm">
        <div>
          <!--:key="datatableKey" : este codigo es imporante para que la tabla se actualice sin la necesidad de recargar la pagina, ver la parte del script  -->
          <DataTable :options="tableOptions" id="tableCompany" :key="datatableKey"
            class="display table pretty thead th responsive nowrap table-striped table-hover table-bordered"
            cellspacing="0" width="100%">
            <thead>
              <tr>
                <th scope="col">ITEM</th>
                <th scope="col">EMPRESA</th>
                <th scope="col">SIGLA</th>
                <th scope="col">PERIODO</th>
                <th scope="col">Modificar</th>
                <th scope="col">Eliminar</th>
              </tr>
            </thead>
            <tbody>
              <!-- IMPORTANTE:
               -- v-for es una directiva de Vue.js Se usa para renderizar (mostrar) listas de elementos repitiendo una parte del HTML por cada ítem en una colección
               (como un array).
               entonces lo que pasa acá es que:
               v-for="item in items" :key="item.id_empresa : se itera en un array que dice: “Por cada item dentro del array items, repite este bloque HTML, y usa item.id_empresa como clave
               única para que Vue sepa cuál es cuál.” -->
              <tr v-for="item in items" :key="item.id_empresa">
                <td class="number">{{ item.id_empresa /* eslint-disable-line camelcase */ }}</td>
                <td>{{ item.empresa }}</td>
                <td>{{ item.sigla }}</td>
                <td class="number">{{ item.nombre_periodo /* eslint-disable-line camelcase */ }}</td>
                <td>
                  <!-- @click="editar(item, 'modificar')" : este boton ejecuta la funcion de editar que se utiliza para enviar los datos de la tabla al modal para modificar
                   tambien le pasa dos datos, el primero es item que es la id de la empresa y la segunda es 'modificar' que es para avisarle desde el componente padre al
                   componente hijo que deben mostrar el titulo de Modificar la empresa  -->
                  <button class="btn btn-edit" @click="editar(item, 'modificar')">
                    <Icon icon="mdi:pencil" width="20" height="20" />
                  </button>
                </td>
                <td>
                  <!-- @click="eliminar(item)" : ejecuta la funcion eliminar y le pasa la id de la empresa  -->
                  <button class="btn btn-delete" @click="eliminar(item)">
                    <Icon icon="mdi:trash-can" width="20" height="20" />
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
/* ------------IMPORTACIONES----------------- */

// IMPORTACIONES
/* En esta sección se importan las librerías y funciones necesarias para que el componente funcione correctamente:

➡️ Navbar : es el componente del navegador horizontal
➡️ Siderbar: es el componete del navegador de la izquierda
➡️ ref: se usa para declarar variables reactivas.
➡️ onMounted: ejecuta una función automáticamente cuando el componente se monta.

➡️ Swal (desde sweetalert2):
Se importa esta librería externa para mostrar alertas estilizadas y mensajes interactivos al usuario.

➡️ axios:
Es una librería para hacer solicitudes HTTP (como GET, POST, etc.) al servidor o API. Se usa para conectarse con servicios externos o backend. */

// asi se importar
import Navbar from '@/components/NavBar.vue'
// importar el siderbar
import Siderbar from '@/components/SiderBar.vue'

import { ref, onMounted } from 'vue'
import ModalEmpresa from '@/components/ModalCompany.vue'

// 1ro importar la libreria de Axios
import axios from 'axios'

// Importar libreria de alertas
import Swal from 'sweetalert2'

import $ from 'jquery'

// Codigo para los iconos
import { Icon } from '@iconify/vue'

// --------------------------------IMPORTACIONES DEL DATATABLE ----------------------------------------------|

// import jszip from 'jszip'
// import pdfmake from 'pdfmake'
/* ------------DEL DATATABLE---------------------- */
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

// ----------------------------HASTA ACÁ LAS IMPORTACIONES --------------------------------------------------|

// ------------------------------CODIGOS DEL MODAL ----------------------------------------------------------|

// Estado para controlar la visibilidad del modal
const mostrarModal = ref(false)

// ABRIR EL MODAL Y EDITAR TEXTOS
const tituloModal = ref('Cargar Nueva Empresa')
const subtituloModal = ref('Ingrese todos los datos de la nueva empresa')

// FUNCION para abrir el modal el cual le pasa un props al modal que es el string "cargar" que le da la instruccion al modal de que
// muestre el titulo de cargar nueva empresa
const abrirModal = (accion: string) => {
  if (accion === 'cargar') {
    tituloModal.value = 'Cargar Nueva Empresa'
    subtituloModal.value = 'Ingrese todos los datos de la empresa'
  }
  mostrarModal.value = true // Asegurar que se muestra el modal
}

// Función para cerrar el modal, lo que hace es poner el modal en false y el objero selectitem borra los datos cargados en los
// campons del formulario para que cuando se vuelva abir el modal no este cargado con los datos anteriores
const cerrarModal = () => {
  mostrarModal.value = false
  selectedItem.value = {
    id_empresa: 0,
    empresa: '',
    sigla: '',
    id_periodo: 0 // regresa el id del select al 0 que es el Seleccionar
  } // Restablecer a valores predeterminados
}
// ----------------------------HASTA ACÁ --------------------------------------------------------------------|

// ---------------------------FUNCION DE RECARGAR LA TABLA --------------------------------------------------|

// ESTA FUNCION: lo que hace es volver a cargar la tabla a traves de una peticion con el axios para que vuelva a traer los datos de la tabla
// pero ahora ya con los datos que se cargaron, modificaron o eliminaron
const recargartabla = () => {
  // Llamar al backend para obtener los empresas actualizados
  axios.get('http://localhost:3000/api/empresas')
    .then(response => {
      // Actualizar la lista de empresas con los datos más recientes del backend
      items.value = response.data.empresas.map((empresa: any) => ({
        ...empresa,
        nombre_periodo: empresa.Periodo ? empresa.Periodo.nombre_periodo : 'Desconocido' // este codigo es para mostrar el periodo en la tabla en vez de la id del periodo
      }))
      // Forzar la actualización de la tabla con DataTable
      datatableKey.value++
    })
    .catch(error => {
      console.error('Error al obtener los empresas:', error)
      Swal.fire({
        icon: 'error',
        title: 'Error',
        text: 'No se pudo obtener la lista de empresas.'
      })
    })
}

// ----------------------------HASTA ACÁ --------------------------------------------------------------------|

// ----------------------------CODIGO DEL DATATABLE----------------------------------------------------------|
// DataTable.Buttons.jszip(jszip)

DataTablesCore.Buttons.jszip(jszip)
DataTable.use(DataTablesCore)

const datatableKey = ref(0)

// Configuración de las opciones del DataTable con idioma en español
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

// -----------------CODIGO PARA FILTRAR LA TABLA ------------------|

const columnaFiltro = ref<number | null>(null)

onMounted(() => {
  document.querySelectorAll('#filterDropdown .dropdown-item').forEach(item => {
    item.addEventListener('click', (e: any) => {
      const col = parseInt(e.target.getAttribute('data-col'))
      columnaFiltro.value = col
      const placeholder = document.getElementById('customSearchInput') as HTMLInputElement
      if (placeholder) {
        placeholder.placeholder = 'Buscar por ' + e.target.textContent
        placeholder.focus()
      }
    })
  })
  const input = document.getElementById('customSearchInput') as HTMLInputElement

  if (input) {
    input.addEventListener('keyup', function () {
      const value = (this as HTMLInputElement).value
      const table = $('#tableCompany').DataTable()

      if (columnaFiltro.value !== null) {
        table.column(columnaFiltro.value).search(value).draw()
      } else {
        table.search(value).draw()
      }
    })
  }
})

// ----------------------------HASTA ACÁ EL DATATABLE------------------------------------------------------------|

// ----------------------CODIGO DE PETICION PARA OBTENER LOS DATOS DE LA BASE DE DATOS---------------------------|

interface Empresa { // definición de la interfaz para los datos de la empresa
  id_empresa: number; // eslint-disable-line camelcase
  id?: number; // este es solo para las pruebas de Json por eso lleva el "?" porque solo se utliza en eliminar
  empresa: string;
  sigla: string;
  id_periodo: number; // eslint-disable-line camelcase
  // este nombre_periodo es para mostrar los nombre de los periodos por id lleva el "?" porque solo se utiliza en getCompany
  // y en la funcion recargartabla
  nombre_periodo?: string; // eslint-disable-line camelcase
}

const items = ref<Empresa[]>([]) // Variable para almacenar los datos de la empresa

// FUNCION DE LA PETICION CON AXIOS
const getCompany = async () => {
  try {
    const response = await axios.get('http://localhost:3000/api/empresas')
    items.value = response.data.empresas.map((empresa: any) => ({
      ...empresa,
      nombre_periodo: empresa.Periodo ? empresa.Periodo.nombre_periodo : 'Desconocido' // Solo para mostrar el nombre
    })) // Asignar los datos a la variable items
    console.log('Datos de la empresa:', response.data.empresas) // Verificar los datos obtenidos
    // Destruir DataTable si ya existe
    datatableKey.value++
  } catch (error) {
    console.error('Error al obtener los datos de la empresa:', error)
    Swal.fire({
      icon: 'error',
      title: 'Error',
      text: 'No se pudo cargar los datos de la empresa.'
    })
  }
}

onMounted(() => {
  getCompany() // Luego obtiene los datos
})

// -----------------HASTA ACÁ EL CODIGO DE PETICION PARA OBTENER LOS DATOS DE LA BASE DE DATOS------------------|

// ----------------CODIGO PARA SELECCIONAR UNA FILA DE LA TABLA PARA MODIFICARLA--------------------------------|

const selectedItem = ref<Empresa>({
  id_empresa: 0,
  id: 0,
  empresa: '',
  sigla: '',
  id_periodo: 0
}) // Variable para almacenar el elemento seleccionado

const editar = (item: Empresa, accion: string) => {
  if (accion === 'modificar') {
    tituloModal.value = 'Modificar Empresa'
    subtituloModal.value = 'Edite los datos de la empresa'
  }
  console.log('Datos del item:', item) // Ver los datos que se están pasando

  if (item) {
    selectedItem.value = { ...item } // Asignar el elemento seleccionado a la variable
  } else {
    console.error('El item no contiene datos válidos')
  }
  mostrarModal.value = true // Asegurar que se muestra el modal
}
// -----------------HASTA ACÁ EL CODIGO PARA SELECCIONAR UNA FILA DE LA TABLA PARA MODIFICARLA ------------------|

// --------------------------CODIGO PARA ELIMINAR UNA FILA DE LA TABLA  -----------------------------------------|
const eliminar = (item: Empresa) => {
  console.log('Item a eliminar:', item.empresa) // Depuración: Verificar si item es válido

  Swal.fire({
    title: `¿Estás seguro de que deseas eliminar la empresa: ${item.empresa}?`,
    text: 'No podrás revertir esto!',
    icon: 'question',
    showCancelButton: true,
    confirmButtonColor: '#4F4F75',
    cancelButtonColor: '#FF5733',
    confirmButtonText: 'Sí, eliminar!',
    cancelButtonText: 'Cancelar',
    reverseButtons: true // Invierte el orden de los botones (Aceptar primero, Cancelar después)
  }).then(async (result) => {
    if (result.isConfirmed) {
      // Obtener el token del almacenamiento local
      const token = localStorage.getItem('token') // O usa Vuex o cualquier otro método para obtenerlo

      if (!token) {
        Swal.fire('Error', 'Debes iniciar sesión para eliminar empresas.', 'error')
        return
      }

      // Configuración de los encabezados para incluir el token
      const config = {
        headers: {
          Authorization: `Bearer ${token}` // Añadir el token al encabezado
        }
      }
      console.log('token:', token)
      // Realizar la solicitud DELETE a la API
      const response = await axios.delete(`http://localhost:3000/api/empresas/${item.id_empresa}`, config)
      console.log('Respuesta de la API:', response) // Verificar la respuesta de la API
      // Eliminar de la lista de items
      items.value = items.value.filter(i => i.id_empresa !== item.id_empresa)
      // Asegurarse de que DataTables se actualice después de eliminar
      datatableKey.value++
      Swal.fire(
        'Eliminado!',
        'La empresa ha sido eliminada.',
        'success'
      )
    }
  })
}

// -----------------HASTA ACÁ EL CODIGO PARA ELIMINAR UNA FILA DE LA TABLA  -------------------------------------|

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
