FROM node:24-alpine

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# Copy the manifest and pnpm lockfile first so this layer is cached
COPY package.json pnpm-lock.yaml ./

RUN apk add --no-cache bash
RUN apk add --no-cache curl

# Enable pnpm via corepack (bundled with Node) and install from the frozen lockfile
RUN corepack enable
RUN pnpm install --frozen-lockfile --prod

# Bundle app source
COPY . .

CMD [ "node", "src/server.js" ]
