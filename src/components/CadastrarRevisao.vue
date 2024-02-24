<template>
  <v-dialog width="50rem" v-model="dialog">
    <template v-slot:activator="{ props }">
      <v-btn
        v-bind="props"
        variant="tonal"
        class="ma-2"
        size="small"
        color="cyan darken-1"
        icon="mdi-plus"
      ></v-btn>
    </template>
    <v-card class="">
      <v-card-title>
        <span class="text-h5">Cadastro de Revisão</span>
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
                :rules="[
                  (val) => {
                    if (!val) return 'Este campo é obrigatório';
                  },
                ]"
              ></v-text-field>
            </v-col>
            <v-col cols="12">
              <v-text-field
                v-model="descricao"
                label="Descrição*"
                required
                maxlength="150"
                type="text"
                :rules="[
                  (val) => {
                    if (!val) return 'Este campo é obrigatório';
                  },
                ]"
              ></v-text-field>
            </v-col>
            <v-col cols="12">
              <v-text-field
                v-model.number="valor"
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
        <v-btn color="cyan-darken-1" variant="text" @click="dialog = false">
          Fechar
        </v-btn>
        <v-btn color="cyan-darken-1" variant="text" @click="salvarRevisao">
          Salvar
        </v-btn>
      </v-card-actions>
      <!-- Adiciona a notificação de sucesso -->
      <v-snackbar v-model="successMessage" color="success">
        Revisão cadastrada com sucesso!
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
    veiculo_id: Number,
  },
  data() {
    return {
      dataRevisao: "", // Inicializa com uma string vazia
      descricao: "",
      valor: null, // Inicializa com null para ser tratado como número
      successMessage: false,
      dialog: false,
    };
  },
  computed: {
    formValido() {
      // Verifica se todos os campos obrigatórios foram preenchidos e se o valor está no formato correto
      return (
        this.dataRevisao &&
        this.descricao &&
        this.valor !== null &&
        this.valorValido
      );
    },
    valorValido() {
      // Verifica se o valor possui duas casas decimais
      const regex = /^\d+(\.\d{1,2})?$/;
      return regex.test(this.valor);
    },
  },
  methods: {
    async salvarRevisao() {
      if (!this.formValido) {
        console.error(
          "O formulário não é válido. Preencha todos os campos obrigatórios e verifique o formato do valor."
        );
        return;
      }

      console.log("ID do veículo:", this.veiculo_id);
      const data = {
        data_revisao: this.dataRevisao,
        descricao: this.descricao,
        valor: this.valor,
        veiculo_id: this.veiculo_id,
      };

      try {
        const response = await axios.post(
          "http://localhost/api/revisoes",
          data
        );

        if (response.status === 201) {
          console.log("Revisão cadastrada com sucesso:", response.data);
          this.dataRevisao = ""; // Limpa o campo de data
          this.descricao = ""; // Limpa o campo de descrição
          this.valor = null; // Limpa o campo de valor

          this.successMessage = true;
          //espera 1,5seg
          setTimeout(() => {
            this.dialog = false;
            this.fecharNotificacao();
          }, 1500);
        } else {
          console.error("Erro ao cadastrar revisão:", response.statusText);
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
