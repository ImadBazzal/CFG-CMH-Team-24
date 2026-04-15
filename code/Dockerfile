FROM node:20-alpine AS deps
WORKDIR /app
COPY package*.json ./
RUN npm ci

# ── Build ─────────────────────────────────────────────────────────────────────
FROM node:20-alpine AS builder
WORKDIR /app

COPY --from=deps /app/node_modules ./node_modules
COPY . .

# NEXT_PUBLIC_BACKEND_URL is only used in server-side API routes, so the
# build-time value doesn't matter — the runtime env var takes precedence.
ENV NEXT_TELEMETRY_DISABLED=1
RUN npm run build

# ── Production image ──────────────────────────────────────────────────────────
FROM node:20-alpine AS runner
WORKDIR /app

ENV NODE_ENV=production
ENV NEXT_TELEMETRY_DISABLED=1

COPY --from=deps    /app/node_modules ./node_modules
COPY package*.json ./
COPY --from=builder /app/.next        ./.next
COPY --from=builder /app/public       ./public

EXPOSE 3000
CMD ["npm", "run", "start"]
