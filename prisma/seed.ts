import { PrismaClient } from '@prisma/client';
import { hash } from 'bcryptjs';

const prisma = new PrismaClient();

async function users() {
    const senhaCriptografada = await hash('12345678', 8);

    const usuarioEmpresa = await prisma.usuario.create({
        data: {
            nome: 'Pamcary Homologação',
            email: 'pamcary@pamcary.com',
            telefone: '1234567890',
            senha_hash: senhaCriptografada,
            funcao: 'Admin',
            avatar: '866cca358494412ef7f8-avatar-pamcary1.png',
        },

    });

    const usersAdminHomologacao = await prisma.usuario.create({
        data: {
            nome: 'Admin Homologação',
            email: 'admin@homologacao.com',
            telefone: '11-99999-9999',
            senha_hash: senhaCriptografada,
            funcao: 'Admin',
            avatar: 'ac9377b57d9071e91592-avatar-admin.png',
        },
    });

    const usersAnalistaHomologacao = await prisma.usuario.create({
        data: {
            nome: 'Analista Homologação',
            email: 'analista@homologacao.com',
            telefone: '11-99999-9999',
            senha_hash: senhaCriptografada,
            funcao: 'Analista',
            avatar: '34ae9267de2cdc9721d2-avatar-analista.png',
        },
    });

    const usersRevisorHomologacao = await prisma.usuario.create({
        data: {
            nome: 'Revisor Homologação',
            email: 'revisor@homologacao.com',
            telefone: '11-99999-9999',
            senha_hash: senhaCriptografada,
            funcao: 'Revisor',
            avatar: 'd85f3d7d81da8a532b42-avatar-revisor.png',
        },
    });

    const usersSupervisorHomologacao = await prisma.usuario.create({
        data: {
            nome: 'Supervisor Homologação',
            email: 'supervisor@homologacao.com',
            telefone: '11-99999-9999',
            senha_hash: senhaCriptografada,
            funcao: 'Supervisor',
            avatar: '9c4f672d4e1985620114-avatar-supervisor.png',
        },
    });

    console.log('Usuário fixo criado:',
        usuarioEmpresa,
        usersAdminHomologacao,
        usersAnalistaHomologacao,
        usersRevisorHomologacao,
        usersSupervisorHomologacao
    );
}

async function seed() {
    await users();
}

seed()
    .catch((e) => {
        console.error(e);
        process.exit(1);
    })
    .finally(async () => {
        await prisma.$disconnect();
    });