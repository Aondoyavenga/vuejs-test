<template>
  <div>
    <select v-model="selectedOption">
      <option v-for="option in options" :value="option" :key="option">{{ option }}</option>
    </select>
    <ChartPrompt :value="selectedOption" :json_obj="apiResponse[selectedOption]" />
  </div>
</template>

<script>
import ChartPrompt from './ChartPrompt.vue';


export default {
  name: 'DropDown',
  components: {
    ChartPrompt
  },
  data() {
    return {
      selectedOption: '',
      options: [],
      apiResponse: {}
    };
  },
  created() {
    let data = {"Table1":{"cost":0.5616,"account":"123","region":"us-east-1","read_capacity_units":1,"write_capacity_units":1,"write_utilization_ratio_datapoints":[100.0,400.0,0.0,0.0,100.0,100.0,100.0,0.0,0.0,0.0,100.0,100.0,0.0,100.0,0.0,0.0,100.0,0.0,400.0,100.0,0.0,0.0,0.0,100.0,0.0,0.0,100.0,100.0,100.0,0.0],"read_utilization_ratio_datapoints":[100.0,100.0,100.0,100.0,100.0,100.0,100.0,100.0,100.0,100.0,100.0,100.0,100.0,100.0,100.0,100.0,100.0,100.0,100.0,100.0,100.0,100.0,100.0,100.0,100.0,100.0,100.0,100.0,100.0,100.0]},"Table2":{"cost":0.5616,"account":"123","region":"us-east-1","read_capacity_units":1,"write_capacity_units":1,"write_utilization_ratio_datapoints":[0.0,400.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,100.0,0.0,0.0,0.0,0.0,0.0,0.0,100.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0],"read_utilization_ratio_datapoints":[50.0,50.0,0.0,0.0,50.0,50.0,50.0,0.0,0.0,0.0,50.0,50.0,0.0,50.0,50.0,0.0,50.0,0.0,50.0,50.0,0.0,0.0,0.0,50.0,0.0,0.0,50.0,50.0,50.0,0.0]}}
    this.apiResponse = data
    this.selectedOption = Object.keys(data)[0]
    this.options = Object.keys(data)
  }
};
</script>