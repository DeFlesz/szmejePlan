<script setup>
import { ref } from "vue";

const classes = ref({});
const classesData = ref({});
const choosenClass = ref(null);

function getClasses() {
  fetch("http://localhost:8000/classes")
    .then((res) => {
      return res.json();
    })
    .then((data) => {
      //   console.log(data);
      classes.value = data;
      choosenClass.value = Object.keys(data)[0];
      //   console.log(choosenClass.value);
      //   console.log(classes.value);
      readData();
    });
}

getClasses();

function readData() {
  fetch(`http://localhost:8000/classes/${choosenClass.value}`)
    .then((res) => {
      return res.json();
    })
    .then((data) => {
      classesData.value = data;
      //   console.log(data);
    });
}
// readData();
</script>

<template>
  <div class="m-2">
    <div id="container">
      <table v-if="classesData.length > 0" class="table table-sm">
        <thead>
          <tr v-for="row in classesData.slice(0, 1)">
            <th scope="col" v-for="th in row">{{ th }}</th>
          </tr>
        </thead>
        <tbody class="table-group-divider">
          <tr v-for="row in classesData.slice(1, classesData.length)">
            <template v-for="(td, index) in row">
              <th scope="row" v-if="index == 0">{{ td }}</th>
              <td v-else-if="td != null && typeof td == 'object'">
                <div class="d-flex flex-column" v-for="data in td">
                  <div class="d-flex gap-2 justify-content-start">
                    {{ data.subject }} <a href="#">{{ data.room.name }} </a>
                    <a href="#">{{ data.teacher.name }}</a>
                  </div>
                </div>
              </td>
              <td v-else>{{ td }}</td>
            </template>
          </tr>
        </tbody>
      </table>
      <div class="row row-cols-lg-auto g-3 mb-3">
        <div class="col">
          <select
            v-model="choosenClass"
            class="form-select"
            name="classes"
            id="classes"
          >
            <option v-for="key in Object.keys(classes)" :value="key">
              {{ key }}
            </option>
          </select>
        </div>
        <div class="col">
          <button @click="readData()" class="btn btn-primary">Get</button>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
#container {
  width: 80vw;
  margin: auto;
}

table {
  /* background-image: url("https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fmedia.fastestlaps.com%2Fhonda-civic-si-n-a.png&f=1&nofb=1&ipt=42a59ec3f853afd05c55662d5532bbe061ed39698a3360b08e491146b00905ab&ipo=images"); */
  /* background-image: url("https://im.indiatimes.in/media/content/2013/Jan/fire_1359094836_1359094840_1359094845_540x540.jpg"); */
  background-position: center;
  background-repeat: no-repeat;
  background-size: cover;

  /* background: inherit; */
  /* background-clip: text;
  color: transparent;
  filter: invert(1); */
  /* color: white; */
  /* text-shadow: 2px 2px 4px black; */
}

th,
td {
  /* color: white; */
  /* text-shadow: 2px 2px 4px black; */
  /* text-shadow: -1px -1px 0 #000, 1px -1px 0 #000, -1px 1px 0 #000,
    1px 1px 0 #000; */
  outline: black 1px;
}
</style>
