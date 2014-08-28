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


var EWFCMS = EWFCMS || { };

EWFCMS.toggleFieldset = function(fieldset) { 
		if ($(fieldset).is('.collapsed')) {
			var content = $('> div:not(.action)', fieldset);
			$(fieldset).removeClass('collapsed');
			content.hide();
			content.slideDown( {
				duration: 'fast',
				easing: 'linear',
				complete: function() {
					//Drupal.collapseScrollIntoView(this.parentNode);
					this.parentNode.animating = false;
					$('div.action', fieldset).show();
					},
				step: function() {
					// Scroll the fieldset into view
					//Drupal.collapseScrollIntoView(this.parentNode);
				  }
				});
		} else {
			var content = $('> div:not(.action)', fieldset).slideUp('fast', function() {
				$(this.parentNode).addClass('collapsed');
				this.parentNode.animating = false;
			});
		}
	};

jQuery(document).ready(function(){
	//$('.collapsed').hide();
	$('fieldset.collapsible > legend').each(function() {
		var fieldset = $(this.parentNode);
		// turn legen into clickable link and wrap contents
		var text = this.innerHTML;
		$(this).empty()
		.append($('<a href="#">'+ text + '</a>').click(function() {
			var fieldset = $(this).parents('fieldset:first')[0];
			if (!fieldset.animating) {
				fieldset.animating = true;
				EWFCMS.toggleFieldset(fieldset);
			}
			return false;
		}
		))
		.after($('<div class="fieldset-wrapper"></div>')
		.append(fieldset.children(':not(legend):not(.action)')))
		.addClass('collapse-processed');
	});
	$('fieldset.collapsed').each(function() {
			$(this).removeClass('collapsed');
			EWFCMS.toggleFieldset(this);
	});
});

jQuery(document).ready(function(){
	$('#tabs').tabs();
});

//jQuery(document).ready(function(){
	//$('#second_sidebar').hide();
//});

