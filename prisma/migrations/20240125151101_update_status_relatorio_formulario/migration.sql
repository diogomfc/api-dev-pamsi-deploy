/*
  Warnings:

  - The values [Finalizado,Rejeitado] on the enum `Status_Formulario` will be removed. If these variants are still used in the database, this will fail.
  - The values [Finalizado,Rejeitado] on the enum `Status_Relatorio` will be removed. If these variants are still used in the database, this will fail.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "Status_Formulario_new" AS ENUM ('Pendente', 'Formalizando', 'Revisao', 'Aprovado', 'Corrigir');
ALTER TABLE "form7_Veiculo_Transportador" ALTER COLUMN "status" DROP DEFAULT;
ALTER TABLE "form13_Locais_Evento" ALTER COLUMN "status" DROP DEFAULT;
ALTER TABLE "form9_Gerenciamento_Risco_Veiculo" ALTER COLUMN "status" DROP DEFAULT;
ALTER TABLE "form4_Do_Carregamento" ALTER COLUMN "status" DROP DEFAULT;
ALTER TABLE "form16_Anexos_Fotograficos" ALTER COLUMN "status" DROP DEFAULT;
ALTER TABLE "form2_Caracteristica_Sinistro" ALTER COLUMN "status" DROP DEFAULT;
ALTER TABLE "form3_Cronologia_Sinistro" ALTER COLUMN "status" DROP DEFAULT;
ALTER TABLE "form17_Conclusao" ALTER COLUMN "status" DROP DEFAULT;
ALTER TABLE "form8_Orgao_Policial" ALTER COLUMN "status" DROP DEFAULT;
ALTER TABLE "form6_Ajudantes" ALTER COLUMN "status" DROP DEFAULT;
ALTER TABLE "form11_Declaracao_Motorista_Ajudante" ALTER COLUMN "status" DROP DEFAULT;
ALTER TABLE "form12_Gerenciamento_Risco_Deposito" ALTER COLUMN "status" DROP DEFAULT;
ALTER TABLE "form1_Cliente_Segurado" ALTER COLUMN "status" DROP DEFAULT;
ALTER TABLE "form15_Recuperacao_Carga" ALTER COLUMN "status" DROP DEFAULT;
ALTER TABLE "form5_Motorista" ALTER COLUMN "status" DROP DEFAULT;
ALTER TABLE "form10_Sistemas_Protecao_Carregamento" ALTER COLUMN "status" DROP DEFAULT;
ALTER TABLE "form14_Resumo_Averiguacoes" ALTER COLUMN "status" DROP DEFAULT;
ALTER TABLE "form1_Cliente_Segurado" ALTER COLUMN "status" TYPE "Status_Formulario_new" USING ("status"::text::"Status_Formulario_new");
ALTER TABLE "form2_Caracteristica_Sinistro" ALTER COLUMN "status" TYPE "Status_Formulario_new" USING ("status"::text::"Status_Formulario_new");
ALTER TABLE "form3_Cronologia_Sinistro" ALTER COLUMN "status" TYPE "Status_Formulario_new" USING ("status"::text::"Status_Formulario_new");
ALTER TABLE "form4_Do_Carregamento" ALTER COLUMN "status" TYPE "Status_Formulario_new" USING ("status"::text::"Status_Formulario_new");
ALTER TABLE "form5_Motorista" ALTER COLUMN "status" TYPE "Status_Formulario_new" USING ("status"::text::"Status_Formulario_new");
ALTER TABLE "form6_Ajudantes" ALTER COLUMN "status" TYPE "Status_Formulario_new" USING ("status"::text::"Status_Formulario_new");
ALTER TABLE "form7_Veiculo_Transportador" ALTER COLUMN "status" TYPE "Status_Formulario_new" USING ("status"::text::"Status_Formulario_new");
ALTER TABLE "form8_Orgao_Policial" ALTER COLUMN "status" TYPE "Status_Formulario_new" USING ("status"::text::"Status_Formulario_new");
ALTER TABLE "form9_Gerenciamento_Risco_Veiculo" ALTER COLUMN "status" TYPE "Status_Formulario_new" USING ("status"::text::"Status_Formulario_new");
ALTER TABLE "form10_Sistemas_Protecao_Carregamento" ALTER COLUMN "status" TYPE "Status_Formulario_new" USING ("status"::text::"Status_Formulario_new");
ALTER TABLE "form11_Declaracao_Motorista_Ajudante" ALTER COLUMN "status" TYPE "Status_Formulario_new" USING ("status"::text::"Status_Formulario_new");
ALTER TABLE "form12_Gerenciamento_Risco_Deposito" ALTER COLUMN "status" TYPE "Status_Formulario_new" USING ("status"::text::"Status_Formulario_new");
ALTER TABLE "form13_Locais_Evento" ALTER COLUMN "status" TYPE "Status_Formulario_new" USING ("status"::text::"Status_Formulario_new");
ALTER TABLE "form14_Resumo_Averiguacoes" ALTER COLUMN "status" TYPE "Status_Formulario_new" USING ("status"::text::"Status_Formulario_new");
ALTER TABLE "form15_Recuperacao_Carga" ALTER COLUMN "status" TYPE "Status_Formulario_new" USING ("status"::text::"Status_Formulario_new");
ALTER TABLE "form16_Anexos_Fotograficos" ALTER COLUMN "status" TYPE "Status_Formulario_new" USING ("status"::text::"Status_Formulario_new");
ALTER TABLE "form17_Conclusao" ALTER COLUMN "status" TYPE "Status_Formulario_new" USING ("status"::text::"Status_Formulario_new");
ALTER TYPE "Status_Formulario" RENAME TO "Status_Formulario_old";
ALTER TYPE "Status_Formulario_new" RENAME TO "Status_Formulario";
DROP TYPE "Status_Formulario_old";
ALTER TABLE "form7_Veiculo_Transportador" ALTER COLUMN "status" SET DEFAULT 'Pendente';
ALTER TABLE "form13_Locais_Evento" ALTER COLUMN "status" SET DEFAULT 'Pendente';
ALTER TABLE "form9_Gerenciamento_Risco_Veiculo" ALTER COLUMN "status" SET DEFAULT 'Pendente';
ALTER TABLE "form4_Do_Carregamento" ALTER COLUMN "status" SET DEFAULT 'Pendente';
ALTER TABLE "form16_Anexos_Fotograficos" ALTER COLUMN "status" SET DEFAULT 'Pendente';
ALTER TABLE "form2_Caracteristica_Sinistro" ALTER COLUMN "status" SET DEFAULT 'Pendente';
ALTER TABLE "form3_Cronologia_Sinistro" ALTER COLUMN "status" SET DEFAULT 'Pendente';
ALTER TABLE "form17_Conclusao" ALTER COLUMN "status" SET DEFAULT 'Pendente';
ALTER TABLE "form8_Orgao_Policial" ALTER COLUMN "status" SET DEFAULT 'Pendente';
ALTER TABLE "form6_Ajudantes" ALTER COLUMN "status" SET DEFAULT 'Pendente';
ALTER TABLE "form11_Declaracao_Motorista_Ajudante" ALTER COLUMN "status" SET DEFAULT 'Pendente';
ALTER TABLE "form12_Gerenciamento_Risco_Deposito" ALTER COLUMN "status" SET DEFAULT 'Pendente';
ALTER TABLE "form1_Cliente_Segurado" ALTER COLUMN "status" SET DEFAULT 'Pendente';
ALTER TABLE "form15_Recuperacao_Carga" ALTER COLUMN "status" SET DEFAULT 'Pendente';
ALTER TABLE "form5_Motorista" ALTER COLUMN "status" SET DEFAULT 'Pendente';
ALTER TABLE "form10_Sistemas_Protecao_Carregamento" ALTER COLUMN "status" SET DEFAULT 'Pendente';
ALTER TABLE "form14_Resumo_Averiguacoes" ALTER COLUMN "status" SET DEFAULT 'Pendente';
COMMIT;

-- AlterEnum
BEGIN;
CREATE TYPE "Status_Relatorio_new" AS ENUM ('Formalizando', 'Revisao', 'Aprovado', 'Emitido', 'Recuperado', 'Irreversivel');
ALTER TABLE "relatorios" ALTER COLUMN "status" DROP DEFAULT;
ALTER TABLE "relatorios" ALTER COLUMN "status" TYPE "Status_Relatorio_new" USING ("status"::text::"Status_Relatorio_new");
ALTER TYPE "Status_Relatorio" RENAME TO "Status_Relatorio_old";
ALTER TYPE "Status_Relatorio_new" RENAME TO "Status_Relatorio";
DROP TYPE "Status_Relatorio_old";
ALTER TABLE "relatorios" ALTER COLUMN "status" SET DEFAULT 'Formalizando';
COMMIT;
