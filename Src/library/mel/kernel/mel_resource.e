indexing

	description: 
		"Abstract class for Motif resources that has been allocated %
		%for a `display'. All descendants sets `is_shared' to True at %
		%creation. This means that the user must call `destroy' or %
		%`set_unshared' and not reference it to free the resource."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	MEL_RESOURCE

inherit

	MEL_MEMORY
		rename
			make_from_existing as make_from_existing_handle
		redefine
			make_from_existing_handle
		end;

feature {NONE} -- Initialization

	make_from_existing (a_display: MEL_DISPLAY; a_handle: POINTER) is
			-- Create a MEL resource from an `a_handle'
			-- for display `a_display'.
		require
			valid_display: a_display /= Void and then a_display.is_valid;
			handle_not_null: a_handle /= default_pointer
		do
			handle := a_handle;
			display_handle := a_display.handle;
			is_shared := True;
		ensure
			set: handle = a_handle;
			has_valid_display: has_valid_display;
			is_shared: is_shared
		end;

    make_from_existing_handle (a_handle: POINTER) is
            -- Initialize `a_handle' to `handle;.
        do
            handle := a_handle;
			is_shared := True
        ensure then
            set: handle = a_handle;
			is_shared: is_shared
        end;

feature -- Access

	display_handle: POINTER;
			-- Display C handle on which resource is allocated

	display: MEL_DISPLAY is
			-- Mel display on which resource was allocated
		do
			if display_handle /= default_pointer then
				create Result.make_from_existing (display_handle)
			end
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class MEL_RESOURCE


