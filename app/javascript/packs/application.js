// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import "@hotwired/turbo-rails"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import 'bootstrap/dist/js/bootstrap'
import "bootstrap/dist/css/bootstrap"
var jQuery = require("jquery")
global.$ = global.jQuery = jQuery;
window.$ = window.jQuery = jQuery;
import 'jquery-ui-bundle';
import 'jquery-ui-bundle/jquery-ui.min.css';

Rails.start()
ActiveStorage.start()

import "controllers"

$(document).on('turbo:load', function() {
  $('.text-to-reveal').on('click', function() {
      $(this).toggleClass('restrict_text', 1000)
  });
});