
class TEXT_F_EVENTS 

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
			Result := Pixmaps.text_field_pixmap
		end;

	selected_symbol: PIXMAP is
		do
			Result := Pixmaps.selected_text_field_pixmap
		end;

	focus_string: STRING is
		do
			Result := Focus_labels.text_field_label
		end;

feature {CATALOG}

	make (cat: like associated_catalog) is
		do
			make_page (cat);
			extend (key_return_ev);
		end

end
