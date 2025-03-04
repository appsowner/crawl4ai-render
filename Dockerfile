# Dockerfile para crawl4ai con Playwright para Render.com
FROM ghcr.io/crawl4ai/crawl4ai:latest

USER root

# Instalar dependencias necesarias para Playwright
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    ca-certificates \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list

# Instalar Playwright y sus dependencias
RUN npm install -g playwright && \
    npx playwright install --with-deps chromium && \
    npx playwright install-deps chromium

# Configurar las variables de entorno de Playwright
ENV PLAYWRIGHT_CHROMIUM_HEADLESS_MODE="new" \
    PLAYWRIGHT_BROWSERS_PATH="/usr/bin" \
    PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD=1 \
    PLAYWRIGHT_CHROMIUM_EXTRA_LAUNCH_ARGS="--no-sandbox --disable-gpu"

# Referencia explícita a la variable de entorno CRAWL4AI_API_TOKEN
# Esta línea indica que el contenedor espera recibir esta variable de entorno
ENV CRAWL4AI_API_TOKEN=${CRAWL4AI_API_TOKEN}

# Volver al usuario no privilegiado
USER node

# Exponer el puerto 11235
EXPOSE 11235

# Comando para iniciar crawl4ai
CMD ["npm", "start"]
