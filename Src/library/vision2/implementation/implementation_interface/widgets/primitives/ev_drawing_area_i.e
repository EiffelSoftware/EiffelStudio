indexing
	description: "EiffelVision drawing area. Implementation interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_DRAWING_AREA_I

inherit
	EV_DRAWABLE_I

	EV_PRIMITIVE_I
		redefine
			set_default_options
		end

	EV_PIXMAPABLE_I
		redefine
			pixmap_drawable_ok
		end

feature -- Status setting

	set_default_options is
			-- Initialize the options of the widget.
		do
			set_expand (True)
			set_vertical_resize (False)
			set_horizontal_resize (False)
		end

feature -- Event - command association

	add_resize_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of action to be executed when
			-- current area is resized.
			-- `arg' will be passed to `cmd' whenever it is
			-- invoked as a callback.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		deferred
		end

	add_paint_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the widget has to be redrawn.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		deferred
		end

feature -- Event - command removal

	remove_resize_commands is
			-- Remove the list of commands to be executed when
			-- current area is resized.
		require
			exists: not destroyed
		deferred
		end

	remove_paint_commands is
			-- Empty the list of commands to be executed when
			-- the widget has to be redrawn.
		require
			exists: not destroyed
		deferred
		end

feature -- Assertion feature

	pixmap_drawable_ok (pix: EV_PIXMAP): BOOLEAN is
			-- Check if the size of the pixmap is ok for
			-- the container.
		do
			Result := pix.is_drawable
		end

end -- class EV_DRAWING_AREA_I

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
