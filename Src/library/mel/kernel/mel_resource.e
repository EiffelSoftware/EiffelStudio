indexing

	description: 
		"A MEL resource that has been allocated a `display'.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_RESOURCE

inherit

	ANY
		redefine
			is_equal
		end

feature {NONE} -- Initialization

	make_from_existing (a_display: MEL_DISPLAY; a_handle: POINTER) is
			-- Create a MEL resource from an `a_handle'
			-- for display `a_display'.
		require
			valid_display: a_display /= Void and then a_display.is_valid;
			handle_not_null: a_handle /= default_pointer
		do
			handle := a_handle;
			display_handle := a_display.handle
		ensure
			set: handle = a_handle;
			has_valid_display: has_valid_display
		end;

	make_from_existing_handle (a_handle: POINTER) is
			-- Create a MEL resource from an `a_handle'.
		require
			a_handle_not_null: a_handle /= default_pointer
		do
			handle := a_handle;
		ensure
			set: handle = a_handle;
		end;

feature -- Access

	handle: POINTER;
			-- handle to C resource

	display_handle: POINTER;
			-- Display C handle on which resource is allocated

	display: MEL_DISPLAY is
			-- Mel display on which resource was allocated
		do
			if display_handle /= default_pointer then
				!! Result.make_from_existing (display_handle)
			end
		end;

	is_valid: BOOLEAN is
			-- Is the resource valid?
		do
			Result := handle /= default_pointer
		ensure
			valid_result: Result = not is_destroyed
		end;

	is_destroyed: BOOLEAN is
			-- Is the resource destroyed?
		do
			Result := not is_valid
		ensure
			valid_result: Result = not is_valid
		end;

	has_valid_display: BOOLEAN is
			-- Has the `display' been set?
		do
			Result := display_handle /= default_pointer
		ensure
			valid_result: Result implies display_handle /= default_pointer
		end;

	same_display (other_display: MEL_DISPLAY): BOOLEAN is
			-- Is `display' same as `other_display'?
		require
			valid_other_display: other_display /= Void and then other_display.is_valid
		do
			Result := display_handle = other_display.handle
		end;

feature -- Status setting

	set_display (a_display: MEL_DISPLAY) is
			-- Set `display' to `a_display'
		require
			not_valid_display: not has_valid_display
			valid_display: a_display /= Void and then a_display.is_valid
		do
			display_handle := a_display.handle
		ensure
			valid_display: has_valid_display;
			set: equal (display, a_display)
		end;

feature -- Comparison

	is_equal (other:like Current): BOOLEAN is
			-- Is Current `handle' equal to `other' handle?
		do
			Result := handle = other.handle
		end;

end -- class MEL_RESOURCE

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
