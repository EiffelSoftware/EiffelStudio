indexing

	description: "EiffelVision pixmap, implementation interface"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PIXMAP_I 

inherit
	EV_DRAWABLE_I

feature {NONE} -- Initialization

	make_with_size (w, h: INTEGER) is
			-- Create a pixmap with 'par' as parent, 
			-- 'w' and `h' as size.
		require
			valid_width: w > 0
			valid_height: h > 0
		deferred
		end	

feature -- Status report

	is_locked: BOOLEAN
			-- Is the pixmap already set in a drawing area?
			-- If so, we can not set it to other pixmapable
			-- widgets.

feature -- Status setting

	lock is
			-- Lock the pixmap.
		do
			is_locked := True
		end

	unlock is
			-- Unlock the pixmap.
		do
			is_locked := False
		end

feature -- Measurement

	width: INTEGER is
			-- width of the pixmap
		require
			exists: not destroyed
		deferred
		ensure
			positive_result: Result > 0
		end

	height: INTEGER is
			-- height of the pixmap
		require
			exists: not destroyed
		deferred
		ensure
			positive_result: Result > 0
		end

feature -- Basic operation

	read_from_file (file_name: STRING) is
			-- Load the pixmap described in 'file_name'. 
			-- If the file does not exist or it is in a 
			-- wrong format, an exception is raised.
		require
			file_name_exists: file_name /= Void
		deferred
		end	
	
end -- class EV_PIXMAP_I

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

