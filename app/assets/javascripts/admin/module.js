// This is a manifest file that"ll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they"ll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It"s not advisable to add code directly here, but if you do, it"ll appear at the bottom of the
// the compiled file.
//
//= require html5
//= require jquery
//= require jquery_ujs
//= require jquery.validate
//= require validate/localization/messages_pt_BR
//= require turbolinks
//= require admin/meny

var ready = function() {

  var meny = Meny.create({
    menuElement: document.querySelector( '.meny' ),
    contentsElement: document.querySelector( '.contents' ),
    position: Meny.getQuery().p || 'left',
    width: 260,
    threshold: 40
  });

  $("form").validate();

};

$(document).ready(ready);

$(document).on('page:load', ready);
