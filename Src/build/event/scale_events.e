
class SCALE_EVENTS 

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
			Result := Pixmaps.scale_pixmap
		end;

	selected_symbol: PIXMAP is
		do
			Result := Pixmaps.selected_scale_pixmap
		end;

	focus_string: STRING is
		do
			Result := Focus_labels.scale_label
		end;
	
feature {NONE}

	make (cat: like associated_catalog) is
		do
			make_page (cat);
			extend (move_ev);
			extend (value_changed_ev)
		end

end -- class TEXT_EVENTS   
