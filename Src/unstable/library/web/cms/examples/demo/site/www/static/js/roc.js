/*
 * EWF CMS javascript based on JQuery
 */

/**
 * Override jQuery.fn.init to guard against XSS attacks.
 *
 * See http://bugs.jquery.com/ticket/9521
 */

(function () {
  var jquery_init = jQuery.fn.init;
  jQuery.fn.init = function (selector, context, rootjQuery) {
    // If the string contains a "#" before a "<", treat it as invalid HTML.
    if (selector && typeof selector === 'string') {
      var hash_position = selector.indexOf('#');
      if (hash_position >= 0) {
        var bracket_position = selector.indexOf('<');
        if (bracket_position > hash_position) {
          throw 'Syntax error, unrecognized expression: ' + selector;
        }
      }
    }
    return jquery_init.call(this, selector, context, rootjQuery);
  };
  jQuery.fn.init.prototype = jquery_init.prototype;
})();


var ROC = ROC || { };

$('body').on('click',"a[rel='node']",function(e){

  e.preventDefault();
  /*
  if uncomment the above line, html5 nonsupported browers won't change the url but will display the ajax content;
  if commented, html5 nonsupported browers will reload the page to the specified link.
  */

  //get the link location that was clicked
  pageurl = $(this).attr('href');

  spinner = "<span class='loading'><h3>Loading content..</h3><img src='/static/images/ajax-loader.gif' alt='loading...' class='spinner'></span>";  
  //to get the ajax content and display in div with class 'main'
  $.ajax({url:pageurl+'?rel=node',success: function(data){
  $('.main').html(data);
  }});

  //to change the browser URL to the given link location
  //if(pageurl!=window.location){
  //window.history.pushState({path:pageurl},'',pageurl);
  //}
  //stop refreshing to the page given in
  return false;
});

$('body').on('click',"a[rel='register']",function(e){

  e.preventDefault();
  /*
  if uncomment the above line, html5 nonsupported browers won't change the url but will display the ajax content;
  if commented, html5 nonsupported browers will reload the page to the specified link.
  */

  //get the link location that was clicked
  pageurl = $(this).attr('href');

  spinner = "<span class='loading'><h3>Loading content..</h3><img src='/static/images/ajax-loader.gif' alt='loading...' class='spinner'></span>";  
  //to get the ajax content and display in div with class 'main'
  $.ajax({url:pageurl+'?rel=node',success: function(data){
  $('.main').html(data);
  }});

  //to change the browser URL to the given link location
  //if(pageurl!=window.location){
  //window.history.pushState({path:pageurl},'',pageurl);
  //}
  //stop refreshing to the page given in
  return false;
});



$("a[rel='node']").click(function(e){
	e.preventDefault();
	/*
	if uncomment the above line, html5 nonsupported browers won't change the url but will display the ajax content;
	if commented, html5 nonsupported browers will reload the page to the specified link.
	*/

	//get the link location that was clicked
	pageurl = $(this).attr('href');

	spinner = "<span class='loading'><h3>Loading content..</h3><img src='/static/images/ajax-loader.gif' alt='loading...' class='spinner'></span>";  
	//to get the ajax content and display in div with class 'main'
	$.ajax({url:pageurl+'?rel=node',success: function(data){
	$('.main').html(data);
	}});

	//to change the browser URL to the given link location
	//if(pageurl!=window.location){
	//window.history.pushState({path:pageurl},'',pageurl);
	//}
	//stop refreshing to the page given in
	return false;
});


