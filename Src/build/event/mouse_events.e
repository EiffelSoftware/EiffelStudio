
class MOUSE_EVENTS 

inherit
	
	EVENT_PAGE 
		rename
			make as page_make
		end;

creation

	make
	
feature {NONE}

	mouse_motion1: MOUSE_MOT1_EV is
		once
			!!Result.make
		end;

	mouse_motion2: MOUSE_MOT2_EV is
		once
			!!Result.make
		end;

	mouse_motion3: MOUSE_MOT3_EV is
		once
			!!Result.make
		end;

	mouse1u: MOUSE1U_EV is
		once
			!!Result.make
		end;

	mouse2u: MOUSE2U_EV is
		once
			!!Result.make
		end;

	mouse3u: MOUSE3U_EV is
		once
			!!Result.make
		end;

	mouse1d: MOUSE1D_EV is
		once
			!!Result.make
		end;

	mouse2d: MOUSE2D_EV is
		once
			!!Result.make
		end;

	mouse3d: MOUSE3D_EV is
		once
			!!Result.make
		end;

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
			extend (mouse_motion1);
			extend (mouse_motion2);
			extend (mouse_motion3);
			extend (mouse1u);
			extend (mouse2u);
			extend (mouse3u);
			extend (mouse1d);
			extend (mouse2d);
			extend (mouse3d);
		end;
	
feature {NONE}

	make (cat: like associated_catalog) is
		do
			page_make (cat);
			append_mouse_events
		end

end -- class MOUSE_EVENTS   
