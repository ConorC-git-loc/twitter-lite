// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("chartkick")
require("chart.js")
require("jquery")

//= require jquery3
//= require jquery-ui
//= require popper
//= require bootstrap-sprockets

require("trix")
require("@rails/actiontext")





// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)




// follow button tweets#index

$(document).on('ajax:success', '.follow', function(e) {
  let data = e.detail[0];
  let method = this.dataset.method === 'post' ? 'delete' : 'post';
  let txt = {
    post: 'Follow',
    delete: 'Unfollow'
  }[method];
  //loop
  $(`.follow[href="${this.getAttribute('href')}"]`).each(function() {
    this.dataset.method = method;
    $(this).text(`${txt}`);
  });
  $("#following_count").load(" #following_count > *")
});





// follow button home#show


$(document).on('ajax:success', '.follow-btn-show', function(e){
  let data = e.detail[0];
  let $el = $(this);
  let method = this.dataset.method;
  if (method === 'post') {
    $el.text('Unfollow');
    this.dataset.method = 'delete';
  } else if (method === 'delete') {
    $el.text('Follow');
    this.dataset.method = 'post';
  }
  $("#follower_count").load(" #follower_count > *")
});


$(document).on('div#comments').on('div#comments');
 $(function() {
  $('a#show-comments').click(function(event){
    event.preventDefault();
    $('div#comments').toggle();
  });
});



//sidebar


$(document).on('turbolinks:load', function () {
  $('#sidebarShow').on('click', function (event) {
    event.preventDefault();
    $('#sidebar, #content').toggleClass('active');
    $('.collapse.in').toggleClass('in');
    $('a[aria-expanded=true]').attr('aria-expanded', 'false');
  });
});


$(document).click(function(e) {
  var sidebar = $("#sidebar, #sidebarShow");
  if (!sidebar.is(e.target) && sidebar.has(e.target).length === 0) {
    sidebar.addClass('active')
  }
});









require("trix")
require("@rails/actiontext")