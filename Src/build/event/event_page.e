
deferred class EVENT_PAGE 

inherit
	
	CAT_PAGE [EVENT]
		redefine
			create_new_icon, associated_catalog, new_icon,
			make_visible, make_unmanaged
		end;
	SHARED_EVENTS

feature {NONE}

	new_icon: CAT_EV_IS;

	associated_catalog: EVENT_CATALOG;

	create_new_icon is
		do
			!!new_icon.make (Current);
		end;

feature {CATALOG}

	make_visible (a_parent: COMPOSITE) is
		do
			Precursor (a_parent)
			set_preferred_count (4)
		end

	make_unmanaged (a_parent: COMPOSITE) is
		do
			Precursor (a_parent)
			set_preferred_count (4)
		end

feature 

	hide_button is 
		do 
			button.unmanage 
		end;

	show_button is 
		do 
			button.manage 
		end;

end -- class EVENT_PAGE   
