const {Router} = require("express");
const { getContoller, postController, putController, deleteController, getIdController, actualizarUsuarioEmpresa, getIdControllerUser } = require("../controllers/empresas");
const { check } = require("express-validator");
const { validar } = require("../middlewares/validarCampos");
const { existePeriodo,  existeEmpresaId , existeUsuarioId} = require("../helpers/validacionesBD");
const { validarJWT } = require("../middlewares/validarJWT");
const { esAdminRol } = require("../middlewares/validarRol");

const router = Router();

router.get('', getContoller );

router.post('',[
    check('empresa', 'El nombre de la empresa es obligatorio').not().isEmpty(),
    check('sigla', 'La sigla es obligatoria').not().isEmpty(),
    check('id_periodo', 'El periodo es obligatorio').not().isEmpty(),
    check('id_periodo').custom(existePeriodo),
    validar,
    // validarJWT
], postController);

router.put('/:id',[
    check('id').custom(existeEmpresaId),
    check('empresa', 'El nombre de la empresa es obligatorio').not().isEmpty(),
    //TODO: EL CORREO DEBE VERIFICARSE PARA USUARIOS QUE NO CUENTEN CON ESTE ID (en el controlador ya esta)
    //check('contra', 'Minimo 8 caracteres para la contraseña').isLength({min:8}),//TODO: La contraseña se va a actualizar por separado
    check('id_periodo').custom(existePeriodo),
    validar,
    // validarJWT
], putController);

router.delete('/:id',[
    check('id').custom(existeEmpresaId),
    validar, 
    // validarJWT,
    // esAdminRol
],deleteController);

//AGREGADOS

router.get('/:id', [
    check('id').custom(existeEmpresaId),
    validar,
    // validarJWT,
    // esAdminRol
],getIdController );

router.get('/usuario/:id', [
    check('id').custom(existeUsuarioId),
    validar,
    // validarJWT,
    // esAdminRol
],getIdControllerUser );

// para asignar la empresa a un usuario
router.patch('/actualizar/:id', actualizarUsuarioEmpresa);


module.exports = router;