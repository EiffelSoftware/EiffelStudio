indexing
	description: "EiffelVision pixmap. Implementation interface."
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

	EV_PIXMAP_ACTION_SEQUENCES_I

feature -- Initialization

	read_from_named_file (file_name: STRING) is
			-- Load pixmap data from the file named `file_name'.
			-- Exceptions: "Unable to retrieve icon information"
		require
			file_name_not_void: file_name /= Void
			file_name_not_empty: not file_name.is_empty
		deferred
		end

	set_with_default is
			-- Initialize the pixmap with the default
			-- pixmap (Vision2 logo)
			--
			-- Exceptions "Unable to retrieve icon information"
		deferred
		end

	set_size (a_x, a_y: INTEGER) is
			-- Set the size of the pixmap to `a_x' by `a_y' pixels.
		require
			x_coordinate_valid: a_x > 0
			y_coordinate_valid: a_y > 0
		deferred	
		end

	stretch (a_x, a_y: INTEGER) is
			-- Stretch the image to fit in size `a_x' by `a_y' pixels.
		require
			x_coordinate_valid: a_x > 0
			y_coordinate_valid: a_y > 0
		deferred
		end

	save_to_named_file (a_format: EV_GRAPHICAL_FORMAT; a_filename: FILE_NAME) is
			-- Save `Current' to `a_filename' in `a_format' format.
		require
			a_format_not_void: a_format /= Void
			a_filename_not_void: a_filename /= Void
			a_filename_valid: a_filename.is_valid
		do
			a_format.save (raw_image_data, a_filename)
		end

feature -- Access

	raw_image_data: EV_RAW_IMAGE_DATA is
			-- RGBA representation of `Current'.
		deferred
		end

feature -- Basic operations

	flush is
			-- Execute any delayed calls to `expose_actions' without waiting
			-- for next idle.
		do
		end

feature -- Duplication

	copy_pixmap(other: EV_PIXMAP) is
			-- Update `Current' to have same appearence as `other'.
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
--| Revision 1.23  2001/06/29 22:39:48  king
--| Added necessary but useless precondition
--|
--| Revision 1.22  2001/06/07 23:08:11  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.10.4.8  2000/11/29 00:34:40  rogers
--| Changed empty to is_empty.
--|
--| Revision 1.10.4.7  2000/10/12 15:37:54  pichery
--| Removed `set_with_buffer' and `read_from_file'
--|
--| Revision 1.10.4.6  2000/10/03 17:29:10  rogers
--| Commented raw_image_data.
--|
--| Revision 1.10.4.5  2000/10/03 00:40:56  king
--| Added save_to_named_file and raw_image_data
--|
--| Revision 1.10.4.4  2000/08/18 16:23:32  rogers
--| Removed fixme not_reviewed. Comments, formatting.
--|
--| Revision 1.10.4.3  2000/07/25 01:13:44  oconnor
--| added EV_PIXMAP_ACTION_SEQUENCES_I
--|
--| Revision 1.10.4.2  2000/06/26 23:24:10  pichery
--| added `flush' feature
--|
--| Revision 1.10.4.1  2000/05/03 19:09:09  oconnor
--| mergred from HEAD
--|
--| Revision 1.21  2000/05/03 04:33:10  pichery
--| Changed feature `set_with_default'
--|
--| Revision 1.20  2000/05/03 00:30:19  pichery
--| Added default window icon pixmap
--|
--| Revision 1.19  2000/04/28 16:31:58  pichery
--| Added feature `set_with_default' To load a default
--| pixmap.
--|
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
