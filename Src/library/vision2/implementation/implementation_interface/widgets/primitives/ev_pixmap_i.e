--| FIXME NOT_REVIEWED this file has not been reviewed
indexing

	description: "EiffelVision pixmap, implementation interface"
	status: "See notice at end of class"
	keywords: "drawable, primitives, figures, buffer, bitmap, picture"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PIXMAP_I 

inherit
	EV_DRAWABLE_I
		redefine
			interface
		end

	EV_PRIMITIVE_I
		redefine
			interface
		end

feature -- Initialization

	read_from_file (a_file: IO_MEDIUM) is
			-- Load pixmap data from data-medium `a_file'.
		require
			medium_data_readable: a_file.is_open_read
			medium_data_is_binary: not a_file.is_plain_text
		deferred
		end

	read_from_named_file (file_name: STRING) is
			-- Load pixmap data from the file named `file_name'.
			--
			-- Exceptions: "Unable to retrieve icon information"
		require
			file_name_not_void: file_name /= Void
			file_name_not_empty: not file_name.empty
		deferred
		end

	set_with_buffer (a_buffer: STRING) is
			-- Load pixmap data from `a_buffer' in memory.
		require
			buffer_data_not_void: a_buffer /= Void
			buffer_contains_data: a_buffer.count > 0
		deferred
		end

	set_size (a_x, a_y: INTEGER) is
			-- Set the size of the pixmap to `a_x' by `a_y'.
		require
			x_coordinate_valid: a_x > 0
			y_coordinate_valid: a_y > 0
		deferred	
		end

	stretch (a_x, a_y: INTEGER) is
			-- Stretch the image to fit in size `a_x' by `a_y'.
		require
			x_coordinate_valid: a_x > 0
			y_coordinate_valid: a_y > 0
		deferred
		end

feature  -- Duplication

	copy_pixmap(other: EV_PIXMAP) is
		deferred
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_PIXMAP

end -- class EV_PIXMAP_I

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--| Revision 1.18  2000/04/14 20:56:45  brendel
--| Removed on_parented since it is now in EV_WIDGET_I.
--|
--| Revision 1.17  2000/04/12 02:16:29  oconnor
--| made on_parent concrete
--|
--| Revision 1.16  2000/04/12 01:26:45  pichery
--| - removed synonym `stretch_image' for `stretch'
--| - added on_parented (only used on Windows)
--|
--| Revision 1.15  2000/04/12 00:07:30  king
--| Now inheriting from drawable and primitive
--|
--| Revision 1.14  2000/03/20 23:42:59  pichery
--| Moved implementation of `read_from_named_file' from interface to
--| implementation cluster.
--|
--| Revision 1.13  2000/03/07 01:16:15  brendel
--| Cosmetics.
--|
--| Revision 1.12  2000/02/22 18:39:45  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.11  2000/02/14 11:40:39  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.10.6.8  2000/02/04 04:10:28  oconnor
--| released
--|
--| Revision 1.10.6.7  2000/01/27 19:30:06  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.10.6.6  2000/01/14 04:07:03  oconnor
--| added comments
--|
--| Revision 1.10.6.5  1999/12/18 02:23:37  king
--| Implemented new features in implementation interface
--|
--| Revision 1.10.6.4  1999/12/09 23:22:35  brendel
--| Commented out features that were obsolete and inapplicable.
--|
--| Revision 1.10.6.3  1999/12/09 03:15:07  oconnor
--| commented out make_with_* features, these should be in interface only
--|
--| Revision 1.10.6.2  1999/11/30 22:45:13  oconnor
--| redefine interface to be of more refined type
--|
--| Revision 1.10.6.1  1999/11/24 17:30:15  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.10.2.3  1999/11/04 23:10:46  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.10.2.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
