<template>
    <!-- COMPONENTE MODAL DEL FORMULARIO DE CUENTAS -->
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

                    <!-- cuerpo del modal -->
                     <div class="modal-body">

                        <!-- Subtítulo + botón de ayuda alineados -->
                        <div class="d-flex justify-content-between align-items-center mb-3">
                          <p class="mb-0">{{ subtituloModal }}</p>
                          <button type="button" class="btn btn-outline-info btn-sm" data-bs-toggle="modal" data-bs-target="#instruccionesModal">
                            ¿Cómo cargo una cuenta?
                          </button>
                        </div>

                      <div class="row">
                        <!-- Empresa -->
                        <div class="col-md-6 mb-3 text-start w-100">
                            <label for="NombreEmpresa" class="form-label">Empresa</label>
                            <input type="text" class="form-control" id="NombreEmpresa" name="NombreEmpresa" readonly>
                        </div>
                        <!-- nivel -->
                        <div class="col-md-2 mb-3 text-start">
                            <label for="nivel" class="form-label">Nivel</label>
                            <select name="nivel" id="nivel"  class="form-select">
                              <option value="0" >Seleccionar</option>
                              <option value="1">1</option>
                              <option value="2">2</option>
                              <option value="3">3</option>
                              <option value="4">4</option>
                              <option value="5">5</option>
                            </select>
                        </div>
                        <!-- GRUPO -->
                        <div class="col-md-2 mb-3 text-start">
                            <label for="grupo" class="form-label">Grupo</label>
                            <select name="grupo" id="grupo"  class="form-select">
                              <option value="0" >Seleccionar</option>
                              <option value="1">1</option>
                              <option value="2">2</option>
                              <option value="3">3</option>
                              <option value="4">4</option>
                              <option value="5">5</option>
                            </select>
                        </div>
                        <!-- SUBGRUPO -->
                        <div class="col-md-3 mb-3 text-start">
                            <label for="subgrupo" class="form-label">Sub Grupo</label>
                            <select name="subgrupo" id="subgrupo"  class="form-select">
                              <option value="0" >Seleccionar</option>
                              <option value="1">1</option>
                              <option value="2">2</option>
                              <option value="3">3</option>
                              <option value="4">4</option>
                              <option value="5">5</option>
                            </select>
                        </div>
                        <!-- CUENTA PRINCIPAL -->
                        <div class="col-md-2 mb-3 text-start">
                            <label for="cuentaprincipal" class="form-label">Cuenta Principal</label>
                            <select name="cuentaprincipal" id="cuentaprincipal"  class="form-select">
                              <option value="0" >Seleccionar</option>
                              <option value="1">1</option>
                              <option value="2">2</option>
                              <option value="3">3</option>
                              <option value="4">4</option>
                              <option value="5">5</option>
                            </select>
                        </div>
                        <!-- SUBCUENTA -->
                        <div class="col-md-3 mb-3 text-start">
                            <label for="subcuenta" class="form-label">Sub Cuenta</label>
                            <select name="subcuenta" id="subcuenta"  class="form-select">
                              <option value="0" >Seleccionar</option>
                              <option value="1">1</option>
                              <option value="2">2</option>
                              <option value="3">3</option>
                              <option value="4">4</option>
                              <option value="5">5</option>
                            </select>
                        </div>
                        <!-- titulo -->
                        <p class="text-center modal-title fs-5 p-2 fw-semibold">Cargar la nueva Cuenta Contable</p>
                        <!-- codigo -->
                        <div class="col-md-2 mb-3 text-start">
                            <label for="codigo" class="form-label">Código</label>
                            <input type="text" class="form-control" id="codigo" name="codigo" readonly>
                        </div>
                        <!-- Nombre -->
                        <div class="col-md-5 mb-3 text-start">
                            <label for="nombre" class="form-label">Nombre</label>
                            <input type="text" class="form-control" id="nombre" name="nombre" readonly>
                        </div>
                        <!-- Nombre Alternativo -->
                        <div class="col-md-5 mb-3 text-start">
                            <label for="nombre_alternativo" class="form-label">Nombre Alternativo</label>
                            <input type="text" class="form-control" id="nombre_alternativo" name="nombre_alternativo" readonly>
                        </div>
                        <!-- Naturaleza -->
                        <div class="col-md-2 mb-3 text-start">
                            <label for="naturaleza" class="form-label">Naturaleza</label>
                            <select name="naturaleza" id="naturaleza"  class="form-select">
                              <option value="0" >Seleccionar</option>
                              <option value="Acreedora">Acreedora</option>
                              <option value="Deudora">Deudora</option>
                            </select>
                        </div>
                        <!-- Asentable -->
                        <div class="col-md-2 mb-3 text-start">
                            <label for="asentable" class="form-label">Asentable</label>
                            <select name="asentable" id="asentable"  class="form-select">
                              <option value="0" >Seleccionar</option>
                              <option value="Si">Si</option>
                              <option value="No">No</option>
                            </select>
                        </div>
                        <!-- Moneda -->
                        <div class="col-md-3 mb-3 text-start">
                            <label for="moneda" class="form-label">Moneda</label>
                            <select name="moneda" id="moneda"  class="form-select">
                              <option value="0" >Seleccionar</option>
                              <option value="Local">Local</option>
                              <option value="Dolar">Dolar</option>
                            </select>
                        </div>
                        <!-- Rubro -->
                        <div class="col-md-5 mb-3 text-start">
                            <label for="rubro" class="form-label">Rubro</label>
                            <input type="text" class="form-control" id="rubro" name="rubro" readonly>
                        </div>
                        <!-- Descripción -->
                        <div class="col-md-6 mb-3 text-start w-100">
                            <label for="descripcion" class="form-label">Descripcion</label>
                            <input type="text" class="form-control" id="descripcion" name="descripcion">
                        </div>
                     </div>
                    </div>
                    <!-- Pie del Modal -->
                    <div class="modal-footer border-0">
                      <button type="submit" class="btn btn-success" id="btnGuardar">Guardar</button>
                      <button type="button" class="btn btn-danger" @click="cerrarModal">Cancelar</button>
                      <button type="button" class="btn btn-warning" id="segurcargando">Seguir Cargando con la misma estructura</button>
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
  subtituloModal: String
})

</script>

<style scoped>
/* color del boton de seguir cargando */
.btn-warning {
    background-color: #FFC107 !important;
    color: #ffffff !important;
}
.btn-warning:hover {
    background-color: #FFA000 !important;
    color: #ffffff !important;
}
</style>
