
class LIST_EVENTS 

inherit
	
	EVENT_PAGE 
		rename
			make as make_page
		redefine
			is_optional
		end;

creation

	make

feature {CATALOG}

	is_optional: BOOLEAN is True;
	
feature {NONE}

	symbol: PIXMAP is
		do
			Result := Pixmaps.list_pixmap
		end;

	selected_symbol: PIXMAP is
		do
			Result := Pixmaps.selected_list_pixmap
		end;

	focus_string: STRING is
		do
			Result := Focus_labels.list_label
		end;

feature {NONE}

	make (cat: like associated_catalog) is
		do
			make_page (cat);
			extend (selection_ev);
		end

end 
