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

	add_activate_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with argument `an_argument'
			-- to the callbacks called when the button is pressed and released.
		require
			a_callback_not_void: a_callback /= Void
		do
			add_callback (XmNactivateCallback, a_callback, an_argument)
		end;

	add_arm_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with argument `an_argument'
			-- to the callbacks called when the button is pressed.
		require
			a_callback_not_void: a_callback /= Void
		do
			add_callback (XmNarmCallback, a_callback, an_argument)
		end;

	add_disarm_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with argument `an_argument'
			-- to the callbacks called when the button is released.
		require
			a_callback_not_void: a_callback /= Void
		do
			add_callback (XmNdisarmCallback, a_callback, an_argument)
		end;

feature -- Removal

	remove_activate_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with argument `an_argument'
			-- from the callbacks called when the button is pressed and released.
		require
			a_callback_not_void: a_callback /= Void
		do
			remove_callback (XmNactivateCallback, a_callback, an_argument)
		end;

	remove_arm_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with argument `an_argument'
			-- from the callbacks called when the button is pressed.
		require
			a_callback_not_void: a_callback /= Void
		do
			remove_callback (XmNarmCallback, a_callback, an_argument)
		end;

	remove_disarm_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with argument `an_argument'
			-- from the callbacks called when the button is released.
		require
			a_callback_not_void: a_callback /= Void
		do
			remove_callback (XmNdisarmCallback, a_callback, an_argument)
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
			"C [macro <Xm/ArrowB.h>] (Widget, String, ArgList, Cardinal): EIF_POINTER"
		alias
			"XmCreateArrowButton"
		end;

end -- class MEL_ARROW_BUTTON

--|-----------------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1996, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-----------------------------------------------------------------------
