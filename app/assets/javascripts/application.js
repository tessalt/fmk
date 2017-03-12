// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//
//

(function () {

  var votes = [].slice.call(document.querySelectorAll('.vote'));
  var values = [].slice.call(document.querySelectorAll('.value'));
  var form = document.getElementById('fmk');

  votes.forEach(function (vote) {
    vote.addEventListener('click', function (event) {
      event.preventDefault();
      votes.forEach(function (v) {
        if (v.dataset.type === vote.dataset.type) {
          v.classList.remove('selected');
        }
      });
      vote.classList.add('selected');
      var index = vote.dataset.index;
      var input = document.getElementById('votes_' + index + '_value');
      input.value = vote.dataset.type;


      allValues().forEach(function (v, i) {
        if (i !== parseInt(index) && v === vote.dataset.type) {
          values[i].value = '';
        }
      });

      if (allValues().filter(Boolean).length === 3) {
        form.submit();
      }

    });
  });

  function allValues() {
    return values.map(function (value) {
      return value.value;
    });
  }
})();
