// main.js

import { createApp } from 'vue';
import App from './App.vue';
import { registerPlugins } from '@/plugins'; // Importe a função registerPlugins
import router from './router'; // Importe o arquivo de configuração do router
import VueTheMask from 'vue-the-mask';

const app = createApp(App);

registerPlugins(app);

app.use(router); // Use o Vue Router

app.mount('#app');
app.use(VueTheMask);