
class MOUSE_EVENTS 

inherit
	
	EVENT_PAGE 
		rename
			make as page_create,
			make_visible as page_make_visible
		end;
	EVENT_PAGE
		rename
			make as page_create
		redefine
			make_visible
		select
			make_visible
		end

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

	
feature 

	make (page_n: STRING; a_symbol: PIXMAP; cat: EVENT_CATALOG) is
		do
			page_create (page_n, a_symbol, cat);
		end;

	
feature {NONE}

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

	
feature {CATALOG}

	make_visible (a_name: STRING; a_parent: COMPOSITE) is
		do
			page_make_visible (a_name, a_parent);
			append_mouse_events
		end

end -- class MOUSE_EVENTS   
