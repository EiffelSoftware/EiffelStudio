indexing

	description: 
		"EiffelVision implementation of the X Display.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class SCREEN_X

inherit

	W_MAN_GEN
		export
			{NONE} all
		undefine
			is_equal
		end;

	G_ANY_I
		export
			{NONE} all
		undefine
			is_equal
		end;

	DRAWING_X
		undefine
			is_equal
		redefine
			display_handle
		end;

	SCREEN_I
		rename
			screen_object as display_handle
		undefine
			is_equal
		end;

	MEL_DISPLAY
		rename
			make as make_display,
			handle as display_handle
		redefine
			display_handle
		end;

	SHARED_MEL_DISPLAY
		undefine
			is_equal
		end

creation

	make

feature {NONE} -- Initialization

	make (app_context: MEL_APPLICATION_CONTEXT; 
			a_screen: SCREEN; 
			application_class: STRING) is
			-- Create a screen
		do
			make_display (app_context, a_screen.screen_name, 
					Void, application_class);
			if is_valid then
				create_gc (default_screen);
				display_cell.put (Current)
			end
		end;

feature -- Access

	display_handle: POINTER;
			-- C pointer to X display

	window: POINTER is
			-- Root window of default screen
		do	
			Result := default_screen.root_window
		end;

	depth: INTEGER is
			-- Default depth of root window
		do
			Result := default_screen.default_depth
		end;

	buttons: BUTTONS is
			-- Current state of the mouse buttons
		local
			i: INTEGER
		do
			!! Result.make (5);
			from
				i := 1
			until
				i > 5
			loop
				Result.put (default_screen.query_button_pointer (i), i);
				i := i+1
			end
		ensure then
			not (Result = Void)
		end; 

	height: INTEGER is
			-- Height of screen
		do
			Result := default_screen.height
		end;

	screen: SCREEN_I is
			-- Screen of widget
		do
			Result := Current
		ensure then
			not (Result = Void)
		end;

	widget_pointed: WIDGET is
			-- Widget currently pointed by the pointer
		local
			mel_widget: WIDGET_M;
			widget_list: LINKED_LIST [MEL_OBJECT]
		do
			widget_list := default_screen.mel_widgets_pointed;
				-- Find a EiffelVision widget by going
				-- from the child to the parent
			from
				widget_list.finish;
			until
				widget_list.before or else
				Result /= Void
			loop
				mel_widget ?= widget_list.item;
				if mel_widget /= Void then
					Result := mel_widget.widget_oui
				end;
				widget_list.back
			end;
		end;

	width: INTEGER is
			-- Width of screen
		do
			Result := default_screen.width
		end;

	x: INTEGER is
			-- Current absolute horizontal coordinate of the mouse
		do
			Result := default_screen.x
		end;

	y: INTEGER is
			-- Current absolute vertical coordinate of the mouse
		do
			Result := default_screen.y
		end

feature {NONE} -- Useless routines

	add_expose_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- current area is exposed.
		do
		end; 

	remove_expose_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current area is exposed.
		do
		end;

end -- class SCREEN_X

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
