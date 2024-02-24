<template >
  <v-col cols="12" sm="6" md="4" lg="3">
    <v-card class="mx-auto" max-width="340">
      <v-card-item>
        <div>
          <div class="text-h6 mb-1">Marcas com + revisões</div>
          <div class="text-caption">Quantidade de revisões por marca</div>
          <canvas height="300px" id="myChart2"></canvas>
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
        const response = await axios.get("http://localhost/api/relatorio2");
        this.relatorio1 = response.data;
        this.renderizarGrafico();
      } catch (error) {
        console.error("Erro ao carregar relatório:", error);
      }
    },
    renderizarGrafico() {
      const labels = this.relatorio1.map((item) => item.marca);
      const data = this.relatorio1.map((item) => item.total_revisoes);

      const ctx = document.getElementById("myChart2");
      new Chart(ctx, {
        type: "bar",
        data: {
          labels: labels,
          datasets: [
            {
              label: "Quantidade de revisoes por carro",
              data: data,
              backgroundColor: [
                "rgba(54, 162, 235, 0.2)",
                "rgba(255, 99, 132, 0.2)",
                "rgba(255, 206, 86, 0.2)",
                "rgba(75, 192, 192, 0.2)", 
                "rgba(153, 102, 255, 0.2)", 
              ],
              borderColor: [
                "rgba(54, 162, 235, 1)",
                "rgba(255, 99, 132, 1)",
                "rgba(255, 206, 86, 1)",
                "rgba(75, 192, 192, 1)", 
                "rgba(153, 102, 255, 1)", 
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
  