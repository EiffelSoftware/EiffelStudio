indexing
	description: "EiffelVision drawing area. A drawing area%
			% is a primitive on which the user can draw%
			% pixmaps or his own figures."
	note: "A drawing area as a (0, 0) minimum_size by default%
			% and a (10, 10) size. A non nul size because then,%
			% the user doesn't wonder why nothing appear."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_DRAWING_AREA

inherit
	EV_DRAWABLE
		undefine
			background_color,
			foreground_color,
			set_background_color,
			set_foreground_color
		redefine
			implementation
		end

	EV_PRIMITIVE
		redefine
			implementation
		end

	EV_PIXMAPABLE
		redefine
			implementation
		end

creation
	make,
	make_with_pixmap

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create an empty drawing area.
		do
			!EV_DRAWING_AREA_IMP! implementation.make
			widget_make (par)
		end

	make_with_pixmap (par: EV_CONTAINER; pix: EV_PIXMAP) is
			-- Create a drawing area with a pixmap attached to
			-- it.
		do
			!EV_DRAWING_AREA_IMP! implementation.make
			widget_make (par)
			set_pixmap (pix)
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
		do
			implementation.add_resize_command (cmd, arg)
		end

feature -- Event - command removal

	remove_resize_commands is
			-- Remove the list of commands to be executed when
			-- current area is resized.
		require
			exists: not destroyed
		do
			implementation.remove_resize_commands
		end

feature -- Implementation

	implementation: EV_DRAWING_AREA_IMP

end -- class EV_DRAWING_AREA

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
