<template>
  <v-container rounded="lg">
    <v-card flat class="border rounded-lg sm-ma-4">
      <!--topo da tabela-->
      <div class="d-flex justify-space-between border">
        <v-card-title class="text-center ma-2">Clientes </v-card-title>
        <!--modal add-->

        <CadastrarCliente />
      </div>
      <!-- Tabela de clientes -->
      <v-table fixed-header height="300px" rounded="lg">
        <thead>
          <tr>
            <th class="text-left">Nome</th>
            <th class="text-left">CPF</th>
            <th class="text-left">Sexo</th>
            <th class="text-center">Ações</th>
            <!-- coluna para ações -->
          </tr>
        </thead>
        <tbody>
          <tr
            v-for="proprietario in proprietarios"
            :key="proprietario.id"
            id="table"
          >
            <td>{{ proprietario.nome }}</td>
            <td>{{ proprietario.cpf }}</td>
            <td>{{ proprietario.sexo }}</td>
            <!--ações-->
            <td class="text-center">
              <div class="d-flex align-center justify-center">
                <v-btn
                  class="mr-3"
                  size="small"
                  color="cyan-lighten-3"
                  @click="verVeiculos(proprietario.id)"
                  icon="mdi-car-multiple"
                  title="Visualizar veículos do proprietário"
                ></v-btn>

                <EditarCliente :idProprietario="proprietario.id" />

                <v-btn
                  size="small"
                  color="red"
                  @click="excluirProprietario(proprietario)"
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
  
<script >
import axios from "axios";

export default {
  props: ["router"],
  data() {
    return {
      proprietarios: [],
      intervalId: null,
    };
  },
  created() {
    this.carregarProprietarios();
    this.intervalId = setInterval(this.carregarProprietarios, 3000);
  },
  methods: {
    async carregarProprietarios() {
      try {
        const response = await axios.get("http://localhost/api/proprietarios");
        this.proprietarios.splice(0, this.proprietarios.length, ...response.data);
        this.proprietarios = response.data;
      } catch (error) {
        console.error("Erro ao carregar proprietários:", error);
      }
    },
    editarProprietario(idProprietario) {
      console.log("Editar proprietário com ID:", idProprietario);
    },
    excluirProprietario(proprietario) {
      const url = `http://localhost/api/proprietarios/${proprietario.id}`;
      axios
        .delete(url)
        .then(() => {
          // Remover o proprietário da lista após a exclusão
          const index = this.proprietarios.indexOf(proprietario);
          if (index !== -1) {
            this.proprietarios.splice(index, 1);
          }
        })
        .catch((error) => {
          console.error("Erro ao excluir proprietário:", error);
        });
    },
    verVeiculos(idProprietario) {
      this.$router.push({ path: "/veiculo", query: { id: idProprietario }, });
      
    },
    recarregarTabela() {
      axios
        .get("http://localhost/api/proprietarios")
        .then((response) => {
          // Manipular os dados da resposta
          console.log("Dados dos proprietários:", response.data);
          // Se você deseja atualizar this.proprietarios com os dados recebidos
          this.proprietarios = response.data;
        })
        .catch((error) => {
          console.error("Erro ao carregar proprietários:", error);
        });
    },
  },
};
</script>