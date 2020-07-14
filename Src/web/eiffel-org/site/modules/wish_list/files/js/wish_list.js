function onChangeCategory() {
  var wish_category = document.getElementById("wish_category");
  var selected_option = wish_category.options[wish_category.selectedIndex].text;
  console.log ("Wish Category:" +  selected_option);

  var wish_textarea = document.getElementById("wish_textarea");

  	//if textarea is empty then we add a template
  
  switch(selected_option) {
  	case "Library":
  		  wish_textarea.innerHTML = 'Library to be added: <name>\n' + 
  		                            'Language in which the library is written:\n'+
									'\n'+
									'What this library does (2-5 lines)\n'+
									'References: <URL>\n'+
                                    '\n'+
									'Why it is important to add that library?';
  		  break;
  		 case "Wrapper":
  		  wish_textarea.innerHTML = 'Library to be wrapped: <name>\n' + 
  		                            'Language in which the library is written:C/C++\n'+
									'\n'+
									'What this library does (2-5 lines)\n'+
									'References: <URL>\n'+
                                    '\n'+
									'Why it is important to wrap that library?';
  		  break; 
  		 default:
			wish_textarea.innerHTML = '';
  		 	break; 

  	} 
  
}

