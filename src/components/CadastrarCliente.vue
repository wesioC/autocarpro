<template>
  <v-dialog width="50rem" v-model="dialog">
    <template v-slot:activator="{ props }">
      <v-btn
        v-bind="props"
        variant="tonal"
        class="ma-2 text-white"
        size="small"
        color="cyan-darken-2"
        icon="mdi-account-plus-outline"
      ></v-btn>
    </template>
    <v-card class="">
      <v-card-title>
        <span class="text-h5">Cadastro de Proprietário</span>
      </v-card-title>
      <v-card-text>
        <v-container>
          <v-row>
            <v-col cols="12">
              <v-text-field
                v-model="nome"
                label="Nome*"
                required
                :rules="[
                  (val) => {
                    if (!val) return 'Este campo é obrigatório';
                  },
                ]"
              ></v-text-field>
            </v-col>
            <v-col cols="12">
              <v-select
                v-model="sexo"
                :items="['Masculino', 'Feminino']"
                label="Sexo*"
                required
                :rules="[
                  (val) => {
                    if (!val) return 'Este campo é obrigatório';
                  },
                ]"
              ></v-select>
            </v-col>
            <v-col cols="12">
              <v-text-field
                v-model="cpf"
                label="CPF*"
                required
                v-mask="'###.###.###-##'"
                :rules="[
                  (val) => {
                    if (!val) return 'Este campo é obrigatório';
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
        <v-btn color="cyan-darken-1" variant="text" @click="salvarProprietario">
          Salvar
        </v-btn>
      </v-card-actions>
      <!-- Adiciona a notificação de sucesso -->
      <v-snackbar v-model="successMessage" color="success">
        Proprietário cadastrado com sucesso!
        <template v-slot:action="{ attrs }">
          <v-btn text v-bind="attrs" @click="fecharNotificacao"></v-btn>
        </template>
      </v-snackbar>
    </v-card>
  </v-dialog>
</template>
  
<script>
import axios from "axios";
import VueTheMask from "vue-the-mask";

export default {
  data() {
    return {
      nome: "",
      cpf: "",
      sexo: "",
      successMessage: false,
      dialog: false,
    };
  },
  methods: {
    async salvarProprietario() {
      const data = {
        nome: this.nome,
        cpf: this.cpf,
        sexo: this.sexo,
        dialog: false,
      };

      try {
        // Enviar solicitação POST para o backend usando Axios
        const response = await axios.post(
          "http://localhost/api/proprietarios",
          data
        );

        // Verificar se o cadastro foi bem-sucedido
        if (response.status === 201) {
          console.log("Proprietário cadastrado com sucesso:", response.data);
          this.nome = "";
          this.cpf = "";
          this.sexo = "";

          // Exibir a notificação de sucesso
          this.successMessage = true;
          //espera 1,5seg
          setTimeout(() => {
            this.dialog = false;
            this.fecharNotificacao();
          }, 1500);
        } else {
          console.error("Erro ao cadastrar proprietário:", response.statusText);
        }
      } catch (error) {
        console.error("Erro ao enviar solicitação:", error);
      }
    },
    fecharNotificacao() {
      // Fechar a notificação de sucesso
      this.successMessage = false;
    },
  },
  directives: {
    mask: VueTheMask.mask,
  },
};
</script>

