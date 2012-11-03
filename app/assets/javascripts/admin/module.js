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

$(document).ready(function() {

  $("#notice").hide();
  $("#alert").hide();

  $("a.cheatsheet").click(function() {
    $("#textile-cheatsheet").fadeIn();
  });

  $("#textile-cheatsheet a.cheatsheet-close").click(function() {
    $("#textile-cheatsheet").fadeOut();
  });

  if ($("#notice p").text().length > 0) {
    $("#notice").fadeIn().delay(7000).slideUp();
  }

  $("#notice p").click(function(){
    $(this).slideUp();
  });

  if ($("#alert p").text().length > 0) {
    $("#alert").fadeIn().delay(7000).slideUp();
  }

  $("#alert p").click(function(){
    $(this).slideUp();
  });

  $("a.cheatsheet").click(function() {
    $("#textile-cheatsheet").fadeIn();
  });

  $("#textile-cheatsheet a.cheatsheet-close").click(function() {
    $("#textile-cheatsheet").fadeOut();
  });

  $("ul.master").click(function() {
    $("ul.child").slideUp();
    $(this).next("ul.child").slideDown();
  });

  if ($("ul.child li").hasClass("current")) {
    var current = $("ul.child li.current");
    $("ul.child li.current").parent().slideDown();
  }

});

