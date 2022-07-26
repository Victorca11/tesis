## Para la ejecución es requerida:
- Truffle v5.5.3:  https://github.com/trufflesuite/truffle
- Ganache ui: https://github.com/trufflesuite/ganache-ui
- Node v16.0.0
- React-js
- Metamask Extensión para google chrome

1. Instalar Ganache y crear un workspace que simule la red de blockchain.
2. Instalar Truffle `npm install -g truffle`
3. Configurar el puerto de la red simulada blockchain configurada en el workspace, desde el archivo `truffle-config.js`.
4. Descargar la extensión de metamask en google.

## Para instalar las dependencias, ejecutar:
Windows: `npm install` o `npm install --force`
Linux: `npm install` o `sudo npm install`

## Para inicializar el servidor, ejecutar
Windows: `npm start`
Linux: `npm start` o `sudo npm start`

## Para el despliegue de los smart contracts, ejecutar:
`truffle migrate --reset`