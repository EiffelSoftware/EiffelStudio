indexing

	description: "Motif drawing area implementation";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class D_AREA_M 

inherit

	DRAWING_X
		export
			{NONE} all
		end;

	D_AREA_I;

	PRIMITIVE_M
		rename
			clean_up as primitive_clean_up
		export
			{NONE} all
		end;

	PRIMITIVE_M
		export
			{NONE} all
		redefine
			clean_up
		select
			clean_up
		end;

	D_AREA_R_M
		export
			{NONE} all
		end

creation

	make

feature {NONE} -- Creation

	make (a_drawing_area: DRAWING_AREA; man: BOOLEAN) is
			-- Create a motif drawing area.
		local
			ext_name_area: ANY
		do
			widget_index := widget_manager.last_inserted_position;
			ext_name_area := a_drawing_area.identifier.to_c;
			screen_object := create_drawing_area ($ext_name_area,
					parent_screen_object (a_drawing_area, widget_index),
					man);
			display_pointer := xt_display (screen_object);
			create_gc
		end;

feature

	add_expose_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- current area is exposed.
		require else
			not_a_command_void: not (a_command = Void)
		do
			if (expose_actions = Void) then
				!! expose_actions.make (screen_object,
						Mexpose, widget_oui)
			end;
			expose_actions.add (a_command, argument)
		end;

	add_input_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- a key is pressed or when a mouse button is pressed.
		require else
			not_a_command_void: not (a_command = Void)
		do
			if (input_actions = Void) then
				!! input_actions.make (screen_object,
						MinputAction, widget_oui)
			end;
			input_actions.add (a_command, argument)
		end;

	add_resize_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- current area is resized.
		require else
			not_a_command_void: not (a_command = Void)
		do
			if (resize_actions = Void) then
				!! resize_actions.make (screen_object,
						MresizeAction, widget_oui)
			end;
			resize_actions.add (a_command, argument)
		end;

feature {NONE}

	window_object: POINTER is
			-- X identifier of the drawable.
		do
			Result := xt_window (screen_object)
		end;

	expose_actions: EVENT_HAND_M;
			-- An event handler to manage call-backs when current area
			-- is exposed

	input_actions: EVENT_HAND_M;
			-- An event handler to manage call-backs when a key is pressed
			-- or when a mouse button is pressed

	resize_actions: EVENT_HAND_M;
			-- An event handler to manage call-backs when current area
			-- is resized

	clean_up is
		do
			primitive_clean_up;
			if expose_actions /= Void then
				expose_actions.free_cdfd
			end;
			if input_actions /= Void then
				input_actions.free_cdfd
			end;
			if resize_actions /= Void then
				resize_actions.free_cdfd
			end;
		end

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
			input_actions.remove (a_command, argument)
		end;

	remove_resize_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current area is resized.
		require else
			not_a_command_void: not (a_command = Void)
		do
			resize_actions.remove (a_command, argument)
		end;

feature {NONE} -- External features

	create_drawing_area (a_name: POINTER; scr_obj: POINTER; 
				man: BOOLEAN): POINTER is
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
