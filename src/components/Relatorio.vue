<template>
  <v-col cols="12" sm="6" md="4" lg="3">
    <v-card class="mx-auto xs-w-50" max-width="340">
      <v-card-item>
        <div>
          <div class="text-h6 mb-1">Quem tem mais carros?</div>
          <div class="text-caption">Quantidade de carros por sexo</div>
          <canvas id="myChart"></canvas>
        </div>
      </v-card-item>
    </v-card>
  </v-col>
</template>
  
  <script>
import Chart from "chart.js/auto";
import axios from "axios";

export default {
  mounted() {
    this.carregarRelatorio();
  },
  data() {
    return {
      relatorio1: [],
    };
  },
  methods: {
    async carregarRelatorio() {
      try {
        const response = await axios.get("http://localhost/api/relatorio1");
        this.relatorio1 = response.data;
        this.renderizarGrafico();
      } catch (error) {
        console.error("Erro ao carregar relatório:", error);
      }
    },
    renderizarGrafico() {
      const labels = this.relatorio1.map((item) => item.sexo);
      const data = this.relatorio1.map((item) => item.quantidade_carros);

      const ctx = document.getElementById("myChart");
      new Chart(ctx, {
        type: "doughnut",
        data: {
          labels: ["Mulheres", "Homens"],
          datasets: [
            {
              label: "Quantidade",
              data: data,
              backgroundColor: [
                "rgba(255, 99, 132, 0.2)",
                "rgba(54, 162, 235, 0.2)",
              ],
              borderColor: [
                "rgba(255, 99, 132, 1)", 
                "rgba(54, 162, 235, 1)"
              ],
              borderWidth: 1,
            },
          ],
        },
        options: {
          scales: {
            y: {
              beginAtZero: true,
            },
          },
        },
      });
    },
  },
};
</script>
  
  <style>
</style>
  