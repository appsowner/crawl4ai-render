# Dockerfile para crawl4ai con Playwright para Easypanel
FROM unclecode/crawl4ai:all-amd64

# No cambiamos al usuario root, ya que eso podría alterar la configuración de la imagen base
# USER root

# Configurar las variables de entorno de Playwright 
# (estas ya deberían estar configuradas en la imagen base, pero las incluimos por si acaso)
ENV PLAYWRIGHT_CHROMIUM_HEADLESS_MODE="new" \
    PLAYWRIGHT_BROWSERS_PATH="/usr/bin" \
    PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD=1 \
    PLAYWRIGHT_CHROMIUM_EXTRA_LAUNCH_ARGS="--no-sandbox --disable-gpu" \
    CRAWL4AI_API_TOKEN=${CRAWL4AI_API_TOKEN}

# Exponer el puerto 11235
EXPOSE 11235

# Comando para iniciar crawl4ai (mantenemos el comando original de la imagen)
CMD ["npm", "start"]
