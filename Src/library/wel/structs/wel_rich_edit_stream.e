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
			set_cookie (cwel_pointer_to_integer (ceif_adopt (Current)))
			set_error (0)
		end

feature -- Access

	cookie: INTEGER is
			-- Application-defined value that is passed to the
			-- callback function.
			--| Contains Current, so the C callback function knows
			--| which object to call.
		do
			Result := cwel_editstream_get_dwcookie (item)
		end

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

	set_cookie (a_cookie: INTEGER) is
			-- Set `cookie' with `a_cookie'.
			--| Contains Current, so the C callback function knows
			--| which object to call.
		do
			cwel_editstream_set_dwcookie (item, a_cookie)
		ensure
			cookie_set: cookie = a_cookie
		end

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
			print ("init_stream%N")
		end

	finish_action is
			-- Called after the streams.
			-- May be redefined to make special operations.
		do
			print ("finish_stream%N")

		end

	release_stream is
			-- In order to avoid a memory leak when using a WEL_RICH_EDIT_STREAM
			-- descendant, this need to be called.
		do
			-- cwel_release_editstream_object
			ceif_wean (cookie)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_editstream
		end

feature {NONE} -- Removal

	destroy_item is
			-- Free `item'.
		do
			c_free (item)
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

	ceif_adopt (object: ANY): POINTER is
			-- Eiffel macro to adopt an object
		external
			"C [macro <eif_eiffel.h>] (EIF_OBJ): EIF_POINTER"
		alias
			"eif_adopt"
		end

	ceif_wean (object: ANY) is
			-- Eiffel macro to wean an object
		external
			"C [macro <eif_eiffel.h>] (EIF_OBJ)"
		alias
			"eif_wean"
		end

end -- class WEL_RICH_EDIT_STREAM

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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

