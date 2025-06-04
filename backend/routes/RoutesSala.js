/* PASO 3 */
/* ESTE CONTENIDO Y TODO LO RELACIONADO CON SALAS ES UNA PRUEBA PARA
OBTENER LA EMPRESA DEL USUARIO Y ASIGINARLE UNA EMPRESA AL ALUMNO
, ES UNA IDEA QUE PUEDE FUNCIONAR 03/06/2025 */

const {Router} = require("express");
const { getContoller, postController, putController, deleteController, getIdController } = require("../controllers/ControlerSalas");
const { check } = require("express-validator");
const { validar } = require("../middlewares/validarCampos");
const { existeUsuarioId , existeSalaId} = require("../helpers/validacionesBD");

const router = Router();

// GUARDAR SALA
router.post('',[
    check('sala', 'El nombre de la sala es obligatorio').not().isEmpty(),
    check('contra', 'La contraseña es obligatoria').not().isEmpty(),
    check('id_usuario', 'El Usuario es obligatorio').not().isEmpty(),
    check('id_usuario').custom(existeUsuarioId),
    validar,
    // validarJWT
], postController);

// OBTENER TODAS LAS SALAS
router.get('', getContoller );


// MODIFICAR SALA
router.put('/:id',[
    check('id_sala').custom(existeSalaId),
    check('sala', 'El nombre de la sala es obligatorio').not().isEmpty(),
    check('contra', 'La contraseña es obligatoria').not().isEmpty(),
    check('id_usuario').custom(existeUsuarioId),
    validar,
    // validarJWT
], putController);

// ELIMINAR SALA
router.delete('/:id',[
    check('id').custom(existeSalaId),
    validar, 
],deleteController);

// Verificar si la contraseña coincide
router.get('/:id', [
    check('id').custom(existeSalaId),
    validar,
    // validarJWT,
    // esAdminRol
],getIdController );


// exportar las rutas
module.exports = router;

