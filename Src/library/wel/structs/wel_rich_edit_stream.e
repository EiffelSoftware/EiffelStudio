indexing
	description: "Defines the general notions of a stream for the rich %
		%edit control."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEL_RICH_EDIT_STREAM

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		redefine
			destroy_item
		end

feature {NONE} -- Initialization

	make is
			-- Make the structure
		do
			structure_make
			record_current_in_cookie
			set_error (0)
		end

feature -- Access

	error: INTEGER is
			-- Error encountered while streaming. If there was no
			-- error, the value is zero.
		do
			Result := cwel_editstream_get_dwerror (item)
		end

	stream_result: INTEGER
			-- Result of the last stream operation. Must be zero if
			-- the read or write operation was successful.

feature -- Element change

	set_error (an_error: INTEGER) is
			-- Set `error' with `an_error'.
		do
			cwel_editstream_set_dwerror (item, an_error)
		ensure
			error_set: error = an_error
		end

feature -- Basic operations

	init_action is
			-- Called before the streams.
			-- May be redefined to make special operations.
		do
		end

	finish_action is
			-- Called after the streams.
			-- May be redefined to make special operations.
		do
		end

	release_stream is
			-- In order to avoid a memory leak when using a WEL_RICH_EDIT_STREAM
			-- descendant, this need to be called.
		do
			free_current_from_cookie
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_editstream
		end

feature {NONE} -- Cookie access and settings

	record_current_in_cookie is
			-- Record protected reference on Current object in `cookie'
		require
			valid_cookie: cookie = default_pointer
		local
			ptr: POINTER
		do
			ptr := c_protect_cookie (Current)
			set_cookie (ptr)
		ensure
			cookie_set: cookie /= default_pointer
		end

	free_current_from_cookie is
			-- Free protected reference on Current
		require
			valid_cookie: cookie /= default_pointer
		local
			a: ANY
		do
			a := c_free_cookie (cookie)
			set_cookie (default_pointer)
		ensure
			cookie_set: cookie = default_pointer
		end

	cookie: POINTER is
			-- Current protected object passed to callback function.
		do
			Result := cwel_integer_to_pointer (cwel_editstream_get_dwcookie (item))
		end

	set_cookie (a_cookie: POINTER) is
			-- Set `cookie' with `a_cookie'.
			--| Contains Current, so the C callback function knows
			--| which object to call.
		do
			cwel_editstream_set_dwcookie (item, cwel_pointer_to_integer (a_cookie))
		ensure
			cookie_set: cookie = a_cookie
		end

	c_protect_cookie (a: ANY): POINTER is
			-- Protect `a'.
		external
			"C [macro %"estream.h%"] (EIF_REFERENCE): EIF_OBJECT"
		alias
			"eif_adopt"
		end

	c_free_cookie (ptr: POINTER): ANY is
			-- Remove protection on `ptr'.
		external
			"C [macro %"estream.h%"] (EIF_OBJECT): EIF_REFERENCE"
		alias
			"eif_wean"
		end

feature {NONE} -- Removal

	destroy_item is
			-- Free `item'.
		do
--			c_free (item)
			item := default_pointer
		end

feature {NONE} -- Externals

	c_size_of_editstream: INTEGER is
		external
			"C [macro %"estream.h%"]"
		alias
			"sizeof (EDITSTREAM)"
		end

	cwel_editstream_set_dwcookie (ptr: POINTER; value: INTEGER) is
		external
			"C [macro %"estream.h%"]"
		end

	cwel_editstream_set_dwerror (ptr: POINTER; value: INTEGER) is
		external
			"C [macro %"estream.h%"]"
		end

	cwel_editstream_get_dwcookie (ptr: POINTER): INTEGER is
		external
			"C [macro %"estream.h%"]"
		end

	cwel_editstream_get_dwerror (ptr: POINTER): INTEGER is
		external
			"C [macro %"estream.h%"]"
		end

end -- class WEL_RICH_EDIT_STREAM


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

