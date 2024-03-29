import { FuncaoUsuario } from "@prisma/client";
import { Router } from "express";

import { verificarAutenticacao } from "@/middlewares/VerificarAutenticacao";
import { permicaoParaAcesso } from "@/middlewares/PermicaoParaAcesso";

import { Form1ClienteSeguradoController } from "@/controllers/formulario/Form1ClienteSeguradoController";

const form1ClienteSeguradoController = new Form1ClienteSeguradoController();

export const form1ClienteSeguradoRoutes = Router();

//POST - /form1-cliente-segurado/:numero_processo/:relatorio_id
form1ClienteSeguradoRoutes.post(
    "/:numero_processo/:relatorio_id",
    verificarAutenticacao,
    form1ClienteSeguradoController.create
);

//GET - /form1-cliente-segurado/:numero_processo/:relatorio_id
form1ClienteSeguradoRoutes.get(
    "/:numero_processo/:relatorio_id",
    verificarAutenticacao,
    form1ClienteSeguradoController.show
);

//PUT - /form1-cliente-segurado/:numero_processo/:relatorio_id
form1ClienteSeguradoRoutes.put(
    "/:numero_processo/:relatorio_id",
    verificarAutenticacao,
    form1ClienteSeguradoController.update
);

//DELETE - /form1-cliente-segurado/:numero_processo/:relatorio_id
form1ClienteSeguradoRoutes.delete(
    "/:numero_processo/:relatorio_id",
    verificarAutenticacao,
    permicaoParaAcesso([FuncaoUsuario.Supervisor, FuncaoUsuario.Admin]),
    form1ClienteSeguradoController.delete
);
