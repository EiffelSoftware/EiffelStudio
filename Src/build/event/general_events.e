
class GENERAL_EVENTS 

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
			Result := Pixmaps.general_pixmap
		end;

	selected_symbol: PIXMAP is
		do
			Result := Pixmaps.selected_general_pixmap
		end;

	focus_string: STRING is
		do
			Result := Focus_labels.general_label
		end;

	append_general_events is
		do
			extend (widget_destroy_ev);
			extend (mouse_enter_ev);
			extend (key_press_ev);
			extend (key_release_ev);
			extend (mouse_leave_ev);
			extend (pointer_motion_ev);
		end;
	
feature {CATALOG}

	make (cat: like associated_catalog) is
		do
			page_make (cat);
			append_general_events;
		end

end -- class GENERAL_EVENTS   
