import { PrismaClient } from '@prisma/client';
import { hash } from 'bcryptjs';

const prisma = new PrismaClient();

async function users() {
    const senhaCriptografada = await hash('12345678', 8);

    const usuarioFixo = await prisma.usuario.create({
        data: {
            nome: 'Pamcary Homologação',
            email: 'pamcary@pamcary.com',
            telefone: '1234567890',
            senha_hash: senhaCriptografada,
            funcao: 'Admin',
            avatar: null,
        },
    });

    console.log('Usuário fixo criado:', usuarioFixo);
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