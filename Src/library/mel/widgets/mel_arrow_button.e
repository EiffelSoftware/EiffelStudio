indexing

	description:
			"Directional arrow-shaped button.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_ARROW_BUTTON

inherit

	MEL_ARROW_BUTTON_RESOURCES
		export
			{NONE} all
		end;

	MEL_PRIMITIVE
		redefine
			create_callback_struct
		end

creation 
	make,
	make_from_existing

feature -- Initialization

	make (a_name: STRING; a_parent: MEL_COMPOSITE; do_manage: BOOLEAN) is
			-- Create a motif arrow button widget.
		require
			name_exists: a_name /= Void;
			parent_exists: a_parent /= Void and then not a_parent.is_destroyed
		local
			widget_name: ANY
		do
			parent := a_parent;	
			widget_name := a_name.to_c;
			screen_object := xm_create_arrow_button (a_parent.screen_object, $widget_name, default_pointer, 0);
			Mel_widgets.add (Current);
			set_default;
			if do_manage then
				manage
			end
		ensure
			exists: not is_destroyed;
			parent_set: parent = a_parent;
			name_set: name.is_equal (a_name)
		end;

feature -- Access

	activate_command: MEL_COMMAND_EXEC is
			-- Command set for the activate callback
		do
			Result := motif_command (XmNactivateCallback)
		end;

	arm_command: MEL_COMMAND_EXEC is
			-- Command set for the arm callback
		do
			Result := motif_command (XmNarmCallback)
		end;

	disarm_command: MEL_COMMAND_EXEC is
			-- Command set for the disarm callback
		do
			Result := motif_command (XmNdisarmCallback)
		end

feature -- Status report

	is_up: BOOLEAN is
			-- Does the arrow point up?
		require
			exists: not is_destroyed
		do
			Result := XmARROW_UP = arrow_direction
		end;

	is_down: BOOLEAN is
			-- Does the arrow point down?
		require
			exists: not is_destroyed
		do
			Result := XmARROW_DOWN = arrow_direction
		end;

	is_left: BOOLEAN is
			-- Does the arrow point to the left?
		require
			exists: not is_destroyed
		do
			Result := XmARROW_LEFT = arrow_direction
		end;

	is_right: BOOLEAN is
			-- Does the arror point to the right?
		require
			exists: not is_destroyed
		do
			Result := XmARROW_RIGHT = arrow_direction
		end;

	is_multiclick_kept: BOOLEAN is
			-- Are the successive button clicks processed?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNmultiClick) = XmMULTICLICK_KEEP
		end;

	is_multiclick_discarded: BOOLEAN is
			-- Are the successive button clicks discard?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char 
				(screen_object, XmNmultiClick) = XmMULTICLICK_DISCARD
		end;

feature -- Status setting

	set_up is
			-- Set the arrow direction to up.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNarrowDirection, XmARROW_UP)
		ensure
			set: is_up
		end;

	set_down is
			-- Set the arrow direction to down.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNarrowDirection, XmARROW_DOWN)
		ensure
			set: is_down
		end;

	set_left is
			-- Set the arrow direction to left.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNarrowDirection, XmARROW_LEFT)
		ensure
			set: is_left
		end;

	set_right is
			-- Set the arrow direction to right.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNarrowDirection, XmARROW_RIGHT)
		ensure
			set: is_right
		end;

	set_multiclick_to_keep is
			-- Set `is_multiclick_kept' to True.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNmultiClick, XmMULTICLICK_KEEP)
		ensure
			keep_successive_clicks: is_multiclick_kept
		end;

	set_multiclick_to_discard is
			-- Set `is_multiclick_discarded' to True.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNmultiClick, XmMULTICLICK_DISCARD)
		ensure
			discard_successive_clicks: is_multiclick_discarded
		end;

feature -- Element change

	set_activate_callback (a_command: MEL_COMMAND; an_argument: ANY) is
			-- Set `a_command' to be executed when the button is
			-- is pressed and released.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			command_not_void: a_command /= Void
		do
			set_callback (XmNactivateCallback, a_command, an_argument);
		ensure
			command_set: command_set (activate_command, a_command, an_argument)

		end;

	set_arm_callback (a_command: MEL_COMMAND; an_argument: ANY) is
			-- Set `a_command' to be executed when the button is pressed.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			command_not_void: a_command /= Void
		do
			set_callback (XmNarmCallback, a_command, an_argument);
		ensure
			command_set: command_set (arm_command, a_command, an_argument)
		end;

	set_disarm_callback (a_command: MEL_COMMAND; an_argument: ANY) is
			-- Set `a_command' to be executed when the button is released.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			command_not_void: a_command /= Void
		do
			set_callback (XmNdisarmCallback, a_command, an_argument);
		ensure
			command_set: command_set (disarm_command, a_command, an_argument)
		end;

feature -- Removal

	remove_activate_callback is
			-- Remove the command for the activate callback.
		do
			remove_callback (XmNactivateCallback)
		ensure
			removed: activate_command = Void
		end;

	remove_arm_callback is
			-- Remove the command for the arm callback.
		do
			remove_callback (XmNarmCallback)
		ensure
			removed: arm_command = Void
		end;

	remove_disarm_callback (a_command: MEL_COMMAND; an_argument: ANY) is
			-- Remove the command for the disarm callback.
		do
			remove_callback (XmNdisarmCallback)
		ensure
			removed: disarm_command = Void
		end;

feature {MEL_DISPATCHER} -- Basic operations

	create_callback_struct (a_callback_struct_ptr: POINTER;
					resource_name: POINTER): MEL_ARROW_BUTTON_CALLBACK_STRUCT is
			-- Create the callback structure specific to this widget
			-- according to `a_callback_struct_ptr'.
		do
			!! Result.make (Current, a_callback_struct_ptr)
		end;

feature {NONE} -- Implementation

	arrow_direction: INTEGER is
			-- Arrow direction 
		do
			Result := get_xt_unsigned_char (screen_object, XmNarrowDirection)
		end;

	xm_create_arrow_button (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER is
		external
			"C (Widget, String, ArgList, Cardinal): EIF_POINTER | <Xm/ArrowB.h>"
		alias
			"XmCreateArrowButton"
		end;

end -- class MEL_ARROW_BUTTON


--|----------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

