
class MOUSE_EVENTS 

inherit
	
	EVENT_PAGE 
		rename
			make as page_make
		end;

creation

	make
	
feature {NONE}

	symbol: PIXMAP is
		do
			Result := Pixmaps.mouse_pixmap
		end;

	selected_symbol: PIXMAP is
		do
			Result := Pixmaps.selected_mouse_pixmap
		end;

	focus_string: STRING is
		do
			Result := Focus_labels.mouse_label
		end;

	append_mouse_events is
		do
			extend (mouse_motion1_ev);
			extend (mouse_motion2_ev);
			extend (mouse_motion3_ev);
			extend (mouse1u_ev);
			extend (mouse2u_ev);
			extend (mouse3u_ev);
			extend (mouse1d_ev);
			extend (mouse2d_ev);
			extend (mouse3d_ev);
		end;
	
feature {NONE}

	make (cat: like associated_catalog) is
		do
			page_make (cat);
			append_mouse_events
		end

end -- class MOUSE_EVENTS   
