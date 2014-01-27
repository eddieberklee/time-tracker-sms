$(function() {

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

  var change_this = 4
  var counter = change_this;
  var calm = 0;
  var fire = 0;
  var past_index = 0;
  $('.event-box').each(function() {
    $this = $(this);
    if (calm == 1 && counter >= 0) {
      counter -= 1;
      index = Math.round(Math.random()*7);
      if (counter == 0) {
        counter = change_this;
        calm = 0
      }
    } else if (fire == 1 && counter >= 0) {
      counter -= 1;
      index = 16-Math.round(Math.random()*7);
      if (counter == 0) {
        counter = change_this;
        fire = 0
      }
    } else {
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
      $this.css('background-color',colors[index]);
      // $this.find('h2').css('text-shadow','1px 2px 0px '+colors[index]);
      $this.find('.duration-container').css('text-shadow','1px 2px 0px '+colors[index]);
    }
    $this.closest('.event-box').siblings('.time-container').css('color',colors[index]);
    $this.closest('.event-box').siblings('.time-container').css('border-top','1px solid '+colors[index]);
  });
  $('.event-box').hover(function() {
    $this = $(this);
    if (!$this.attr('data-height')) {
      var current_height = parseInt($this.css('height'));
      var new_height = parseInt($this.find('h2').css('height')) + 10;
      if (new_height > current_height) {
        $this.attr('data-height',$this.css('height'));
        $this.css('height',new_height);
      }
    }
  }, function() {
    $this = $(this);
    if ($this.attr('data-height')) {
      height = $this.attr('data-height');
      $this.css('height',height);
      $this.removeAttr('data-height');
    }
  });

});


