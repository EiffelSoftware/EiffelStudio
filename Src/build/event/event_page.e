

class EVENT_PAGE 

inherit
	
	CAT_PAGE [EVENT]
		rename
			make as old_create,
			make_button_visible as old_make_button_visible,
			make_visible as old_make_visible
		export
			{ANY} symbol
		redefine
			create_new_icon, associated_catalog, new_icon
		end;

	CAT_PAGE [EVENT]
		undefine
			make
		redefine
			make_button_visible, create_new_icon, 
			associated_catalog, new_icon, make_visible
		select
			make_button_visible, make, make_visible
		end;

	FOCUSABLE
		rename
			focus_string as page_name
		end


creation

	make

	
feature {CATALOG}

	make_button_visible (button_form: COMPOSITE) is
		do
			old_make_button_visible (button_form);
			initialize_focus
		end;

	
feature {NONE}

	focus_label: LABEL is
		do
			Result := associated_catalog.focus_label;
		end;

	focus_source: WIDGET is
		do
			Result := button.source_button;
		end;

	
feature 

	make (page_n: STRING; a_symbol: PIXMAP; cat: EVENT_CATALOG) is
		do
			old_create (page_n, a_symbol, cat)
		end;

	make_visible (a_name: STRING; a_parent: COMPOSITE) is
		do
			old_make_visible (a_name, a_parent);
			set_column_layout;
			set_preferred_count (5);
		end;

feature {NONE}

	new_icon: CAT_EV_IS;

	associated_catalog: EVENT_CATALOG;

	create_new_icon is
		do
			!!new_icon.make (Current);
		end;

	
feature 

	hide_button is do button.hide end;
	show_button is do button.show end;

end -- class EVENT_PAGE   
