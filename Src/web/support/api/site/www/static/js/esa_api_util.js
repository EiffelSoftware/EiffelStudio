$.fn.pressEnter = function(fn) {  
  
    return this.each(function() {  
        $(this).bind('enterPress', fn);
        $(this).keyup(function(e){
            if(e.keyCode == 13)
            {
              $(this).trigger("enterPress");
            }
        })
    });  
 }; 


$(document).ready(function() {

	$('#check_uncheck').toggle(function(){
	      $('input:checkbox').attr('checked','checked');
	          $(this).val('uncheck all')
	      },function(){
	          $('input:checkbox').removeAttr('checked');
	          $(this).val('check all');        
	 });
});