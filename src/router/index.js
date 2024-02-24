// router.js

import { createRouter, createWebHistory } from 'vue-router';
import Veiculos from '../view/Veiculos.vue'; 
import Home from '../view/Home.vue';
import Revisoes from "../view/Revisoes.vue";
import ClientesView from "../view/ClientesView.vue"
import AllVeiculos from "../view/AllVeiculos.vue"
import NextRevisoes from "../view/NextRevisoes.vue"

const routes = [
  { path: '/clienteview', component: ClientesView },
  { path: '/nextrevisoes', component: NextRevisoes },
  { path: '/allveiculos', component: AllVeiculos },
  { path: '/veiculo', component: Veiculos },
  { path: '/revisoes', component: Revisoes },
  {path:'/',component: Home} 
];

const router = createRouter({
  history: createWebHistory(),
  routes,
  scrollBehavior(to, from, savedPosition) {
    return { top: 0 }; // Rolagem para o topo
  },
});

export default router;
