-- CreateEnum
CREATE TYPE "FuncaoUsuario" AS ENUM ('Admin', 'Analista', 'Supervisor', 'Revisor');

-- CreateEnum
CREATE TYPE "Status_Relatorio" AS ENUM ('Formalizando', 'Finalizado', 'Aprovado', 'Rejeitado', 'Emitido', 'Recuperado', 'Irreversivel');

-- CreateEnum
CREATE TYPE "Natureza_Sinistro" AS ENUM ('Roubo', 'Furto', 'Apreensao', 'Outros');

-- CreateEnum
CREATE TYPE "Tipo_Formulario" AS ENUM ('form1_Cliente_Segurado', 'form2_Caracteristica_Sinistro', 'form3_Cronologia_Sinistro', 'form4_Do_Carregamento', 'form5_Motorista', 'form6_Ajudantes', 'form7_Veiculo_Transportador', 'form8_Orgao_Policial', 'form9_Gerenciamento_Risco_Veiculo', 'form10_Sistemas_Protecao_Carregamento', 'form11_Declaracao_Motorista_Ajudante', 'form12_Gerenciamento_Risco_Deposito', 'form13_Locais_Evento', 'form14_Resumo_Averiguacoes', 'form15_Recuperacao_Carga', 'form16_Anexos_Fotograficos', 'form17_Conclusao');

-- CreateEnum
CREATE TYPE "Status_Formulario" AS ENUM ('Pendente', 'Formalizando', 'Finalizado', 'Aprovado', 'Corrigir', 'Rejeitado');

-- CreateTable
CREATE TABLE "usuarios" (
    "id" TEXT NOT NULL,
    "nome" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "telefone" TEXT,
    "avatar" TEXT,
    "funcao" "FuncaoUsuario" NOT NULL DEFAULT 'Analista',
    "senha_hash" TEXT NOT NULL,
    "criado_em" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "usuarios_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tokens_atualizacao" (
    "id" TEXT NOT NULL,
    "expira_em" INTEGER NOT NULL,
    "usuario_id" TEXT NOT NULL,
    "criado_em" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "tokens_atualizacao_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "relatorios" (
    "id" TEXT NOT NULL,
    "numero_processo" TEXT NOT NULL,
    "natureza_sinistro" "Natureza_Sinistro" NOT NULL,
    "cliente" TEXT NOT NULL,
    "cnpj" TEXT NOT NULL,
    "data_entrada" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "data_emissao" TIMESTAMP(3),
    "status" "Status_Relatorio" NOT NULL DEFAULT 'Formalizando',
    "status_recuperacao_carga" TEXT,
    "fato_gerador_recuperacao_carga" TEXT,
    "usuario_responsavel_id" TEXT NOT NULL,
    "formularios_selecionados" "Tipo_Formulario"[],

    CONSTRAINT "relatorios_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "formularios_do_relatorio" (
    "id" TEXT NOT NULL,
    "numero_processo" TEXT,
    "relatorio_id" TEXT NOT NULL,

    CONSTRAINT "formularios_do_relatorio_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "form1_Cliente_Segurado" (
    "id" TEXT NOT NULL,
    "numero_processo" TEXT NOT NULL,
    "status" "Status_Formulario" NOT NULL DEFAULT 'Pendente',
    "data_cadastro" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "nome_cliente" TEXT NOT NULL,
    "cnpj" TEXT NOT NULL,
    "telefone" TEXT,
    "celular" TEXT,
    "email" TEXT,
    "representante" TEXT,
    "cep" TEXT,
    "endereco" TEXT,
    "numero" TEXT,
    "complemento" TEXT,
    "bairro" TEXT,
    "cidade" TEXT,
    "uf" TEXT,
    "formularioDoRelatorio_id" TEXT NOT NULL,

    CONSTRAINT "form1_Cliente_Segurado_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "form2_Caracteristica_Sinistro" (
    "id" TEXT NOT NULL,
    "numero_processo" TEXT NOT NULL,
    "status" "Status_Formulario" NOT NULL DEFAULT 'Pendente',
    "data_cadastro" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "nome_seguradora" TEXT,
    "natureza_sinistro" "Natureza_Sinistro" NOT NULL,
    "carga_embarcada" TEXT,
    "valor_carga" TEXT,
    "formularioDoRelatorio_id" TEXT,

    CONSTRAINT "form2_Caracteristica_Sinistro_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "form3_Cronologia_Sinistro" (
    "id" TEXT NOT NULL,
    "numero_processo" TEXT NOT NULL,
    "status" "Status_Formulario" NOT NULL DEFAULT 'Pendente',
    "data_cadastro" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "cep_local_sinistro" TEXT,
    "endereco_local_sinistro" TEXT,
    "numero_local_sinistro" TEXT,
    "complemento_local_sinistro" TEXT,
    "bairro_local_sinistro" TEXT,
    "cidade_local_sinistro" TEXT,
    "uf_local_sinistro" TEXT,
    "comunicante" TEXT,
    "data_hora_sinistro" TEXT,
    "data_hora_comunicacao" TEXT,
    "agente_pamcary" TEXT,
    "data_hora_chegada_local" TEXT,
    "formularioDoRelatorio_id" TEXT,

    CONSTRAINT "form3_Cronologia_Sinistro_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "form4_Do_Carregamento" (
    "id" TEXT NOT NULL,
    "numero_processo" TEXT NOT NULL,
    "status" "Status_Formulario" NOT NULL DEFAULT 'Pendente',
    "data_cadastro" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "transportadora" TEXT,
    "valor_embarcado" TEXT,
    "remetente" TEXT,
    "cep_origem" TEXT,
    "endereco_origem" TEXT,
    "numero_origem" TEXT,
    "cidade_origem" TEXT,
    "bairro_origem" TEXT,
    "uf_origem" TEXT,
    "complemento_origem" TEXT,
    "destinatario" TEXT,
    "cep_destino" TEXT,
    "endereco_destino" TEXT,
    "numero_destino" TEXT,
    "cidade_destino" TEXT,
    "bairro_destino" TEXT,
    "uf_destino" TEXT,
    "complemento_destino" TEXT,
    "numero_crtc_dacte" TEXT,
    "numero_nota_fiscal" TEXT,
    "manifesto" TEXT,
    "formularioDoRelatorio_id" TEXT,

    CONSTRAINT "form4_Do_Carregamento_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "form5_Motorista" (
    "id" TEXT NOT NULL,
    "numero_processo" TEXT NOT NULL,
    "status" "Status_Formulario" NOT NULL DEFAULT 'Pendente',
    "data_cadastro" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "nome_motorista" TEXT,
    "cpf_motorista" TEXT,
    "data_nascimento_motorista" TIMESTAMP(3),
    "local_nascimento_motorista" TEXT,
    "cnh_motorista" TEXT,
    "tipo_cnh_motorista" TEXT,
    "validade_cnh_motorista" TEXT,
    "cep_motorista" TEXT,
    "endereco_motorista" TEXT,
    "numero_motorista" TEXT,
    "complemento_motorista" TEXT,
    "bairro_motorista" TEXT,
    "cidade_motorista" TEXT,
    "uf_motorista" TEXT,
    "telefone_motorista" TEXT,
    "celular_motorista" TEXT,
    "email_motorista" TEXT,
    "vinculo_motorista_empresa" TEXT,
    "consulta_telerisco_motorista" TEXT,
    "numero_consulta_telerisco_motorista" TEXT,
    "data_consulta_telerisco_motorista" TEXT,
    "formularioDoRelatorio_id" TEXT,

    CONSTRAINT "form5_Motorista_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "form6_Ajudantes" (
    "id" TEXT NOT NULL,
    "numero_processo" TEXT NOT NULL,
    "status" "Status_Formulario" NOT NULL DEFAULT 'Pendente',
    "data_cadastro" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "nome_ajudante" TEXT,
    "cpf_ajudante" TEXT,
    "data_nascimento_ajudante" TIMESTAMP(3),
    "local_nascimento_ajudante" TEXT,
    "cnh_ajudante" TEXT,
    "tipo_cnh_ajudante" TEXT,
    "validade_cnh_ajudante" TEXT,
    "cep_ajudante" TEXT,
    "endereco_ajudante" TEXT,
    "numero_ajudante" TEXT,
    "complemento_ajudante" TEXT,
    "bairro_ajudante" TEXT,
    "cidade_ajudante" TEXT,
    "uf_ajudante" TEXT,
    "telefone_ajudante" TEXT,
    "celular_ajudante" TEXT,
    "email_ajudante" TEXT,
    "vinculo_ajudante_empresa" TEXT,
    "formularioDoRelatorio_id" TEXT,

    CONSTRAINT "form6_Ajudantes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "form7_Veiculo_Transportador" (
    "id" TEXT NOT NULL,
    "numero_processo" TEXT NOT NULL,
    "status" "Status_Formulario" NOT NULL DEFAULT 'Pendente',
    "data_cadastro" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "placa_cavalo_mecanico" TEXT,
    "renavam_cavalo_mecanico" TEXT,
    "chassi_cavalo_mecanico" TEXT,
    "marca_cavalo_mecanico" TEXT,
    "modelo_cavalo_mecanico" TEXT,
    "ano_fabricacao_cavalo_mecanico" TEXT,
    "ano_modelo_cavalo_mecanico" TEXT,
    "cor_cavalo_mecanico" TEXT,
    "proprietario_cavalo_mecanico" TEXT,
    "cpf_cnpj_proprietario_cavalo_mecanico" TEXT,
    "uf_cavalo_mecanico" TEXT,
    "placa_carreta" TEXT,
    "renavam_carreta" TEXT,
    "chassi_carreta" TEXT,
    "marca_carreta" TEXT,
    "modelo_carreta" TEXT,
    "ano_fabricacao_carreta" TEXT,
    "ano_modelo_carreta" TEXT,
    "cor_carreta" TEXT,
    "proprietario_carreta" TEXT,
    "cpf_cnpj_proprietario_carreta" TEXT,
    "uf_carreta" TEXT,
    "formularioDoRelatorio_id" TEXT,

    CONSTRAINT "form7_Veiculo_Transportador_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "form8_Orgao_Policial" (
    "id" TEXT NOT NULL,
    "numero_processo" TEXT NOT NULL,
    "status" "Status_Formulario" NOT NULL DEFAULT 'Pendente',
    "data_cadastro" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "delegacia" TEXT,
    "endereco_delegacia" TEXT,
    "numero_delegacia" TEXT,
    "bairro_delegacia" TEXT,
    "cidade_delegacia" TEXT,
    "uf_delegacia" TEXT,
    "cep_delegacia" TEXT,
    "telefone_delegacia" TEXT,
    "numero_bo" TEXT,
    "data_bo" TEXT,
    "numero_ip" TEXT,
    "data_ip" TEXT,
    "formularioDoRelatorio_id" TEXT,

    CONSTRAINT "form8_Orgao_Policial_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "form9_Gerenciamento_Risco_Veiculo" (
    "id" TEXT NOT NULL,
    "numero_processo" TEXT NOT NULL,
    "status" "Status_Formulario" NOT NULL DEFAULT 'Pendente',
    "data_cadastro" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "rastreador_sistema_rastreamento" TEXT,
    "rastreador_marca" TEXT,
    "rastreador_modelo" TEXT,
    "rastreador_tipo" TEXT,
    "rastreador_posicionamento" TEXT,
    "segunda_tecnologia_rastreamento" TEXT,
    "segunda_tecnologia_marca" TEXT,
    "segunda_tecnologia_modelo" TEXT,
    "segunda_tecnologia_tipo" TEXT,
    "segunda_tecnologia_posicionamento" TEXT,
    "outros_sistemas_rastreamento" TEXT,
    "outros_sistemas_marca" TEXT,
    "outros_sistemas_modelo" TEXT,
    "outros_sistemas_tipo" TEXT,
    "outros_sistemas_posicionamento" TEXT,
    "sensor_bloqueio_combustivel" BOOLEAN DEFAULT false,
    "sensor_bloqueio_ignicao" BOOLEAN DEFAULT false,
    "sensor_trava_5Roda" BOOLEAN DEFAULT false,
    "sensor_trava_portas_bau" BOOLEAN DEFAULT false,
    "sensor_porta_cabine" BOOLEAN DEFAULT false,
    "sensor_porta_bau" BOOLEAN DEFAULT false,
    "sensor_isca" BOOLEAN DEFAULT false,
    "sensor_sonoros_visuais" BOOLEAN DEFAULT false,
    "sensor_botao_panico" BOOLEAN DEFAULT false,
    "sensor_teclado" BOOLEAN DEFAULT false,
    "sensor_desengate_carreta" BOOLEAN DEFAULT false,
    "sensor_outros" BOOLEAN DEFAULT false,
    "sensor_outros_descricao" TEXT,
    "plano_viagem" BOOLEAN DEFAULT false,
    "tacografo" BOOLEAN DEFAULT false,
    "paradas_nao_programadas" BOOLEAN DEFAULT false,
    "rastramento_analisado" BOOLEAN DEFAULT false,
    "tacografo_analisado" BOOLEAN DEFAULT false,
    "historico_rastreamento" BOOLEAN DEFAULT false,
    "macros_transmitida" BOOLEAN DEFAULT false,
    "sirene_ativada" BOOLEAN DEFAULT false,
    "bloqueio_rastreador" BOOLEAN DEFAULT false,
    "vandalismo_rastreador" BOOLEAN DEFAULT false,
    "ultima_posicao_rastreamento_data_hora" TEXT,
    "ultima_posicao_rastreamento_descricao" TEXT,
    "disco_tacografo_data_hora" TEXT,
    "disco_tacografo_descricao" TEXT,
    "formularioDoRelatorio_id" TEXT,

    CONSTRAINT "form9_Gerenciamento_Risco_Veiculo_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "form10_Sistemas_Protecao_Carregamento" (
    "id" TEXT NOT NULL,
    "numero_processo" TEXT NOT NULL,
    "status" "Status_Formulario" NOT NULL DEFAULT 'Pendente',
    "data_cadastro" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "protecao_escolta" BOOLEAN DEFAULT false,
    "protecao_comboio" BOOLEAN DEFAULT false,
    "protecao_velada" BOOLEAN DEFAULT false,
    "protecao_outros" BOOLEAN DEFAULT false,
    "protecao_veiculos" TEXT,
    "formularioDoRelatorio_id" TEXT,

    CONSTRAINT "form10_Sistemas_Protecao_Carregamento_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "form11_Declaracao_Motorista_Ajudante" (
    "id" TEXT NOT NULL,
    "numero_processo" TEXT NOT NULL,
    "status" "Status_Formulario" NOT NULL DEFAULT 'Pendente',
    "data_cadastro" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "formularioDoRelatorio_id" TEXT,

    CONSTRAINT "form11_Declaracao_Motorista_Ajudante_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "form12_Gerenciamento_Risco_Deposito" (
    "id" TEXT NOT NULL,
    "numero_processo" TEXT NOT NULL,
    "status" "Status_Formulario" NOT NULL DEFAULT 'Pendente',
    "data_cadastro" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deposito_sinistrado_segurado" BOOLEAN DEFAULT false,
    "deposito_seguranca_eletronica" BOOLEAN DEFAULT false,
    "deposito_seguranca_patrimonial" BOOLEAN DEFAULT false,
    "deposito_mercadoria_carregada" BOOLEAN DEFAULT false,
    "dispositivo_seguranca_cftv" BOOLEAN DEFAULT false,
    "dispositivo_seguranca_botao_panico" BOOLEAN DEFAULT false,
    "dispositivo_seguranca_alarme_sonoro" BOOLEAN DEFAULT false,
    "dispositivo_seguranca_sensores_invasao" BOOLEAN DEFAULT false,
    "dispositivo_seguranca_cerca_eletrica" BOOLEAN DEFAULT false,
    "dispositivo_seguranca_sensores_presenca" BOOLEAN DEFAULT false,
    "dispositivo_seguranca_sirene" BOOLEAN DEFAULT false,
    "dispositivo_seguranca_outros" BOOLEAN DEFAULT false,
    "empresa_seguranca_patrimonial_nome" TEXT,
    "empresa_seguranca_patrimonial_cnpj" TEXT,
    "empresa_seguranca_patrimonial_cep" TEXT,
    "empresa_seguranca_patrimonial_endereco" TEXT,
    "empresa_seguranca_patrimonial_numero" TEXT,
    "empresa_seguranca_patrimonial_complemento" TEXT,
    "empresa_seguranca_patrimonial_bairro" TEXT,
    "empresa_seguranca_patrimonial_cidade" TEXT,
    "empresa_seguranca_patrimonial_uf" TEXT,
    "empresa_seguranca_patrimonial_telefone" TEXT,
    "empresa_seguranca_patrimonial_celular" TEXT,
    "empresa_seguranca_patrimonial_email" TEXT,
    "empresa_seguranca_patrimonial_representante" TEXT,
    "formularioDoRelatorio_id" TEXT,

    CONSTRAINT "form12_Gerenciamento_Risco_Deposito_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "form13_Locais_Evento" (
    "id" TEXT NOT NULL,
    "numero_processo" TEXT NOT NULL,
    "status" "Status_Formulario" NOT NULL DEFAULT 'Pendente',
    "data_cadastro" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "local_abordagem_rodovia" TEXT,
    "local_abordagem_cep" TEXT,
    "local_abordagem_endereco" TEXT,
    "local_abordagem_numero" TEXT,
    "local_abordagem_complemento" TEXT,
    "local_abordagem_bairro" TEXT,
    "local_abordagem_cidade" TEXT,
    "local_abordagem_uf" TEXT,
    "local_abordagem_ponto_referencia" TEXT,
    "local_abordagem_latitude" TEXT,
    "local_abordagem_longitude" TEXT,
    "local_abordagem_data_hora" TEXT,
    "local_abordagem_cftv" BOOLEAN DEFAULT false,
    "local_abordagem_testemunhas" BOOLEAN DEFAULT false,
    "local_cativeiro_rodovia" TEXT,
    "local_cativeiro_cep" TEXT,
    "local_cativeiro_endereco" TEXT,
    "local_cativeiro_numero" TEXT,
    "local_cativeiro_complemento" TEXT,
    "local_cativeiro_bairro" TEXT,
    "local_cativeiro_cidade" TEXT,
    "local_cativeiro_uf" TEXT,
    "local_cativeiro_ponto_referencia" TEXT,
    "local_cativeiro_latitude" TEXT,
    "local_cativeiro_longitude" TEXT,
    "local_cativeiro_data_hora" TEXT,
    "local_cativeiro_cftv" BOOLEAN DEFAULT false,
    "local_cativeiro_testemunhas" BOOLEAN DEFAULT false,
    "local_encontro_rodovia" TEXT,
    "local_encontro_cep" TEXT,
    "local_encontro_endereco" TEXT,
    "local_encontro_numero" TEXT,
    "local_encontro_complemento" TEXT,
    "local_encontro_bairro" TEXT,
    "local_encontro_cidade" TEXT,
    "local_encontro_uf" TEXT,
    "local_encontro_ponto_referencia" TEXT,
    "local_encontro_latitude" TEXT,
    "local_encontro_longitude" TEXT,
    "local_encontro_data_hora" TEXT,
    "local_encontro_cftv" BOOLEAN DEFAULT false,
    "local_encontro_testemunhas" BOOLEAN DEFAULT false,
    "local_recuperacao_rodovia" TEXT,
    "local_recuperacao_cep" TEXT,
    "local_recuperacao_endereco" TEXT,
    "local_recuperacao_numero" TEXT,
    "local_recuperacao_complemento" TEXT,
    "local_recuperacao_bairro" TEXT,
    "local_recuperacao_cidade" TEXT,
    "local_recuperacao_uf" TEXT,
    "local_recuperacao_ponto_referencia" TEXT,
    "local_recuperacao_latitude" TEXT,
    "local_recuperacao_longitude" TEXT,
    "local_recuperacao_data_hora" TEXT,
    "local_recuperacao_cftv" BOOLEAN DEFAULT false,
    "local_recuperacao_testemunhas" BOOLEAN DEFAULT false,
    "formularioDoRelatorio_id" TEXT,

    CONSTRAINT "form13_Locais_Evento_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "form14_Resumo_Averiguacoes" (
    "id" TEXT NOT NULL,
    "numero_processo" TEXT NOT NULL,
    "status" "Status_Formulario" NOT NULL DEFAULT 'Pendente',
    "data_cadastro" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "resumo_averiguacoes" TEXT,
    "formularioDoRelatorio_id" TEXT,

    CONSTRAINT "form14_Resumo_Averiguacoes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "form15_Recuperacao_Carga" (
    "id" TEXT NOT NULL,
    "numero_processo" TEXT NOT NULL,
    "status" "Status_Formulario" NOT NULL DEFAULT 'Pendente',
    "data_cadastro" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "recuperacao_carga_recuperada" BOOLEAN DEFAULT false,
    "recuperacao_carga_parcial" BOOLEAN DEFAULT false,
    "fato_gerador_recuperacao_carga" TEXT,
    "formularioDoRelatorio_id" TEXT,

    CONSTRAINT "form15_Recuperacao_Carga_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "form16_Anexos_Fotograficos" (
    "id" TEXT NOT NULL,
    "numero_processo" TEXT NOT NULL,
    "status" "Status_Formulario" NOT NULL DEFAULT 'Pendente',
    "data_cadastro" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "formularioDoRelatorio_id" TEXT,

    CONSTRAINT "form16_Anexos_Fotograficos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "form17_Conclusao" (
    "id" TEXT NOT NULL,
    "numero_processo" TEXT NOT NULL,
    "status" "Status_Formulario" NOT NULL DEFAULT 'Pendente',
    "data_cadastro" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "conclusao_averiguacoes" TEXT,
    "formularioDoRelatorio_id" TEXT,

    CONSTRAINT "form17_Conclusao_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "arquivos" (
    "id" TEXT NOT NULL,
    "numero_processo" TEXT NOT NULL,
    "relatorio_id" TEXT NOT NULL,
    "data_cadastro" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "form_id" TEXT,
    "form_nome" TEXT,
    "form_arquivo_campo_nome" TEXT,
    "arquivo_nome" TEXT,
    "arquivo_tamanho" INTEGER,
    "arquivo_chave" TEXT NOT NULL,
    "arquivo_localizacao" TEXT NOT NULL,

    CONSTRAINT "arquivos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_Usuarios_Permitidos_Para_Relatorio" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_declaracao_motorista_ajudante" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_fotos_local_da_abordagem" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_fotos_local_de_cativeiro_e_abandono_do_motorista" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_fotos_local_de_encontro_do_veiculo" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_fotos_local_de_recuperacao_da_carga" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_anexos_fotograficos" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "usuarios_email_key" ON "usuarios"("email");

-- CreateIndex
CREATE UNIQUE INDEX "tokens_atualizacao_usuario_id_key" ON "tokens_atualizacao"("usuario_id");

-- CreateIndex
CREATE UNIQUE INDEX "relatorios_numero_processo_key" ON "relatorios"("numero_processo");

-- CreateIndex
CREATE UNIQUE INDEX "formularios_do_relatorio_numero_processo_key" ON "formularios_do_relatorio"("numero_processo");

-- CreateIndex
CREATE UNIQUE INDEX "formularios_do_relatorio_relatorio_id_key" ON "formularios_do_relatorio"("relatorio_id");

-- CreateIndex
CREATE UNIQUE INDEX "form1_Cliente_Segurado_numero_processo_key" ON "form1_Cliente_Segurado"("numero_processo");

-- CreateIndex
CREATE UNIQUE INDEX "form1_Cliente_Segurado_formularioDoRelatorio_id_key" ON "form1_Cliente_Segurado"("formularioDoRelatorio_id");

-- CreateIndex
CREATE UNIQUE INDEX "form2_Caracteristica_Sinistro_numero_processo_key" ON "form2_Caracteristica_Sinistro"("numero_processo");

-- CreateIndex
CREATE UNIQUE INDEX "form2_Caracteristica_Sinistro_formularioDoRelatorio_id_key" ON "form2_Caracteristica_Sinistro"("formularioDoRelatorio_id");

-- CreateIndex
CREATE UNIQUE INDEX "form3_Cronologia_Sinistro_numero_processo_key" ON "form3_Cronologia_Sinistro"("numero_processo");

-- CreateIndex
CREATE UNIQUE INDEX "form3_Cronologia_Sinistro_formularioDoRelatorio_id_key" ON "form3_Cronologia_Sinistro"("formularioDoRelatorio_id");

-- CreateIndex
CREATE UNIQUE INDEX "form4_Do_Carregamento_numero_processo_key" ON "form4_Do_Carregamento"("numero_processo");

-- CreateIndex
CREATE UNIQUE INDEX "form4_Do_Carregamento_formularioDoRelatorio_id_key" ON "form4_Do_Carregamento"("formularioDoRelatorio_id");

-- CreateIndex
CREATE UNIQUE INDEX "form5_Motorista_numero_processo_key" ON "form5_Motorista"("numero_processo");

-- CreateIndex
CREATE UNIQUE INDEX "form5_Motorista_formularioDoRelatorio_id_key" ON "form5_Motorista"("formularioDoRelatorio_id");

-- CreateIndex
CREATE UNIQUE INDEX "form6_Ajudantes_numero_processo_key" ON "form6_Ajudantes"("numero_processo");

-- CreateIndex
CREATE UNIQUE INDEX "form6_Ajudantes_formularioDoRelatorio_id_key" ON "form6_Ajudantes"("formularioDoRelatorio_id");

-- CreateIndex
CREATE UNIQUE INDEX "form7_Veiculo_Transportador_numero_processo_key" ON "form7_Veiculo_Transportador"("numero_processo");

-- CreateIndex
CREATE UNIQUE INDEX "form7_Veiculo_Transportador_formularioDoRelatorio_id_key" ON "form7_Veiculo_Transportador"("formularioDoRelatorio_id");

-- CreateIndex
CREATE UNIQUE INDEX "form8_Orgao_Policial_numero_processo_key" ON "form8_Orgao_Policial"("numero_processo");

-- CreateIndex
CREATE UNIQUE INDEX "form8_Orgao_Policial_formularioDoRelatorio_id_key" ON "form8_Orgao_Policial"("formularioDoRelatorio_id");

-- CreateIndex
CREATE UNIQUE INDEX "form9_Gerenciamento_Risco_Veiculo_numero_processo_key" ON "form9_Gerenciamento_Risco_Veiculo"("numero_processo");

-- CreateIndex
CREATE UNIQUE INDEX "form9_Gerenciamento_Risco_Veiculo_formularioDoRelatorio_id_key" ON "form9_Gerenciamento_Risco_Veiculo"("formularioDoRelatorio_id");

-- CreateIndex
CREATE UNIQUE INDEX "form10_Sistemas_Protecao_Carregamento_numero_processo_key" ON "form10_Sistemas_Protecao_Carregamento"("numero_processo");

-- CreateIndex
CREATE UNIQUE INDEX "form10_Sistemas_Protecao_Carregamento_formularioDoRelatorio_key" ON "form10_Sistemas_Protecao_Carregamento"("formularioDoRelatorio_id");

-- CreateIndex
CREATE UNIQUE INDEX "form11_Declaracao_Motorista_Ajudante_numero_processo_key" ON "form11_Declaracao_Motorista_Ajudante"("numero_processo");

-- CreateIndex
CREATE UNIQUE INDEX "form11_Declaracao_Motorista_Ajudante_formularioDoRelatorio__key" ON "form11_Declaracao_Motorista_Ajudante"("formularioDoRelatorio_id");

-- CreateIndex
CREATE UNIQUE INDEX "form12_Gerenciamento_Risco_Deposito_numero_processo_key" ON "form12_Gerenciamento_Risco_Deposito"("numero_processo");

-- CreateIndex
CREATE UNIQUE INDEX "form12_Gerenciamento_Risco_Deposito_formularioDoRelatorio_i_key" ON "form12_Gerenciamento_Risco_Deposito"("formularioDoRelatorio_id");

-- CreateIndex
CREATE UNIQUE INDEX "form13_Locais_Evento_numero_processo_key" ON "form13_Locais_Evento"("numero_processo");

-- CreateIndex
CREATE UNIQUE INDEX "form13_Locais_Evento_formularioDoRelatorio_id_key" ON "form13_Locais_Evento"("formularioDoRelatorio_id");

-- CreateIndex
CREATE UNIQUE INDEX "form14_Resumo_Averiguacoes_numero_processo_key" ON "form14_Resumo_Averiguacoes"("numero_processo");

-- CreateIndex
CREATE UNIQUE INDEX "form14_Resumo_Averiguacoes_formularioDoRelatorio_id_key" ON "form14_Resumo_Averiguacoes"("formularioDoRelatorio_id");

-- CreateIndex
CREATE UNIQUE INDEX "form15_Recuperacao_Carga_numero_processo_key" ON "form15_Recuperacao_Carga"("numero_processo");

-- CreateIndex
CREATE UNIQUE INDEX "form15_Recuperacao_Carga_formularioDoRelatorio_id_key" ON "form15_Recuperacao_Carga"("formularioDoRelatorio_id");

-- CreateIndex
CREATE UNIQUE INDEX "form16_Anexos_Fotograficos_numero_processo_key" ON "form16_Anexos_Fotograficos"("numero_processo");

-- CreateIndex
CREATE UNIQUE INDEX "form16_Anexos_Fotograficos_formularioDoRelatorio_id_key" ON "form16_Anexos_Fotograficos"("formularioDoRelatorio_id");

-- CreateIndex
CREATE UNIQUE INDEX "form17_Conclusao_numero_processo_key" ON "form17_Conclusao"("numero_processo");

-- CreateIndex
CREATE UNIQUE INDEX "form17_Conclusao_formularioDoRelatorio_id_key" ON "form17_Conclusao"("formularioDoRelatorio_id");

-- CreateIndex
CREATE UNIQUE INDEX "_Usuarios_Permitidos_Para_Relatorio_AB_unique" ON "_Usuarios_Permitidos_Para_Relatorio"("A", "B");

-- CreateIndex
CREATE INDEX "_Usuarios_Permitidos_Para_Relatorio_B_index" ON "_Usuarios_Permitidos_Para_Relatorio"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_declaracao_motorista_ajudante_AB_unique" ON "_declaracao_motorista_ajudante"("A", "B");

-- CreateIndex
CREATE INDEX "_declaracao_motorista_ajudante_B_index" ON "_declaracao_motorista_ajudante"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_fotos_local_da_abordagem_AB_unique" ON "_fotos_local_da_abordagem"("A", "B");

-- CreateIndex
CREATE INDEX "_fotos_local_da_abordagem_B_index" ON "_fotos_local_da_abordagem"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_fotos_local_de_cativeiro_e_abandono_do_motorista_AB_unique" ON "_fotos_local_de_cativeiro_e_abandono_do_motorista"("A", "B");

-- CreateIndex
CREATE INDEX "_fotos_local_de_cativeiro_e_abandono_do_motorista_B_index" ON "_fotos_local_de_cativeiro_e_abandono_do_motorista"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_fotos_local_de_encontro_do_veiculo_AB_unique" ON "_fotos_local_de_encontro_do_veiculo"("A", "B");

-- CreateIndex
CREATE INDEX "_fotos_local_de_encontro_do_veiculo_B_index" ON "_fotos_local_de_encontro_do_veiculo"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_fotos_local_de_recuperacao_da_carga_AB_unique" ON "_fotos_local_de_recuperacao_da_carga"("A", "B");

-- CreateIndex
CREATE INDEX "_fotos_local_de_recuperacao_da_carga_B_index" ON "_fotos_local_de_recuperacao_da_carga"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_anexos_fotograficos_AB_unique" ON "_anexos_fotograficos"("A", "B");

-- CreateIndex
CREATE INDEX "_anexos_fotograficos_B_index" ON "_anexos_fotograficos"("B");

-- AddForeignKey
ALTER TABLE "tokens_atualizacao" ADD CONSTRAINT "tokens_atualizacao_usuario_id_fkey" FOREIGN KEY ("usuario_id") REFERENCES "usuarios"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "relatorios" ADD CONSTRAINT "relatorios_usuario_responsavel_id_fkey" FOREIGN KEY ("usuario_responsavel_id") REFERENCES "usuarios"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "formularios_do_relatorio" ADD CONSTRAINT "formularios_do_relatorio_relatorio_id_fkey" FOREIGN KEY ("relatorio_id") REFERENCES "relatorios"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "form1_Cliente_Segurado" ADD CONSTRAINT "form1_Cliente_Segurado_formularioDoRelatorio_id_fkey" FOREIGN KEY ("formularioDoRelatorio_id") REFERENCES "formularios_do_relatorio"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "form2_Caracteristica_Sinistro" ADD CONSTRAINT "form2_Caracteristica_Sinistro_formularioDoRelatorio_id_fkey" FOREIGN KEY ("formularioDoRelatorio_id") REFERENCES "formularios_do_relatorio"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "form3_Cronologia_Sinistro" ADD CONSTRAINT "form3_Cronologia_Sinistro_formularioDoRelatorio_id_fkey" FOREIGN KEY ("formularioDoRelatorio_id") REFERENCES "formularios_do_relatorio"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "form4_Do_Carregamento" ADD CONSTRAINT "form4_Do_Carregamento_formularioDoRelatorio_id_fkey" FOREIGN KEY ("formularioDoRelatorio_id") REFERENCES "formularios_do_relatorio"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "form5_Motorista" ADD CONSTRAINT "form5_Motorista_formularioDoRelatorio_id_fkey" FOREIGN KEY ("formularioDoRelatorio_id") REFERENCES "formularios_do_relatorio"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "form6_Ajudantes" ADD CONSTRAINT "form6_Ajudantes_formularioDoRelatorio_id_fkey" FOREIGN KEY ("formularioDoRelatorio_id") REFERENCES "formularios_do_relatorio"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "form7_Veiculo_Transportador" ADD CONSTRAINT "form7_Veiculo_Transportador_formularioDoRelatorio_id_fkey" FOREIGN KEY ("formularioDoRelatorio_id") REFERENCES "formularios_do_relatorio"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "form8_Orgao_Policial" ADD CONSTRAINT "form8_Orgao_Policial_formularioDoRelatorio_id_fkey" FOREIGN KEY ("formularioDoRelatorio_id") REFERENCES "formularios_do_relatorio"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "form9_Gerenciamento_Risco_Veiculo" ADD CONSTRAINT "form9_Gerenciamento_Risco_Veiculo_formularioDoRelatorio_id_fkey" FOREIGN KEY ("formularioDoRelatorio_id") REFERENCES "formularios_do_relatorio"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "form10_Sistemas_Protecao_Carregamento" ADD CONSTRAINT "form10_Sistemas_Protecao_Carregamento_formularioDoRelatori_fkey" FOREIGN KEY ("formularioDoRelatorio_id") REFERENCES "formularios_do_relatorio"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "form11_Declaracao_Motorista_Ajudante" ADD CONSTRAINT "form11_Declaracao_Motorista_Ajudante_formularioDoRelatorio_fkey" FOREIGN KEY ("formularioDoRelatorio_id") REFERENCES "formularios_do_relatorio"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "form12_Gerenciamento_Risco_Deposito" ADD CONSTRAINT "form12_Gerenciamento_Risco_Deposito_formularioDoRelatorio__fkey" FOREIGN KEY ("formularioDoRelatorio_id") REFERENCES "formularios_do_relatorio"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "form13_Locais_Evento" ADD CONSTRAINT "form13_Locais_Evento_formularioDoRelatorio_id_fkey" FOREIGN KEY ("formularioDoRelatorio_id") REFERENCES "formularios_do_relatorio"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "form14_Resumo_Averiguacoes" ADD CONSTRAINT "form14_Resumo_Averiguacoes_formularioDoRelatorio_id_fkey" FOREIGN KEY ("formularioDoRelatorio_id") REFERENCES "formularios_do_relatorio"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "form15_Recuperacao_Carga" ADD CONSTRAINT "form15_Recuperacao_Carga_formularioDoRelatorio_id_fkey" FOREIGN KEY ("formularioDoRelatorio_id") REFERENCES "formularios_do_relatorio"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "form16_Anexos_Fotograficos" ADD CONSTRAINT "form16_Anexos_Fotograficos_formularioDoRelatorio_id_fkey" FOREIGN KEY ("formularioDoRelatorio_id") REFERENCES "formularios_do_relatorio"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "form17_Conclusao" ADD CONSTRAINT "form17_Conclusao_formularioDoRelatorio_id_fkey" FOREIGN KEY ("formularioDoRelatorio_id") REFERENCES "formularios_do_relatorio"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_Usuarios_Permitidos_Para_Relatorio" ADD CONSTRAINT "_Usuarios_Permitidos_Para_Relatorio_A_fkey" FOREIGN KEY ("A") REFERENCES "relatorios"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_Usuarios_Permitidos_Para_Relatorio" ADD CONSTRAINT "_Usuarios_Permitidos_Para_Relatorio_B_fkey" FOREIGN KEY ("B") REFERENCES "usuarios"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_declaracao_motorista_ajudante" ADD CONSTRAINT "_declaracao_motorista_ajudante_A_fkey" FOREIGN KEY ("A") REFERENCES "arquivos"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_declaracao_motorista_ajudante" ADD CONSTRAINT "_declaracao_motorista_ajudante_B_fkey" FOREIGN KEY ("B") REFERENCES "form11_Declaracao_Motorista_Ajudante"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_fotos_local_da_abordagem" ADD CONSTRAINT "_fotos_local_da_abordagem_A_fkey" FOREIGN KEY ("A") REFERENCES "arquivos"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_fotos_local_da_abordagem" ADD CONSTRAINT "_fotos_local_da_abordagem_B_fkey" FOREIGN KEY ("B") REFERENCES "form13_Locais_Evento"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_fotos_local_de_cativeiro_e_abandono_do_motorista" ADD CONSTRAINT "_fotos_local_de_cativeiro_e_abandono_do_motorista_A_fkey" FOREIGN KEY ("A") REFERENCES "arquivos"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_fotos_local_de_cativeiro_e_abandono_do_motorista" ADD CONSTRAINT "_fotos_local_de_cativeiro_e_abandono_do_motorista_B_fkey" FOREIGN KEY ("B") REFERENCES "form13_Locais_Evento"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_fotos_local_de_encontro_do_veiculo" ADD CONSTRAINT "_fotos_local_de_encontro_do_veiculo_A_fkey" FOREIGN KEY ("A") REFERENCES "arquivos"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_fotos_local_de_encontro_do_veiculo" ADD CONSTRAINT "_fotos_local_de_encontro_do_veiculo_B_fkey" FOREIGN KEY ("B") REFERENCES "form13_Locais_Evento"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_fotos_local_de_recuperacao_da_carga" ADD CONSTRAINT "_fotos_local_de_recuperacao_da_carga_A_fkey" FOREIGN KEY ("A") REFERENCES "arquivos"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_fotos_local_de_recuperacao_da_carga" ADD CONSTRAINT "_fotos_local_de_recuperacao_da_carga_B_fkey" FOREIGN KEY ("B") REFERENCES "form13_Locais_Evento"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_anexos_fotograficos" ADD CONSTRAINT "_anexos_fotograficos_A_fkey" FOREIGN KEY ("A") REFERENCES "arquivos"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_anexos_fotograficos" ADD CONSTRAINT "_anexos_fotograficos_B_fkey" FOREIGN KEY ("B") REFERENCES "form16_Anexos_Fotograficos"("id") ON DELETE CASCADE ON UPDATE CASCADE;
