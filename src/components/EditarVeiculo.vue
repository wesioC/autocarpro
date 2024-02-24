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
        <span class="text-h5">Cadastro de Veículo</span>
      </v-card-title>
      <v-card-text>
        <v-container>
          <v-row>
            <!-- Campos para as informações do veículo -->
            <v-col cols="12" @click="selectMarca(marca)">
              <v-select
                v-model="marca"
                label="Marca"
                :items="marcas.map((marca) => marca.nome)"
                :item-value="selectMarca()"
                :rules="[
                  (val) => {
                    if (!val) return 'Este campo é obrigatório';
                  },
                ]"
              ></v-select>
            </v-col>

            <v-col cols="12">
              <v-select
                v-model="modelo"
                label="Modelo*"
                :items="modelos.map((modelo) => modelo.nome)"
                :disabled="!marca"
                :rules="[
                  (val) => {
                    if (!val) return 'Este campo é obrigatório';
                  },
                ]"
              ></v-select>
            </v-col>

            <v-col cols="12">
              <v-text-field
                type="number"
                v-model="ano"
                label="Ano*"
                required
                v-mask="'####'"
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
        <!-- <v-btn color="blue-darken-1" variant="text" @click="fecharDialog">
          Fechar
        </v-btn> -->
        <v-btn color="cyan-darken-1" variant="text" @click="dialog = false">
          Fechar
        </v-btn>
        <v-btn color="cyan-darken-1" variant="text" @click="salvarVeiculo">
          Salvar
        </v-btn>
      </v-card-actions>
      <!-- Adiciona a notificação de sucesso -->
      <v-snackbar v-model="successMessage" color="success">
        Veículo cadastrado com sucesso!
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
    idVeiculo: Number, // Recebe o ID do veículo
  },
  data() {
    return {
      marca: "",
      modelo: "",
      ano: "",
      marcaSeleted: {},
      marcas: [],
      modelos: [],
      successMessage: false,
      dialog: false,
    };
  },
  mounted() {
    // Carregar os dados do veículo quando o componente for montado
    this.carregarDetalhesVeiculo();
  },
  methods: {
    selectMarca() {
      this.marcaSelected =
        this.marcas.find((marca) => marca.nome === this.marca) || {};
      console.log(this.marcaSelected.codigo);
      this.getModelos();
    },
    async getMarcas() {
      try {
        const response = await axios.get(
          "https://parallelum.com.br/fipe/api/v1/carros/marcas"
        );
        this.marcas = response.data;
      } catch (error) {
        console.error("Erro ao buscar marcas:", error);
      }
    },
    async getModelos() {
      if (!this.marcaSelected.codigo) {
        return false;
      }
      try {
        const response = await axios.get(
          `https://parallelum.com.br/fipe/api/v1/carros/marcas/${this.marcaSelected.codigo}/modelos`
        );
        console.log(response.data);
        this.modelos = response.data.modelos;
      } catch (error) {
        console.error("Erro ao buscar modelos:", error);
      }
    },
    async carregarDetalhesVeiculo() {
      try {
        const response = await axios.get(
          `http://localhost/api/veiculos/${this.idVeiculo}`
        );
        const veiculo = response.data;
        // Preencher os campos de texto com os dados atuais do veículo
        this.marca = veiculo.marca;
        this.modelo = veiculo.modelo;
        this.ano = veiculo.ano;
      } catch (error) {
        console.error("Erro ao carregar detalhes do veículo:", error);
      }
    },
    async salvarVeiculo() {
      const data = {
        marca: this.marca,
        modelo: this.modelo,
        ano: this.ano,
      };

      try {
        const response = await axios.put(
          `http://localhost/api/veiculos/${this.idVeiculo}`,
          data
        );

        if (response.status === 200) {
          console.log("Veículo atualizado com sucesso:", response.data);
          this.successMessage = true;
          //espera 1,5seg
          setTimeout(() => {
            this.dialog = false;
            this.fecharNotificacao();
          }, 1500);
        } else {
          console.error("Erro ao atualizar veículo:", response.statusText);
        }
      } catch (error) {
        console.error("Erro ao enviar solicitação:", error);
      }
    },
  },
  directives: {
    mask: VueTheMask.mask,
  },
  created() {
    this.getMarcas();
  },
};
</script>
  