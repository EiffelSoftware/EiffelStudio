
class DRAWING_EVENTS 

inherit
	
	EVENT_PAGE
		rename
			make as page_make
		redefine
			is_optional
		end;

creation

	make
	
feature {CATALOG}

	is_optional: BOOLEAN is True;
	
feature {NONE}

	expose_ev: EXPOSE_EV is
		once
			!!Result.make
		end;

	input_ev: INPUT_EV is
		once
			!!Result.make
		end;

	resize_ev: RESIZE_EV is
		once
			!!Result.make
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.drawing_area_pixmap
		end;

	selected_symbol: PIXMAP is
		do
			Result := Pixmaps.selected_drawing_area_pixmap
		end;

	focus_string: STRING is
		do
			Result := Focus_labels.drawing_label
		end;

feature {NONE}

	make (cat: like associated_catalog) is
		do
			page_make (cat);
			extend (expose_ev);
			extend (input_ev);
			extend (resize_ev);
		end

end -- class TEXT_EVENTS   
