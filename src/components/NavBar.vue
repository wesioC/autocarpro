<template>
  <v-navigation-drawer v-model="isDrawerOpen">
    <v-list>
      <v-list-subheader>Menu</v-list-subheader>
      <v-list-item href="/" prepend-icon="mdi-home">Home</v-list-item>
      <v-list-item href="/clienteview" prepend-icon="mdi-account-details">Clientes</v-list-item>
      <v-list-item href="/allveiculos" prepend-icon="mdi-car-multiple">Todos os Veículos</v-list-item>
      <v-list-item href="/nextrevisoes" prepend-icon="mdi-car-wrench">Próximas revisões</v-list-item>
    </v-list>
  </v-navigation-drawer>

  <v-app-bar flat class="border-b">
    <v-app-bar-nav-icon
      @click="isDrawerOpen = !isDrawerOpen"
    ></v-app-bar-nav-icon>
    <v-app-bar-title>Auto Car Pro</v-app-bar-title>

    <template #append>
      <!-- Notificacao -->
      <v-btn icon class="mr-3">
        <v-badge dot color="cyan-accent-2">
          <v-icon icon="mdi-bell-outline"></v-icon> </v-badge
      ></v-btn>

      <!--Avatar-->
      <v-avatar class="pa-4" color="cyan-darken-2">
        <span class="text-h7 text-white">WC</span>
      </v-avatar>
    </template>
  </v-app-bar>
</template>

<script setup>
import { ref } from "vue";

const isDrawerOpen = ref(false);
</script>

<style>
</style>