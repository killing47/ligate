// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require jquery3
//= require popper
//= require bootstrap
//= require cocoon
//= require turbolinks
//= require_tree .

$(function() {
  $(document).on("ajax:success", ".fav", function(e) {
    data = e.detail[0]
    console.log();
    if ($('#' + e.detail[0]['cd']['id']).hasClass('fas')) {
      $('#' + e.detail[0]['cd']['id']).removeClass('fas').addClass('far');
      $('.favorite_cd').html('<p>' + e.detail[0]['cd_titles'] + '</p>');
    } else {
      $('#' + e.detail[0]['cd']['id']).removeClass('far').addClass('fas');
      $('.favorite_cd').html('<p>' + e.detail[0]['cd_titles'] + '</p>');
    }
  })
})
