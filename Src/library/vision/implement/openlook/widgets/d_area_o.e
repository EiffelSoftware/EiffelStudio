indexing

	description: "OpenLook drawing area implementation";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class D_AREA_O 

inherit

	PRIMITIVE_O
		rename
			set_width as old_set_width,
			set_height as old_set_height,
			set_size as old_set_size
		end;

	PRIMITIVE_O
		redefine
			set_width,
			set_height,
			set_size 
		select
			set_width, set_height, set_size
		end;


	PRIMITIVE_O
		redefine
			set_size, set_height, set_width
		end;

	D_AREA_I;

	DRAWING_X
		export
			{NONE} all
		end

creation

	make
	
feature 

	make (a_drawing_area: DRAWING_AREA) is
			-- Create a openlook drawing area.
		local
			ext_name: ANY;
		do
			ext_name := a_drawing_area.identifier.to_c;
			screen_object := create_drawing_area ($ext_name, 
									a_drawing_area.parent.implementation.screen_object);
			display_pointer := xt_display (screen_object);
			create_gc;
		end; 

	add_expose_action (a_command: COMMAND; argument: ANY) is
			-- Set `a_command' to be the action to execute when
			-- current area is exposed.
		require else
			not_a_command_void: not (a_command = Void)
		do
			if (expose_actions = Void) then
				!!expose_actions.make (screen_object, widget_oui)
			end;
			expose_actions.add (a_command, argument)
		end;

	add_input_action (a_command: COMMAND; argument: ANY) is
			-- Set `a_command' to be the action to execute when
			-- a key is pressed or when a mouse button is pressed.
		require else
			not_a_command_void: not (a_command = Void)
		do
			add_key_press_action (a_command, argument);
			add_button_press_action (1, a_command, argument);
			add_button_press_action (2, a_command, argument);
			add_button_press_action (3, a_command, argument);
		end;

	add_resize_action (a_command: COMMAND; argument: ANY) is
			-- Set `a_command' to be the action to execute when
			-- current area is resized.
		require else
			not_a_command_void: not (a_command = Void)
		do
			if (resize_actions = Void) then
				!!resize_actions.make (screen_object, widget_oui)
			end;
			resize_actions.add (a_command, argument)
		end;

feature {NONE}

	expose_actions: EXP_HAND_X;
			-- An event handler to manage call-backs when current area
			-- is exposed

	resize_actions: SIZE_HAND_X;
			-- An event handler to manage call-backs when current area
			-- is resized

	window_object: POINTER is
		do
			Result := xt_window (screen_object);
		end;
	
feature 

	remove_expose_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current area is exposed.
		require else
			not_a_command_void: not (a_command = Void)
		do
			expose_actions.remove (a_command, argument)
		end;

	remove_input_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- a key is pressed or when a mouse button is pressed.
		require else
			not_a_command_void: not (a_command = Void)
		do
			remove_key_press_action (a_command, argument);
			remove_button_press_action (1, a_command, argument);
			remove_button_press_action (2, a_command, argument);
			remove_button_press_action (3, a_command, argument);
		end;

	remove_resize_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current area is resized.
		require else
			not_a_command_void: not (a_command = Void)
		do
			resize_actions.remove (a_command, argument)
		end;

	set_width (new_width: INTEGER) is
		do
			set_managed (false);
			old_set_width (new_width);
			set_managed (true);
		end;

	set_height (new_height: INTEGER) is
		do
			set_managed (false);
			old_set_height (new_height);
			set_managed (true);
		end;

	set_size (new_width, new_height: INTEGER) is
		do
			set_managed (false);
			old_set_size (new_width, new_height);
			set_managed (true);
		end;

feature {NONE} -- External features

	create_drawing_area (name: POINTER; parent: POINTER): POINTER is
		external
			"C"
		end; 

end 


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
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
