<template>
<Line :data="linedata" :options="lineoption" />
</template>

<script lang="ts">
import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  Title,
  Tooltip,
  Legend,
  ChartOptions
} from 'chart.js'
import { Line } from 'vue-chartjs'
//import * as chartConfig from './chartConfig.js'

ChartJS.register(
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  Title,
  Tooltip,
  Legend
)

interface DynamoDBMetricsData {
  cost: number;
  account: string;
  region: string;
  read_capacity_units: number;
  write_capacity_units: number;
  write_utilization_ratio_datapoints: number[];
  read_utilization_ratio_datapoints: number[];
}

export default {
  name: 'ChartPrompt',
  components: {
    Line
  },
  props: {
    value:{
      type: String
    },
    json_obj:{
      type: Object as () => DynamoDBMetricsData
    }
  },
  computed: {
    linedata(): { labels: string[], datasets: { label: string, backgroundColor: string, borderColor: string, data: number[] }[] } {
      const array = []
      for (let i = 0; i < 30; i++) {
        array.push("Day " + (i+1))
      }

      const rawdata: unknown = this.json_obj;
      const metricsData = rawdata as DynamoDBMetricsData;

      return {
        labels: array,
        datasets: [
          {
            label: 'Write Datapoint',
            backgroundColor: '#f87979',
            borderColor: '#f87979',
            data: metricsData.write_utilization_ratio_datapoints
          },
          {
            label: 'Read datapoint',
            backgroundColor: '#f87900',
            borderColor: '#f87900',
            data: metricsData.read_utilization_ratio_datapoints
          }
        ]
      }
    },
    lineoption(): ChartOptions {
      const rawdata: unknown = this.json_obj;
      const metricsData = rawdata as DynamoDBMetricsData;

      return {
        responsive: true,
        maintainAspectRatio: true,
        plugins: {
          title: {
            display: true,
            text:  'cost: $' + metricsData.cost.toFixed(2).toString() + '  / Read Units: ' + metricsData.read_capacity_units.toString() + ' / Write Units: ' + metricsData.write_capacity_units.toString()
          }
        },
        scales: {
          y: {
              title: {
                text: 'Percentage used'
              },
              min: 0,
              max: 100,
              ticks: { stepSize: 10 },
              beginAtZero: true
          },
          x: {
            title: {
              text: 'Days'
            },
            beginAtZero: true
          }
        }
      }
    }
  }
}
</script>

