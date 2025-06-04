<template>
    <!-- MODAL REGISTRAR VENTA -->
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
                            <p class="text-center mb-3  border-top border-bottom modal-title fs-5 p-2 fw-semibold">Cargar datos de la Factura Ventas</p>
                            <!-- SUCURSAL -->
                            <div class="col-md-4 mb-3 text-start">
                                <label for="nombre_sucursal" class="form-label">Sucursal</label>
                                <select class="form-select" name="nombre_sucursal" id="nombre_sucursal">
                                    <option value="0" disabled selected>Seleccionar</option>
                                    <option v-for="nombre in sucursal" :key="nombre.id_sucursal"
                                        :value="nombre.id_sucursal">Seleccionar</option>
                                </select>
                            </div>
                            <!-- TIPO DE FACTURA -->
                            <div class="col-md-2 mb-3 text-start">
                                <label for="tipoFactura" class="form-label">Tipo de Factura</label>
                                <select class="form-select" name="tipoFactura" id="tipoFactura">
                                    <option value="0">Seleccionar</option>
                                    <option value="Factura">Factura</option>
                                    <option value="Factura Electronica">Factura Electronica</option>
                                </select>
                            </div>
                            <!-- FECHA -->
                            <div class="col-md-2 mb-3 text-start">
                                <label for="fecha" class="form-label">Fecha</label>
                                <input type="text" class="form-control" id="fecha" name="fecha">
                            </div>
                            <!-- Nro COMPROBANTE -->
                            <div class="col-md-2 mb-3 text-start">
                                <label for="nro_comprobante" class="form-label">N° Comprobante</label>
                                <input type="text" class="form-control" id="nro_comprobante" name="nro_comprobante">
                            </div>
                            <!-- Nro TIMBRADO -->
                            <div class="col-md-2 mb-4 text-start">
                                <label for="nro_timbrado" class="form-label">N° Timbrado</label>
                                <input type="text" class="form-control" id="nro_timbrado" name="nro_timbrado">
                            </div>
                            <!-- MONEDA -->
                            <div class="col-md-2 mb-3 text-start">
                                <label for="moneda" class="form-label">Moneda</label>
                                <select class="form-select" name="moneda" id="moneda">
                                    <option value="0">Seleccionar</option>
                                    <option value="Local">Local</option>
                                    <option value="Dolar">Dolar</option>
                                </select>
                            </div>
                            <!-- CONDICION -->
                            <div class="col-md-2 mb-3 text-start">
                                <label for="condicion" class="form-label">Condicion</label>
                                <select class="form-select" name="condicion" id="condicion">
                                    <option value="0">Seleccionar</option>
                                    <option value="Contado">Contado</option>
                                    <option value="Credito">Credito</option>
                                </select>
                            </div>
                            <!-- RUC -->
                            <div class="col-md-2 mb-3 text-start">
                                <label for="numero_identificacion" class="form-label">N° Identificación</label>
                                <input type="text" class="form-control" id="numero_identificacion" name="numero_identificacion">
                            </div>
                            <!-- CLIENTE -->
                            <div class="col-md-6 mb-4 text-start">
                                <label for="razon_social" class="form-label">Cliente</label>
                                <input type="text" class="form-control" id="razon_social" name="razon_social">
                            </div>
                            <!-- DETALLE DEL MONTO -->
                            <div class="card col-md-6 mb-3">
                                <div class="row">
                                    <!-- titulo -->
                                    <p class="text-center modal-title fs-5 p-2 fw-semibold">Cargar Detalles del Monto</p>
                                    <!-- Total FACTURA -->
                                    <div class="col-md-6 mb-3 text-start">
                                        <label for="total_facutra" class="form-label">Total</label>
                                        <input type="text" class="form-control" id="total_facutra" name="total_facutra">
                                    </div>
                                    <!-- Exentas -->
                                    <div class="col-md-6 mb-3 text-start">
                                        <label for="monto_exentas" class="form-label">Exentas</label>
                                        <input type="text" class="form-control" id="monto_exentas" name="monto_exentas">
                                    </div>
                                    <!-- Gravadas 10 -->
                                    <div class="col-md-6 mb-3 text-start">
                                        <label for="gravadas_10" class="form-label">Gravadas 10</label>
                                        <input type="text" class="form-control" id="gravadas_10" name="gravadas_10">
                                    </div>
                                    <!-- Base Imponible 10 -->
                                    <div class="col-md-6 mb-3 text-start">
                                        <label for="baseimp_10" class="form-label">Base Imponible 10</label>
                                        <input type="text" class="form-control" id="baseimp_10" name="baseimp_10">
                                    </div>
                                    <!-- Gravadas 5 -->
                                    <div class="col-md-6 mb-3 text-start">
                                        <label for="gravada_5" class="form-label">Gravadas 5</label>
                                        <input type="text" class="form-control" id="gravada_5" name="gravada_5">
                                    </div>
                                    <!-- Base Imponible 5 -->
                                    <div class="col-md-6 mb-3 text-start">
                                        <label for="baseimp5" class="form-label">Base Imponible 5</label>
                                        <input type="text" class="form-control" id="baseimp5" name="baseimp5">
                                    </div>
                                </div>
                            </div>
                            <!-- CUENTAS ASOCIADAS -->
                            <div class="card col-md-6 mb-3">
                                <div class="row">
                                    <!-- titulo -->
                                    <p class="text-center modal-title fs-5 p-2 fw-semibold">Cargar Cuentas Asociadas</p>
                                    <!-- Cuenta Excenta -->
                                    <div class="col-md-12 mb-3 text-start">
                                        <label for="cuenta_exenta" class="form-label">Cuenta Excenta</label>
                                        <input type="text" class="form-control" id="cuenta_exenta" name="cuenta_exenta">
                                    </div>
                                    <!-- Cuenta Grav. 10 -->
                                    <div class="col-md-6 mb-3 text-start">
                                        <label for="cuentaGrav10" class="form-label">Cuenta Grav. 10</label>
                                        <input type="text" class="form-control" id="cuentaGrav10" name="cuentaGrav10">
                                    </div>
                                    <!-- Cuenta Grav. 5 -->
                                    <div class="col-md-6 mb-3 text-start">
                                        <label for="cuentaGrav5" class="form-label">Cuenta Grav. 5</label>
                                        <input type="text" class="form-control" id="cuentaGrav5" name="cuentaGrav5">
                                    </div>
                                    <!-- concepto -->
                                    <div class="col-md-12 mb-3 text-start">
                                        <label for="concepto" class="form-label">Concepto</label>
                                        <input type="text" class="form-control" id="concepto" name="concepto">
                                    </div>

                                </div>
                            </div>
                        </div>

                    </div>
                    <!-- PIE DEL MODAL -->
                    <div class="modal-footer border-0  border-bottom">
                        <button type="submit" class=" btn btn-success me-2" id="">Registrar</button>
                        <button type="button" class=" btn btn-danger" id="">Cancelar</button>
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

.card {
    background-color: #b2b2c9; /* Color de fondo de la tarjeta */
    border-radius: 10px; /* Bordes redondeados */
}

</style>
