<template>
  <v-dialog width="50rem" v-model="dialog">
    <template v-slot:activator="{ props }">
      <v-btn
        v-bind="props"
        class="mr-3"
        size="small"
        color="blue"
        icon="mdi-pencil"
        title="Editar"
      ></v-btn>
    </template>
    <v-card class="">
      <v-card-title>
        <span class="text-h5">Editar Revisão</span>
      </v-card-title>
      <v-card-text>
        <v-container>
          <v-row>
            <!-- Campos para as informações da revisão -->
            <v-col cols="12">
              <v-text-field
                v-model="dataRevisao"
                label="Data*"
                required
                type="date"
                clearable
                hide-details="auto"
              ></v-text-field>
            </v-col>
            <v-col cols="12">
              <v-text-field
                v-model="descricao"
                label="Descrição*"
                required
                clearable
                hide-details="auto"
              ></v-text-field>
            </v-col>
            <v-col cols="12">
              <v-text-field
                v-model="valor"
                label="Valor*"
                type="number"
                prefix="R$"
                required
                clearable
                hide-details="auto"
                :rules="[
                  (val) => {
                    const regex = /^\d+(\.\d{1,2})?$/;
                    if (!val) return 'Este campo é obrigatório';
                    if (!regex.test(val))
                      return 'O valor deve ser numérico e ter duas casas decimais';
                    return true;
                  },
                ]"
              ></v-text-field>
            </v-col>
          </v-row>
        </v-container>
        <small>* campos obrigatórios</small>
      </v-card-text>
      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn color="cyan-darken-3" variant="text" @click="dialog = false">
          Fechar
        </v-btn>
        <v-btn color="cyan-darken-1" variant="text" @click="salvarRevisao">
          Salvar
        </v-btn>
      </v-card-actions>
      <!-- Adiciona a notificação de sucesso -->
      <v-snackbar v-model="successMessage" color="success">
        Revisão atualizada com sucesso!
        <template v-slot:action="{ attrs }">
          <v-btn text v-bind="attrs" @click="fecharNotificacao"></v-btn>
        </template>
      </v-snackbar>
    </v-card>
  </v-dialog>
</template>
  
  <script>
import axios from "axios";

export default {
  props: {
    dialog: Boolean,
    idRevisao: Number, // Recebe o ID da revisão
  },
  data() {
    return {
      dataRevisao: "",
      descricao: "",
      valor: "",
      successMessage: false,
      dialog: false,
    };
  },
  mounted() {
    // Carregar os dados da revisão quando o componente for montado
    this.carregarDetalhesRevisao();
  },
  methods: {
    async carregarDetalhesRevisao() {
      try {
        const response = await axios.get(
          `http://localhost/api/revisoes/${this.idRevisao}`
        );
        const revisao = response.data;
        // Preencher os campos de texto com os dados atuais da revisão
        this.dataRevisao = revisao.data_revisao;
        this.descricao = revisao.descricao;
        this.valor = revisao.valor;
      } catch (error) {
        console.error("Erro ao carregar detalhes da revisão:", error);
      }
    },
    async salvarRevisao() {
      const data = {
        data_revisao: this.dataRevisao,
        descricao: this.descricao,
        valor: this.valor,
      };

      try {
        const response = await axios.put(
          `http://localhost/api/revisoes/${this.idRevisao}`,
          data
        );

        if (response.status === 200) {
          console.log("Revisão atualizada com sucesso:", response.data);

          this.successMessage = true;
          //espera 1,5seg
          setTimeout(() => {
            this.dialog = false;
            this.fecharNotificacao();
          }, 1500);
        } else {
          console.error("Erro ao atualizar revisão:", response.statusText);
        }
      } catch (error) {
        console.error("Erro ao enviar solicitação:", error);
      }
    },
    fecharNotificacao() {
      this.successMessage = false;
    },
  },
};
</script>
  