
class GENERAL_EVENTS 

inherit
	
	EVENT_PAGE 
		rename
			make as page_make
		end;

creation

	make
	
feature {NONE}

	widget_destroy: WIDGET_DEST_EV is
		once
			!!Result.make
		end;

	mouse_enter: MOUSE_ENTER_EV is
		once
			!!Result.make
		end;

	key_press: KEY_PRESS_EV is
		once
			!!Result.make
		end;

	key_release: KEY_RELEASE_EV is
		once
			!!Result.make
		end;

	mouse_leave: MOUSE_LEAVE_EV is
		once
			!!Result.make
		end;

	pointer_motion: POINTER_MOTION_EV is
		once
			!!Result.make
		end;
	
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
			extend (widget_destroy);
			extend (mouse_enter);
			extend (key_press);
			extend (key_release);
			extend (mouse_leave);
			extend (pointer_motion);
		end;
	
feature {CATALOG}

	make (cat: like associated_catalog) is
		do
			page_make (cat);
			append_general_events;
		end

end -- class GENERAL_EVENTS   
