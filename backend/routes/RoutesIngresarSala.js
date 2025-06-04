/* PASO 3 */
/* ESTE CONTENIDO Y TODO LO RELACIONADO ES PARA QUE EL ALUMNO PUEDA INGRESAR A UNA SALA DE ESTUDIO 03/06/2025 */

const {Router} = require("express");
const { getContoller, postController, deleteController, getControllerAlumSala } = require("../controllers/ControlerIngresarSala");
const { check } = require("express-validator");
const { validar } = require("../middlewares/validarCampos");
const { existeUsuarioId , existeSalaId} = require("../helpers/validacionesBD");

const router = Router();

// GUARDAR Detallesala
router.post('',[
    check('id_sala', 'La sala es obligatoria').not().isEmpty(),
    check('id_sala').custom(existeSalaId),
    check('id_usuario', 'El Usuario es obligatorio').not().isEmpty(),
    check('id_usuario').custom(existeUsuarioId),
    validar,
    // validarJWT
], postController);

// OBTENER TODAS LAS SALAS en la que esta el alumno
// router.get('', getContoller );

// Verificar si la contraseña coincide
router.get('/:id', [
],getContoller );

router.get('/alumnos/:id', [
],getControllerAlumSala );

// darse de baja de la SALA
router.delete('/:id',[
    check('id').custom(existeSalaId),
    validar, 
],deleteController);

// exportar las rutas
module.exports = router;

