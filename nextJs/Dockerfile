FROM node:20-alpine

WORKDIR /app

# Copy standalone server
COPY .next/standalone ./
COPY .next/static ./.next/static
COPY public ./public

EXPOSE 3000
CMD ["node", "server.js"]
