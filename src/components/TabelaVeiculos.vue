<template>
  <v-container rounded="lg">
    <v-card flat class="border rounded-lg sm-ma-4">
      <!--topo da tabela-->
      <div class="d-flex justify-space-between border">
        <!-- Título com o nome do proprietário -->
        <v-card-title class="text-center ma-2">
          {{ nomeProprietario }} - Veículos</v-card-title
        >
        <!--modal add-->
        <CadastrarVeiculo :proprietario_id="idProprietario" />
      </div>
      <div v-if="veiculos.length === 0" class="text-center">
        Nenhum veículo encontrado para este proprietário.
      </div>
      <!-- Tabela de veículos -->
      <v-table fixed-header height="300px" rounded="lg" id="table">
        <thead>
          <tr>
            <th class="text-left">Marca</th>
            <th class="text-left">Modelo</th>
            <th class="text-left">Ano</th>
            <th class="text-center">Ações</th>
            <!-- coluna para ações -->
          </tr>
        </thead>
        <tbody>
          <tr v-for="veiculo in veiculos" :key="veiculo.id">
            <td>{{ veiculo.marca }}</td>
            <td>{{ veiculo.modelo }}</td>
            <td>{{ veiculo.ano }}</td>
            <!--ações-->
            <td class="text-center">
              <!--  Botão visualizar -->
              <div class="d-flex align-center justify-center">
                <v-btn
                  class="mr-3"
                  size="small"
                  color="green-lighten-1"
                  @click="verRevisao(veiculo.id)"
                  icon="mdi-car-wrench"
                  title="Visualizar revisões do veículo"
                ></v-btn>
                <!-- Botão de editar veículo -->
                <EditarVeiculo :idVeiculo="veiculo.id" />
                <!-- Botão de excluir veículo -->
                <v-btn
                  size="small"
                  color="red"
                  @click="excluirVeiculo(veiculo)"
                  icon="mdi-delete"
                  title="Excluir"
                ></v-btn>
              </div>
            </td>
          </tr>
        </tbody>
      </v-table>
    </v-card>
  </v-container>
</template>
  
  <script>
import axios from "axios";

export default {
  props: ["router"],
  data() {
    return {
      veiculos: [],
      nomeProprietario: "",
      idProprietario: "",
      intervalId: null,
    };
  },
  created() {
    this.carregarVeiculos();
    this.intervalId = setInterval(this.carregarVeiculos, 3000);
  },

  methods: {
    async carregarVeiculos() {
      try {
        // Obter o ID do proprietário da query da rota
        const idProprietario = this.$route.query.id;
        if (idProprietario) {
          // Primeiro, carregue o nome do proprietário correspondente ao ID
          const response = await axios.get(
            `http://localhost/api/proprietarios/${idProprietario}`
          );
          this.nomeProprietario = response.data.nome;
          this.idProprietario = response.data.id;
          // Em seguida, carregue os veículos do proprietário
          const responseVeiculos = await axios.get(
            `http://localhost/api/veiculos/?proprietario_id=${idProprietario}`
          );
          this.veiculos = responseVeiculos.data;
        }
      } catch (error) {
        console.error("Erro ao carregar veículos:", error);
      }
    },
    editarVeiculo(idVeiculo) {
      console.log("Editar veículo com ID:", idVeiculo);
    },
    excluirVeiculo(veiculo) {
      const url = `http://localhost/api/veiculos/${veiculo.id}`;
      axios
        .delete(url)
        .then(() => {
          // Remover o veículo da lista após a exclusão
          const index = this.veiculos.indexOf(veiculo);
          if (index !== -1) {
            this.veiculos.splice(index, 1);
          }
        })
        .catch((error) => {
          console.error("Erro ao excluir veículo:", error);
        });
    },
    verRevisao(idVeiculo) {
      // Navegar para a rota /revisoes com o ID do veículo como parâmetro
      this.$router.push({ path: "/revisoes", query: { id: idVeiculo } });
    },
  },
};
</script>
  