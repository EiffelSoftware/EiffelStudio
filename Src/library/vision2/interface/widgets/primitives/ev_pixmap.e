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
			make_for_test,
			create_implementation,
			implementation,
			is_equal,
			copy
		end

create
	default_create,
	make_with_size,
	make_for_test

feature {NONE} -- Initialization

	make_with_size (a_width, a_height: INTEGER) is
			-- Create with `a_width' and `a_height'.
		require
			a_width_positive: a_width > 0
			a_height_positive: a_height > 0
		do
			default_create
			set_size (a_width, a_height)
		ensure then
			width_assigned: width = a_width
			height_assigned: height = a_height
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Does `other' have the same appearance as `Current'.
			--| FIXME this should be more exact :-) - sam
		do
			if other /= Void then
				Result := (
					width = other.width and
					height = other.height
				)
			end
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
			-- Attempt to load pixmap data from data-medium `a_file'.
			-- May raise `Ev_unknow_image_format' or `Ev_courpt_image_data'
			-- exceptions. --FIXME do this!
		require
			medium_data_readable: a_file.is_open_read
			medium_data_is_binary: not a_file.is_plain_text
		do
			implementation.read_from_file (a_file)
		end

	set_with_named_file (file_name: STRING) is
			-- Attempt to load pixmap data from a file specified by `file_name'.
			-- May raise `Ev_unknow_image_format' or `Ev_courpt_image_data'
			-- exceptions. --FIXME do this!
		require
			file_name_not_void: file_name /= Void
			file_name_not_empty: not file_name.empty
		local
			file: RAW_FILE
		do
			create file.make_open_read (file_name)
			set_with_file (file)
			file.close
		end

	set_size (a_width, a_height: INTEGER) is
			-- Assign `a_width' and `a_height' to `width' and `weight'.
			-- Do not stretch image.
			-- May cause cropping.
		require
			a_width_positive: a_width > 0
			a_height_positive: a_height > 0
		do
			implementation.set_size (a_width, a_height)	
		ensure
			width_assigned: width = a_width
			height_assigned: height = a_height
		end

	stretch (a_width, a_height: INTEGER) is
			-- Assign `a_width' and `a_height' to `width' and `weight'.
			-- Stretch the image to new size.
		require
			a_width_positive: a_width > 0
			a_height_positive: a_height > 0
		do
			implementation.stretch (a_width, a_height)
		ensure
			width_assigned: width = a_width
			height_assigned: height = a_height
		end

feature -- Duplication

	copy (other: like Current) is
			-- Update `Current' to have same appearence as `other'.
			-- (So as to satisfy `is_equal'.)
		do
			set_size (other.width, other.height)
			draw_pixmap (0, 0, other)
		end

feature {NONE} -- Implementation

	create_implementation is
			-- Create implementation of pixmap with default size.
		do
			create {EV_PIXMAP_IMP} implementation.make (Current)
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_PIXMAP_I
			-- Responsible for interaction with the underlying native graphics
			-- toolkit.

feature {NONE} -- Contract support

	make_for_test is
			-- Create with sample image.
		do
			default_create
			set_with_named_file ("test_pixmap")
		end

end -- class EV_PIXMAP

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
--| Revision 1.24  2000/03/03 02:56:54  oconnor
--| added make_for_test
--|
--| Revision 1.23  2000/03/03 01:44:30  oconnor
--| fixed call on void problem in is_equal
--|
--| Revision 1.22  2000/03/01 22:45:32  brendel
--| a_width -> a_height
--|
--| Revision 1.21  2000/03/01 22:33:34  oconnor
--| added copy and is_equal, added postconditions to set_size and stretch
--|
--| Revision 1.20  2000/03/01 20:28:53  king
--| Corrected export clauses for implementation and create_imp/act_seq
--|
--| Revision 1.19  2000/03/01 03:12:18  oconnor
--| added create make_for_test
--|
--| Revision 1.18  2000/02/22 18:39:52  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.17  2000/02/18 17:48:50  king
--| Corrected previous changes
--|
--| Revision 1.16  2000/02/18 03:20:36  oconnor
--| added set_with_named_file
--|
--| Revision 1.15  2000/02/16 20:16:15  pichery
--| - implemented set_size for EV_PIXMAP under windows.
--|
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
