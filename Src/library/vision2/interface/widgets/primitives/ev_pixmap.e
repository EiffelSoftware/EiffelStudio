indexing
	description:
		"Eiffel Vision pixmap. Pixel image that can be modified and displayed."
	status: "See notice at end of class"
	keywords: "drawable, primitives, figures, buffer, bitmap, picture"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PIXMAP

inherit
	EV_DRAWING_AREA
		redefine
			create_implementation,
			implementation
		end

create
	default_create, make_with_size

feature {NONE} -- Initialization

	make_with_size (a_x, a_y: INTEGER) is
			-- Create a pixmap of size `a_x' by `a_y'.
		require
			x_coordinate_valid: a_x > 0
			y_coordinate_valid: a_y > 0
		do
			default_create
			implementation.set_size (a_x, a_y)
		end

feature -- Status setting

	set_with_buffer (a_buffer: STRING) is
			-- Load pixmap data from `a_buffer' in memory.
			-- May raise `Ev_unknow_image_format' or `Ev_courpt_image_data'
			-- exceptions. --FIXME do this!
		require
			buffer_data_not_void: a_buffer /= Void
			buffer_not_empty: a_buffer.count > 0
		do
			implementation.set_with_buffer (a_buffer)
		end

	set_with_file (a_file: IO_MEDIUM) is
			-- Load pixmap data from data-medium `a_file'.
			-- May raise `Ev_unknow_image_format' or `Ev_courpt_image_data'
			-- exceptions. --FIXME do this!
		require
			medium_data_readable: a_file.is_open_read
			medium_data_is_binary: not a_file.is_plain_text
		do
			implementation.read_from_file (a_file)
		end

	set_size (a_x, a_y: INTEGER) is
			-- Set the size of the canvas to `a_x' by `a_y'.
			-- Image will remain the same dimension.
		require
			x_coordinate_valid: a_x > 0
			y_coordinate_valid: a_y > 0
		do
			implementation.set_size (a_x, a_y)	
		end

	stretch (a_x, a_y: INTEGER) is
			-- Stretch the image to fit in size `a_x' by `a_y'.
		require
			x_coordinate_valid: a_x > 0
			y_coordinate_valid: a_y > 0
		do
			implementation.stretch (a_x, a_y)
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_PIXMAP_I
			-- Responsible for interaction with the underlying native graphics
			-- toolkit.

	create_implementation is
			-- Create implementation of pixmap with default size.
		do
			create {EV_PIXMAP_IMP} implementation.make (Current)
		end

end -- class EV_PIXMAP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.14  2000/02/14 11:40:53  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.13.6.10  2000/01/28 20:00:22  oconnor
--| released
--|
--| Revision 1.13.6.9  2000/01/27 19:30:58  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.13.6.8  2000/01/14 04:05:11  oconnor
--| tweaked comments
--|
--| Revision 1.13.6.7  1999/12/22 20:02:38  king
--| Changed make_with_size to use set_size instead of stretch
--|
--| Revision 1.13.6.6  1999/12/18 02:25:02  king
--| Removed clutter from interface, added new features stretch and
--| make_with_buffer
--|
--| Revision 1.13.6.5  1999/12/15 23:51:27  oconnor
--| formatting
--|
--| Revision 1.13.6.4  1999/12/15 23:43:45  oconnor
--| added FIXME comments
--|
--| Revision 1.13.6.3  1999/12/09 23:12:59  brendel
--| Commented out features that are inapplicable and obsolete.
--|
--| Revision 1.13.6.2  1999/12/04 22:47:26  brendel
--| Removed redefine of create_action_sequence.
--|
--| Revision 1.13.6.1  1999/11/24 17:30:57  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.13.2.4  1999/11/04 23:10:55  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.13.2.3  1999/11/02 17:20:13  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
