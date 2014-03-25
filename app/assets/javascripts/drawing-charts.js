$(document).ready(function() {

	/* Force Returning Colors in Hex for Charts.js */
	var hexDigits = new Array("0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f"); 

	//Function to convert hex format to a rgb color
	function rgb2hex(rgb) {
		rgb = rgb.match(/^rgb\((\d+),\s*(\d+),\s*(\d+)\)$/);
		return "#" + hex(rgb[1]) + hex(rgb[2]) + hex(rgb[3]);
	}

	function hex(x) {
		return isNaN(x) ? "00" : hexDigits[(x - x % 16) / 16] + hexDigits[x % 16];
	}

	/* Coloring the Event Boxes */
	var colors = new Array();
	colors[0] = '#1abc9c'
	colors[1] = '#16a085'
	colors[2] = '#2ecc71'
	colors[3] = '#27ae60'
	colors[4] = '#3498db'
	colors[5] = '#2980b9'
	colors[6] = '#9b59b6'
	colors[7] = '#8e44ad'
	colors[8] = '#34495e'
	colors[9] = '#2c3e50'
	colors[10] = '#f1c40f'
	colors[11] = '#f39c12'
	colors[12] = '#e67e22'
	colors[13] = '#d35400'
	colors[14] = '#e74c3c'
	colors[15] = '#c0392b'
	colors[18] = '#ecf0f1'
	colors[19] = '#bdc3c7'
	colors[16] = '#95a5a6'
	colors[17] = '#7f8c8d'

	var numConsecutive = 4
	var counter = numConsecutive;
	var calm = 0;
	var fire = 0;
	var past_index = 0;
	$('.event-box').each(function() {
		$this = $(this);
		if (calm == 1 && counter >= 0) { // calm colors segment
		  counter -= 1;
		  index = Math.round(Math.random()*7); // first 8 colors
		  if (counter == 0) {
			counter = numConsecutive;
			calm = 0
		  }
		} else if (fire == 1 && counter >= 0) { // fire colors segment
		  counter -= 1;
		  index = 16-Math.round(Math.random()*7); // last 8 colors (2 in middle are greys)
		  if (counter == 0) {
			counter = numConsecutive;
			fire = 0
		  }
		} else { // pick either calm or fire
		  calm_or_fire = Math.random()
		  if (calm_or_fire < 0.5) {
			calm = 1
			index = Math.round(Math.random()*7);
		  } else {
			fire = 1
			index = 16-Math.round(Math.random()*7);
		  }
		}

		if (past_index == index) { // I don't want consecutive duplicates
		  while (past_index == index) {
			if (calm_or_fire < 0.5) {
			  index = Math.round(Math.random()*7);
			} else {
			  index = 16-Math.round(Math.random()*7);
			}
		  }
		}
		past_index = index;

		if ($this.hasClass("in-progress-event")) {
		  $this.css('border','1px dashed '+colors[index]);
		  $this.css('background-color','white');
		  $this.find('h2').css('color',colors[index]);
		  $this.find('h2').css('text-shadow','none');
		  $this.find('.duration-container').css('color',colors[index]);
		} else {
			$this.get(0).style.backgroundColor = colors[index];
			// $this.css('background-color',colors[index]);
			// $this.find('h2').css('text-shadow','1px 2px 0px '+colors[index]);
			$this.find('.duration-container').css('text-shadow','1px 2px 0px '+colors[index]);
		}
		$this.closest('.event-box').siblings('.time-container').css('color',colors[index]);
		$this.closest('.event-box').siblings('.time-container').css('border-top','1px solid '+colors[index]);
	});

	/* Drawing the Chart */
	$(".chart").each(function(index, chart) {
		$chart = $(chart);
		var ctx = $chart.get(0).getContext("2d");
		var data = [];
		var $eventsContainer = $chart.next(".events-container").first();
		$eventsContainer.find(".event-box").each(function(index, evnt) {
			$evnt = $(evnt);
			var duration = $evnt.find(".duration-container").text().trim();
			var bgColor = $evnt.css("background-color");
			bgColor = rgb2hex(bgColor);
			duration = duration.replace(/\s+/g, " ");
			duration = duration.split(" ");
			var durationTime = duration[0];
			var durationUnits = duration[1];
			durationTime = parseInt(durationTime);
			if (durationUnits.indexOf("hr") != -1) {
				durationTime *= 60;
			}
			data.push({value:durationTime, color:bgColor});
		});
		console.log(data);
		var doughnutOptions = {
			//Boolean - Whether we should show a stroke on each segment
			segmentShowStroke : true,
			//String - The colour of each segment stroke
			segmentStrokeColor : "#fff",
			//Number - The width of each segment stroke
			segmentStrokeWidth : 2,
			//The percentage of the chart that we cut out of the middle.
			percentageInnerCutout : 40,
			//Boolean - Whether we should animate the chart	
			animation : true,
			//Number - Amount of animation steps
			animationSteps : 100,
			//String - Animation easing effect
			animationEasing : "easeOutBounce",
			//Boolean - Whether we animate the rotation of the Doughnut
			animateRotate : true,
			//Boolean - Whether we animate scaling the Doughnut from the centre
			animateScale : false,
			//Function - Will fire on animation completion.
			onAnimationComplete : null
		};

		var myNewChart = new Chart(ctx).Doughnut(data, doughnutOptions);
	})

});

