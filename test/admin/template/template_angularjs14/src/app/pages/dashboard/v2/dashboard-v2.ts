import { Component, OnInit } from '@angular/core';
import { startOfDay, endOfDay, subDays, addDays, endOfMonth, isSameDay, isSameMonth, addHours } from 'date-fns';
import global from '../../../config/globals';

declare let d3: any;

@Component({
  selector: 'dashboard-v2',
  templateUrl: './dashboard-v2.html'
})

export class DashboardV2Page implements OnInit {
  chartColor;
  chartData;
  pieChartData;
  viewDate: Date = new Date();
  events = [{
    start: subDays(startOfDay(new Date()), 1),
    end: addDays(new Date(), 1),
    title: 'A 3 day event',
    color: global.color.success
  }, {
    start: startOfDay(new Date()),
    title: 'An event with no end date',
    color: '#ff5b57'
  }, {
    start: subDays(endOfMonth(new Date()), 3),
    end: addDays(endOfMonth(new Date()), 3),
    title: 'A long event that spans 2 months',
    color: '#348fe2'
  }, {
    start: addHours(startOfDay(new Date()), 2),
    end: new Date(),
    title: 'A draggable and resizable event',
    color: '#727cb6'
  }];

  ngOnInit() {
		this.chartColor = { domain: [global.color.blue, global.color.success, global.color.purple, global.color.componentColor] };
    this.chartData = [{
			"name":"Congo",
			"series":[{"value":2377,"name":"Thu 15"},{"value":4567,"name":"Sat 17"},{"value":2865,"name":"Mon 19"},{"value":2060,"name":"Wed 21"},{"value":3287,"name":"Fri 23"}]},{"name":"Micronesia","series":[{"value":5234,"name":"Thu 15"},{"value":2876,"name":"Sat 17"},{"value":4297,"name":"Mon 19"},{"value":2558,"name":"Wed 21"},{"value":2371,"name":"Fri 23"}]},{"name":"Malaysia","series":[{"value":2369,"name":"Thu 15"},{"value":5229,"name":"Sat 17"},{"value":3457,"name":"Mon 19"},{"value":4401,"name":"Wed 21"},{"value":2835,"name":"Fri 23"}]},{"name":"Yemen","series":[{"value":2099,"name":"Thu 15"},{"value":4383,"name":"Sat 17"},{"value":6724,"name":"Mon 19"},{"value":2870,"name":"Wed 21"},{"value":5753,"name":"Fri 23"}]},{"name":"Åland Islands","series":[{"value":4907,"name":"Thu 15"},{"value":2428,"name":"Sat 17"},{"value":5384,"name":"Mon 19"},{"value":5966,"name":"Wed 21"},{"value":2605,"name":"Fri 23"}]
		}];
    this.pieChartData = [{"name":"Germany","value":8940000},{"name":"USA","value":5000000},{"name":"France","value":7200000}];
  }
}
