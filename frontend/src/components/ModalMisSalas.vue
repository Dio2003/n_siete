<template>
    <!-- MODAL MIS SALAS -->
   <div class="modal fade show d-block" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content text-white p-4" style="background-color: #4F4F75; border-radius: 10px;">

             <!-- TITULO -->
                <div class="modal-header border-bottom">
                    <h1 class="modal-title fs-3 fw-semibold" id="staticBackdropLabel">MIS SALAS</h1>
                    <button type="button" class="btn-close bg-white" @click="cerrarModalMisSalas" aria-label="Close"></button>
                </div>
                <!-- FORMULARIO -->
                <form action="">
                    <!-- CUERPO DEL MODAL -->
                    <div class="modal-body">

                        <div class="row">
                            <!-- TABLA -->
                            <div class="col-md-12 mb-3">
                                <div class="table-container table table-hover table-bordered shadow-sm">
                                    <DataTable :options="tableOptions" id="tableIngresar" :key="datatableKey"
                                        class="display table thead th nowrap table-striped table-hover table-bordered"
                                        cellspacing="0" width="100%">
                                        <thead>
                            <tr>
                                <th scope="col">N°</th>
                                <th scope="col">SALA</th>
                                <th scope="col">PROFESOR</th>
                                <th scope="col">Salir</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="item in items" :key="item.id_sala">
                                <td>{{ item.id_sala}}</td>
                                <td>{{ item.sala}}</td>
                                <td>{{ item.nombre }}</td> <!-- este traer el nombre del profesor de la tabla de usuarios -->
                                <td>
                                    <button class="btn btn-edit" @click="salir(item)">
                                     <Icon icon="mdi:logout" width="20" height="20" />
                                    </button>
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
                        <button type="button" class=" btn btn-danger" id="" @click="cerrarModalMisSalas">Salir</button>
                    </div>

                </form>
        </div>
    </div>
   </div>
</template>

<script lang="ts" setup>
// importaciones de vue
import { defineEmits, onMounted, ref } from 'vue'

// Importar libreria de alertas
import Swal from 'sweetalert2'

// 1ro importar la libreria de Axios
import axios from 'axios'

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

const cerrarModalMisSalas = () => {
  Swal.fire({
    title: '¿Está seguro de que desea salir?',
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

interface Detallesala {
  id_sala: number // eslint-disable-line camelcase
  sala: string
  nombre: string // del profesor
}

// variable para almacenar los datos
const items = ref<Detallesala[]>([])
// -------HASTA ACÁ DEFINCION DE LA INTERFAZ PARA LOS DATOS -------------------------------------------------|

// ------obtener la id del usuario logueado desde el localStorage-----------------|
const id = ref(0) // eslint-disable-line camelcase

onMounted(() => {
  CargarCampos()
})

const CargarCampos = async () => {
  const storedUser = localStorage.getItem('usuario')
  if (storedUser) {
    const usuario = JSON.parse(storedUser)
    // Asignar los datos del usuario a las variables
    id.value = usuario.id_usuario // Asignar el id_usuario
  }
}

// FUNCION DE LA PETICION CON AXIOS
const getDatos = async () => {
  try {
    const response = await axios.get(`http://localhost:3000/api/ingresarsalas/${id.value}`)
    items.value = response.data.detallesala.map((detallesala: any) => ({
      ...detallesala,
      sala: detallesala.Sala ? detallesala.Sala.sala : 'Desconocido',
      nombre: detallesala.Sala && detallesala.Sala.Usuario ? detallesala.Sala.Usuario.nombre : 'Desconocido'
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

// ----------Darse de baja de UNA SALA--------------------------------------------|
const salir = (item: Detallesala) => {
  console.log('Item a eliminar:', item.sala) // Depuración: Verificar si item es válido

  Swal.fire({
    title: `¿Estás seguro de que desea salir la sala: ${item.sala}?`,
    text: 'No podrás revertir esto!',
    icon: 'question',
    showCancelButton: true,
    confirmButtonColor: '#4F4F75',
    cancelButtonColor: '#FF5733',
    confirmButtonText: 'Sí, Salir!',
    cancelButtonText: 'Cancelar',
    reverseButtons: true // Invierte el orden de los botones (Aceptar primero, Cancelar después)
  }).then(async (result) => {
    if (result.isConfirmed) {
      // Obtener el token del almacenamiento local
      const token = localStorage.getItem('token') // O usa Vuex o cualquier otro método para obtenerlo

      if (!token) {
        Swal.fire('Error', 'Debes iniciar sesión para salir de la sala.', 'error')
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
      const response = await axios.delete(`http://localhost:3000/api/ingresarsalas/${item.id_sala}`, config)
      console.log('Respuesta de la API:', response) // Verificar la respuesta de la API
      // Eliminar de la lista de items
      items.value = items.value.filter(i => i.id_sala !== item.id_sala)
      // Asegurarse de que DataTables se actualice después de eliminar
      datatableKey.value++
      Swal.fire(
        'Exitoso!',
        'Ha salido correctamente.',
        'success'
      )
    }
  })
}
</script>

<style scoped>
</style>
