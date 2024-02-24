<template>
  <v-app theme="dark">
    <NavBar />
    <v-main>
      <router-view></router-view> 
      
    </v-main>
    <FooterW />
  </v-app>
</template>

<script>
import NavBar from "./components/NavBar.vue";

export default {
  components: {
    NavBar,
  },
};
</script>
