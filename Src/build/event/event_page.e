
deferred class EVENT_PAGE 

inherit
	
	CAT_PAGE [EVENT]
		redefine
			create_new_icon, associated_catalog, new_icon
		end;

feature {NONE}

	new_icon: CAT_EV_IS;

	associated_catalog: EVENT_CATALOG;

	create_new_icon is
		do
			!!new_icon.make (Current);
		end;

	create_button is
		do
			!! button
		end;
	
feature 

	hide_button is 
		do 
			button.hide 
		end;

	show_button is 
		do 
			button.show 
		end;

end -- class EVENT_PAGE   
