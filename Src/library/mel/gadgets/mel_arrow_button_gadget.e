indexing

	description: 
		"Motif Arrow Button Gadget.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_ARROW_BUTTON_GADGET

inherit

	MEL_ARROW_BUTTON_GADGET_RESOURCES
		export
			{NONE} all
		end;

	MEL_GADGET
		redefine
			create_callback_struct
		end

creation 
	make,
	make_from_existing

feature -- Initialization

	make (a_name: STRING; a_parent: MEL_COMPOSITE; do_manage: BOOLEAN) is
			-- Create a motif arrow button gadget.
		require
			name_exists: a_name /= Void;
			parent_exists: a_parent /= Void and then not a_parent.is_destroyed
		local
			widget_name: ANY
		do
			parent := a_parent;	
			widget_name := a_name.to_c;
			screen_object := 
				xm_create_arrow_button_gadget 
					(a_parent.screen_object, $widget_name, default_pointer, 0);
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
			-- Is the arrow direction up?
		require
			exists: not is_destroyed
		do
			Result := XmARROW_UP = get_xt_unsigned_char (screen_object, XmNarrowDirection)
		end;

	is_down: BOOLEAN is
			-- Is the arrow direction down?
		require
			exists: not is_destroyed
		do
			Result := XmARROW_DOWN = get_xt_unsigned_char (screen_object, XmNarrowDirection)
		end;

	is_left: BOOLEAN is
			-- Is the arrow direction left?
		require
			exists: not is_destroyed
		do
			Result := XmARROW_LEFT = get_xt_unsigned_char (screen_object, XmNarrowDirection)
		end;

	is_right: BOOLEAN is
			-- Is the arrow direction right?
		require
			exists: not is_destroyed
		do
			Result := XmARROW_RIGHT = get_xt_unsigned_char (screen_object, XmNarrowDirection)
		end;

	is_multiclick_keep: BOOLEAN is
			-- Is the successive button clicks processed?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNmultiClick) = XmMULTICLICK_KEEP
		end;

feature -- Status setting

	set_up is
			-- Set the arrow direction to up.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNarrowDirection, XmARROW_UP)
		ensure
			is_up: is_up	
		end;

	set_down is
			-- Set the arrow direction to down.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNarrowDirection, XmARROW_DOWN)
		ensure
			is_down: is_down	
		end;

	set_left is
			-- Set the arrow direction to left.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNarrowDirection, XmARROW_LEFT)
		ensure
			is_left: is_left	
		end;

	set_right is
			-- Set the arrow direction to right.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNarrowDirection, XmARROW_RIGHT)
		ensure
			is_right: is_right	
		end;

	set_multiclick_keep is
			-- Set the XmNmultiClick resource to XmMULTICLICK_KEEP.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNmultiClick, XmMULTICLICK_KEEP)
		ensure
			is_multiclick_keep: is_multiclick_keep
		end;

	set_multiclick_discard is
			-- Set the XmNmultiClick resource to XmMULTICLICK_DISCARD.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNmultiClick, XmMULTICLICK_DISCARD)
		ensure
			not_multiclick_keep: not is_multiclick_keep
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

	remove_disarm_callback is
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
			-- according to the `a_callback_struct_ptr' pointer.
		do
			!! Result.make (Current, a_callback_struct_ptr)
		end;

feature {NONE} -- Implementation

	xm_create_arrow_button_gadget (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER is
		external
			"C (Widget, String, ArgList, Cardinal): EIF_POINTER | <Xm/ArrowBG.h> "
		alias
			"XmCreateArrowButtonGadget"
		end;

end -- class MEL_ARROW_BUTTON_GADGET


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

