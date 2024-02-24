<template>
  <v-container rounded="lg">
    <v-card flat class="border rounded-lg sm-ma-4">
      <!--topo da tabela-->
      <div class="d-flex justify-space-between border">
        <!-- Título com o nome do veículo -->
        <v-card-title class="text-center ma-2"
          >Próximas Revisões</v-card-title
        >
        <!-- Botão adicionar revisão -->
          <CadastrarRevisao
            :veiculo_id="idVeiculo"
            @revisao-adicionada="carregarRevisoes"
          />
      </div>
      <div v-if="revisoes.length === 0" class="text-center">
        Nenhuma próxima revisão encontrada.
      </div>

      <!-- Tabela de revisões -->
      <v-table fixed-header height="300px" rounded="lg">
        <thead>
          <tr>
            <th class="text-left">Data</th>
            <th class="text-left">Proprietário</th>
            <th class="text-left">Marca</th>
            <th class="text-left">Modelo</th>
            <th class="text-left">Descrição</th>
            <th class="text-left">Valor</th>
            <th class="text-center">Ações</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="revisao in revisoes" :key="revisao.id">
            <td> {{ formatarData(revisao.data_revisao) }}</td>
            <td>{{ revisao.nome_proprietario }}</td>
            <td>{{ revisao.marca }}</td>
            <td>{{ revisao.modelo }}</td>
            <td>{{ revisao.descricao }}</td>
            <td>{{ formatarValor(revisao.valor) }}</td>
            <td class="text-center">
              <div class="d-flex align-center justify-center">
                <!-- Botão editar revisão -->
                  <EditarRevisao :idRevisao="revisao.id" />
                <!-- Botão excluir revisão -->
                <v-btn
                  size="small"
                  color="red"
                  @click="excluirRevisao(revisao.id)"
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
      revisoes: [],
      nomeVeiculo: "",
      idVeiculo: null,
      intervalId: null,
    };
  },
  created() {
    this.carregarRevisoes();
    this.intervalId = setInterval(this.carregarRevisoes, 3000);
  },

  methods: {
    formatarData(data) {
      // Função para formatar a data para dd/mm/aaaa
      const dataObj = new Date(data);
      const dia = String(dataObj.getDate() + 1).padStart(2, "0");
      const mes = String(dataObj.getMonth() + 1).padStart(2, "0");
      const ano = dataObj.getFullYear();
      return `${dia}/${mes}/${ano}`;
    },
    formatarValor(valor) {
      const strValor = String(valor);
      if (strValor.includes(".")) {
        const partes = strValor.split(".");
        const parteInteira = partes[0].replace(/\B(?=(\d{3})+(?!\d))/g, ".");
        return `${parteInteira},${partes[1]}`;
      } else {
        return strValor;
      }
    },

    async carregarRevisoes() {
      try {
        const responseVeiculos = await axios.get(
          `http://localhost/api/revisoes/?proximas`
        );
        this.revisoes = responseVeiculos.data;
      } catch (error) {
        console.error("Erro ao carregar as próximas revisões:", error);
      }
    },
    editarRevisao(idRevisao) {
      console.log("Editar revisão com ID:", idRevisao);
    },
    excluirRevisao(idRevisao) {
      const url = `http://localhost/api/revisoes/${idRevisao}`;
      axios
        .delete(url)
        .then(() => {
          // Recarregar as revisões após a exclusão
          this.carregarRevisoes();
        })
        .catch((error) => {
          console.error("Erro ao excluir revisão:", error);
        });
    },
  },
};
</script>
  