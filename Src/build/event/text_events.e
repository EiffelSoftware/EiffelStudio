
class TEXT_EVENTS 

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
			Result := Pixmaps.text_pixmap
		end;

	selected_symbol: PIXMAP is
		do
			Result := Pixmaps.selected_text_pixmap
		end;

	focus_string: STRING is
		do
			Result := Focus_labels.text_label
		end;

feature {NONE}

	make (cat: like associated_catalog) is
		do
			make_page (cat);
			extend (text_modify_ev);
			extend (text_motion_ev)
		end

end
