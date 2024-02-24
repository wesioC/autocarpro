<template>
  <v-app theme="dark">
    <v-main>
      <v-row class="justify-space-evenly mt-3">
        <v-col cols="12" md="4" lg="6">
          <h2 class="text-center">
            Dashboard da <span style="color: cyan">Auto Car Pro</span>
          </h2>
        </v-col>
      </v-row>
      <v-container color="red-dark-4">
        <v-row class="justify-space-evenly d-flex align-stretch red-dark-4">
          <Relatorio />
          <Relatorio2 />
          <Relatorio3 />
        </v-row>
      </v-container>
      <Clientes />
      <Card />
    </v-main>
  </v-app>
</template>
  
  <script>
//
</script>
  