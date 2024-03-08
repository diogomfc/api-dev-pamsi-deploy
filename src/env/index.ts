import "dotenv/config";
import { logger } from "@/utils/Logger";
import { z } from "zod";

const envSchema = z.object({
    PORT: z.coerce.number().default(3333),
    NODE_ENV: z.enum(["dev", "test", "production"]).default("dev"),
    JWT_SECRET: z.string(),
    JWT_EXPIRES_IN: z.string(),
    //CORS_ORIGIN: z.string().url(),
    //CORS_METHODS: z.string(),
    AWS_ACCESS_KEY_ID: z.string(),
    AWS_SECRET_ACCESS: z.string(),
    AWS_DEFAULT_REGION: z.string(),
    S3_BASE_URL: z.string().url(),
    S3_BUCKET_NAME: z.string(),
    //Vercel
    // POSTGRES_URL: z.string().url(),
    // POSTGRES_PRISMA_URL: z.string().url(),
    // POSTGRES_URL_NON_POOLING: z.string().url(),
    // POSTGRES_USER: z.string(),
    // POSTGRES_HOST: z.string().url(),
    // POSTGRES_PASSWORD: z.string(),
    // POSTGRES_DATABASE: z.string(),
});

export const _env = envSchema.safeParse(process.env);

if (!_env.success) {
    logger.error(" ❌ Variáveis de ambiente inválidas", _env.error.format());

    throw new Error("Variáveis de ambiente inválidas");
}

export const env = _env.data;