<template>
  <v-dialog width="50rem" v-model="dialog">
    <template v-slot:activator="{ props }">
      <v-btn
        v-bind="props"
        class="mr-3"
        size="small"
        color="blue"
        @click="editarProprietario(proprietario.id)"
        icon="mdi-pencil"
        title="Editar"
      ></v-btn>
    </template>
    <v-card class="">
      <v-card-title>
        <span class="text-h5">Editar Proprietário</span>
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
                clearable
                hide-details="auto"
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
                clearable
                hide-details="auto"
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
      <v-snackbar v-model="successMessage" color="success">
        Proprietário atualizado com sucesso!
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
  props: {
    dialog: Boolean,
    idProprietario: Number, // Recebe o ID do proprietário
  },
  data() {
    return {
      nome: "",
      cpf: "",
      sexo: "",
      successMessage: false,
      dialog: false,
    };
  },
  mounted() {
    // Carregar os dados do proprietário quando o componente for montado
    this.carregarDetalhesProprietario();
  },
  methods: {
    async carregarDetalhesProprietario() {
      try {
        const response = await axios.get(
          `http://localhost/api/proprietarios/${this.idProprietario}`
        );
        const proprietario = response.data;
        // Preencher os campos de texto com os dados atuais do proprietário
        this.nome = proprietario.nome;
        this.cpf = proprietario.cpf;
        this.sexo = proprietario.sexo;
      } catch (error) {
        console.error("Erro ao carregar detalhes do proprietário:", error);
      }
    },
    async salvarProprietario() {
      const data = {
        nome: this.nome,
        cpf: this.cpf,
        sexo: this.sexo,
      };

      try {
        const response = await axios.put(
          `http://localhost/api/proprietarios/${this.idProprietario}`,
          data
        );

        if (response.status === 200) {
          console.log("Proprietário atualizado com sucesso:", response.data);
          

          this.successMessage = true;
          //espera 1,5seg
          setTimeout(() => {
            this.dialog = false;
            this.fecharNotificacao();
          }, 1500);
        } else {
          console.error("Erro ao atualizar proprietário:", response.statusText);
        }
      } catch (error) {
        console.error("Erro ao enviar solicitação:", error);
      }
    },
    fecharNotificacao() {
      this.successMessage = false;
    },
  },
  directives: {
    mask: VueTheMask.mask,
  },
};
</script>
