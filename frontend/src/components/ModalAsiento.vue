<template>
    <!-- MODAL REGISTRAR ASIENTO CONTABLE -->
    <div class="modal fade show d-block" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog modal-xl">
            <div class="modal-content text-white p-4" style="background-color: #4F4F75; border-radius: 10px;">

                <!-- TITULO -->
                <div class="modal-header border-bottom">
                    <h1 class="modal-title fs-3 fw-semibold" id="staticBackdropLabel"> {{ tituloModal }}</h1>
                    <button type="button" class="btn-close bg-white" @click="cerrarModal" aria-label="Close"></button>
                </div>

                <!-- FORMULARIO -->
                <form action="">
                    <!-- CUERPO DEL MODAL -->
                    <div class="modal-body">

                        <div class="row">
                            <!-- EMPRESA -->
                            <div class="col-md-6 mb-3 text-start w-100">
                                <label for="NombreEmpresa" class="form-label">Empresa</label>
                                <input type="text" class="form-control" id="NombreEmpresa" name="NombreEmpresa"
                                    readonly>
                            </div>
                            <!-- titulo -->
                            <p class="text-center modal-title fs-5 p-2 fw-semibold">Cargar datos del Asiento</p>
                            <!-- SUCURSAL -->
                            <div class="col-md-4 mb-3 text-start">
                                <label for="nombre_sucursal" class="form-label">Sucursal</label>
                                <select class="form-select" name="nombre_sucursal" id="nombre_sucursal">
                                    <option value="0" disabled selected>Seleccionar</option>
                                    <option v-for="nombre in sucursal" :key="nombre.id_sucursal"
                                        :value="nombre.id_sucursal">Seleccionar</option>
                                </select>
                            </div>
                            <!-- TIPO DE ASIENTO -->
                            <div class="col-md-2 mb-3 text-start">
                                <label for="tipoAsiento" class="form-label">Tipo de Asiento</label>
                                <select class="form-select" name="tipoAsiento" id="tipoAsiento">
                                    <option value="0">Seleccionar</option>
                                    <option value="Manual">Manual</option>
                                    <option value="Compra">Compra</option>
                                    <option value="Venta">Venta</option>
                                    <option value="Ajuste">Ajuste</option>
                                </select>
                            </div>
                            <!-- NRO ASIENTO -->
                            <div class="col-md-2 mb-3 text-start">
                                <label for="nro_asiento" class="form-label">Nº Asiento</label>
                                <input type="text" class="form-control" id="nro_asiento" name="nro_asiento">
                            </div>
                            <!-- FECHA -->
                            <div class="col-md-2 mb-3 text-start">
                                <label for="fecha" class="form-label">Fecha</label>
                                <input type="text" class="form-control" id="fecha" name="fecha">
                            </div>
                            <!-- DOCUMENTO -->
                            <div class="col-md-2 mb-3 text-start">
                                <label for="documento" class="form-label">Documento</label>
                                <input type="text" class="form-control" id="documento" name="documento">
                            </div>
                            <!-- titulo -->
                            <p class="text-center modal-title fs-5 p-2 fw-semibold">Cargar datos de la Cuenta Contable
                            </p>
                            <!-- CODIGO -->
                            <div class="col-md-2 mb-3 text-start">
                                <label for="codigo" class="form-label">Código</label>
                                <input type="text" class="form-control" id="codigo" name="codigo">
                            </div>
                            <!-- CUENTA -->
                            <div class="col-md-3 mb-3 text-start">
                                <label for="cuenta" class="form-label">Cuenta</label>
                                <input type="text" class="form-control" id="cuenta" name="cuenta">
                            </div>
                            <!-- DEBE -->
                            <div class="col-md-2 mb-3 text-start">
                                <label for="debe" class="form-label">DEBE</label>
                                <input type="text" class="form-control" id="debe" name="debe">
                            </div>
                            <!-- HABER -->
                            <div class="col-md-2 mb-3 text-start">
                                <label for="haber" class="form-label">HABER</label>
                                <input type="text" class="form-control" id="haber" name="haber">
                            </div>
                            <!-- CONCEPTO -->
                            <div class="col-md-2 mb-3 text-start">
                                <label for="concepto" class="form-label">Concepto</label>
                                <input type="text" class="form-control" id="concepto" name="concepto">
                            </div>
                            <!-- BOTON DE AGREGAR -->
                            <div class="col-md-1 mb-3  d-flex align-items-end">
                                <button type="button" class=" btn btn-warning" id="">Agregar</button>
                            </div>
                            <!-- TABLA -->
                            <div class="col-md-12 mb-3">
                                <div class="table-container table table-hover table-bordered shadow-sm">
                                    <DataTable :options="tableOptions" id="tableAsiento" :key="datatableKey"
                                        class="display table thead th nowrap table-striped table-hover table-bordered"
                                        cellspacing="0" width="100%">
                                        <thead>
                                            <tr>
                                                <th scope="col">N°</th>
                                                <th scope="col">Codigo</th>
                                                <th scope="col">Cuenta</th>
                                                <th scope="col">DEBE</th>
                                                <th scope="col">HABER</th>
                                                <th scope="col">Concepto</th>
                                                <th scope="col">Eliminar</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr v-for="item in items" :key="item.id_detalleAsiento">
                                                <td>{{ item.id_detalleAsiento }}</td>
                                                <td>{{ item.codigo }}</td>
                                                <td>{{ item.nombre }}</td>
                                                <td>{{ item.debe }}</td>
                                                <td>{{ item.haber }}</td>
                                                <td>{{ item.concepto }}</td>
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
                        <div class="row">
                            <!-- DIFERENCIA -->
                            <div class="col-md-2 mb-3 text-start">
                                <label for="diferencia" class="form-label">Diferencia</label>
                                <input type="text" class="form-control" id="diferencia" name="diferencia">
                            </div>
                            <!-- TOTAL DEBE -->
                            <div class="col-md-2 mb-3 text-start">
                                <label for="totaldebe" class="form-label">Total DEBE</label>
                                <input type="text" class="form-control" id="totaldebe" name="totaldebe">
                            </div>
                            <!-- TOTAL HABER -->
                            <div class="col-md-2 mb-3 text-start">
                                <label for="totalhaber" class="form-label">Total HABER</label>
                                <input type="text" class="form-control" id="totalhaber" name="totalhaber">
                            </div>
                            <div class="col-md-6 mb-3 d-flex justify-content-end align-items-end">
                                <button type="button" class=" btn btn-warning me-2" id="">Compra</button>
                                <button type="button" class=" btn btn-warning me-2" id="">Venta</button>
                                <button type="submit" class=" btn btn-success me-2" id="">Registrar</button>
                                <button type="button" class=" btn btn-danger" id="">Cancelar</button>
                            </div>
                        </div>
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
import axios from 'axios'

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

interface DetalleAsiento {
    id_detalleAsiento: number // eslint-disable-line camelcase
    codigo: string
    nombre: string
    debe: string
    haber: string
    concepto: string
}

// variable para almacenar los datos
const items = ref<DetalleAsiento[]>([])
// -------HASTA ACÁ DEFINCION DE LA INTERFAZ PARA LOS DATOS -------------------------------------------------|

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
  tituloModal: String
})

// ----------------------------OBTENER SUCURSALES DE LA BD PARA EL SELECT-----------------------------------|

// Definir la estructura
interface Sucursal {
    id_sucursal: number // eslint-disable-line camelcase
    nombre_sucursal: string // eslint-disable-line camelcase
}

// Lista de Sucursal obtenidos de la BD
const sucursal = ref<Sucursal[]>([])

const getByDB = async () => {
  try {
    const response = await axios.get('http://localhost:3000/api/FALTA')
    console.log('Datos obtenidos de la API para periodos:', response.data.sucursal)
    sucursal.value = response.data.sucursal
  } catch (error) {
    console.error(error) // Manejo de errores
    makeToast('Error', 'Error al conseguir las sucursales', 'error')
  }
}

// Llamar a la función al montar el componente
/* onMounted(() => {

}) */

// --------------------------FIN DE OBTENER SUCURSALES DE LA BD---------------------------------------------|

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
