note

	description: 
		"EiffelVision implementation of the X Display."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class SCREEN_IMP

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

	DRAWING_IMP
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
        
	SHARED_APPLICATION_CONTEXT
		undefine
			is_equal
		end

create

	make

feature {NONE} -- Initialization

	make (a_screen: SCREEN)
			-- Create a screen
		do
			make_display (application_context, a_screen.screen_name, 
					Void, application_class);
			if is_valid then
				create_gc (default_screen);
				display_cell.put (Current)
			end
		end;

feature -- Access

	display_handle: POINTER;
			-- C pointer to X display

	window: POINTER
			-- Root window of default screen
		do	
			Result := default_screen.root_window
		end;

	depth: INTEGER
			-- Default depth of root window
		do
			Result := default_screen.default_depth
		end;

	buttons: BUTTONS
			-- Current state of the mouse buttons
		local
			i: INTEGER
		do
			create Result.make (5);
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

	height: INTEGER
			-- Height of screen
		do
			Result := default_screen.height
		end;
	
	visible_height: INTEGER
			-- Visible height is the same as height on X. 
		do
			Result := height
		end;
	
	
	
	screen: SCREEN_I
			-- Screen of widget
		do
			Result := Current
		ensure then
			not (Result = Void)
		end;

	widget_pointed: WIDGET
			-- Widget currently pointed by the pointer
		local
			mel_widget: WIDGET_IMP;
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

	width: INTEGER
			-- Width of screen
		do
			Result := default_screen.width
		end;

	visible_width: INTEGER
			-- Visible width is the same as width on X. 
		do
			Result := width
		end;
	
	x: INTEGER
			-- Current absolute horizontal coordinate of the mouse
		do
			Result := default_screen.x
		end;

	y: INTEGER
			-- Current absolute vertical coordinate of the mouse
		do
			Result := default_screen.y
		end

feature {NONE} -- Useless routines

	add_expose_action (a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of action to execute when
			-- current area is exposed.
		do
		end; 

	remove_expose_action (a_command: COMMAND; argument: ANY)
			-- Remove `a_command' from the list of action to execute when
			-- current area is exposed.
		do
		end;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class SCREEN_IMP


