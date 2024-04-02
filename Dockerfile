# Taken and adjusted from https://github.com/vercel/next.js/blob/canary/examples/with-docker/Dockerfile

FROM node:20-bullseye-slim

WORKDIR /app

COPY package.json package-lock.json ./
COPY bin ./bin
COPY src ./src
COPY rollup.config.js tsconfig.json ./

RUN \
  if [ -f package-lock.json ]; then yes | npm ci; \
  else echo "Lockfile not found." && exit 1; \
  fi

ENV NEXT_TELEMETRY_DISABLED 1
ENV NODE_ENV production

CMD [ "npm", "run", "dev"]

