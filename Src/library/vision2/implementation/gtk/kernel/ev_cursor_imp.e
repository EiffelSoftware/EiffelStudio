indexing
	description:
		"EiffelVision cursor.Small picture whose location on the%
		% screen is controlled by a pointing device."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CURSOR_IMP

inherit
	EV_CURSOR_I

create
	make,
	make_by_code,
	make_by_pixmap,
	make_by_filename

feature {NONE} -- Initialization

	make is
			-- Create a cursor with the default appearance.
		do
			-- Set the cursor to the default pointer
			cursor := default_pointer
			destroyed := False
		end

	make_by_code (code: INTEGER) is
			-- Create a cursor with the appearance corresponding
			-- to `value'. See class EV_CURSOR_CODE fo the code.
		do
			cursor := gdk_cursor_new (code)
			destroyed := False
		end

	make_by_pixmap (pix: EV_PIXMAP) is
			-- Create a cursor with `pix' as appearance
		do
			check
				to_be_implemented: False
			end
			destroyed := False
		end

	make_by_filename (filename: STRING) is
			-- Create a cursor from the given file path
		do
			check
				to_be_implemented: False
			end
			destroyed := False
		end

feature -- Status report

	destroyed: BOOLEAN
			-- Is Current object destroyed?
feature -- Status setting

	destroy is
			-- Destroy actual object.
		do
			destroyed := True
			if cursor /= default_pointer then
				gdk_cursor_destroy (cursor)
			end
		end

feature -- Implementation

	cursor: POINTER
		-- Pointer to the initialised GdkCursor.

feature -- External

	gdk_cursor_new (code: INTEGER): POINTER is
		external
			"C (GdkCursorType): EIF_POINTER | <gdk/gdk.h>"
		end

	gdk_cursor_destroy (cursor_pointer: POINTER) is
		external
			"C (GdkCursor *) | <gdk/gdk.h>"
		end


end -- class EV_CURSOR_IMP

--!----------------------------------------------------------------
--! EiffelVision Library: Example for the ISE EiffelVision library.
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
--!----------------------------------------------------------------
