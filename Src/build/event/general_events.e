
class GENERAL_EVENTS 

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

	
feature 

	make (page_n: STRING; a_symbol: PIXMAP; cat: EVENT_CATALOG) is
		do
			page_create (page_n, a_symbol, cat);
		end;
	
feature {NONE}

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

	make_visible (a_name: STRING; a_parent: COMPOSITE) is
		do
			page_make_visible (a_name, a_parent);
			append_general_events;
		end

end -- class GENERAL_EVENTS   
