$(function() {

  $('.event-box').hover(function() {
    $this = $(this);
    if (!$this.attr('data-height')) {
      var current_height = parseInt($this.css('height'));
      var new_height = parseInt($this.find('h2').css('height')) + 15;
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


