indexing
	description: "Defines the general notions of a stream for the rich %
		%edit control."
	note: "Do not use more than one instance of this class at the same %
		%time. Nested streams are not supported."
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
			set_cookie (0)
			set_error (0)
			cwel_editstream_set_pfncallback (item)
		end

feature -- Access

	cookie: INTEGER is
			-- Application-defined value that is passed to the
			-- callback function.
			--| Useless in Eiffel.
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
			--| Useless in Eiffel.
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
			cwel_release_editstream_object
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_editstream
		end

feature {NONE} -- Implementation

	internal_callback (a_buffer: POINTER; a_length: INTEGER): INTEGER is
			-- The control calls this callback function repeatedly,
			-- transferring a portion of the data with each call.
		require
			buffer_not_null: a_buffer /= default_pointer
			positive_length: a_length >= 0
		deferred
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

	cwel_editstream_set_pfncallback (ptr: POINTER) is
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

	cwel_set_editstream_procedure_address (address: POINTER) is
		external
			"C [macro %"estream.h%"]"
		end

	cwel_set_editstream_object (object: like Current) is
		external
			"C [macro %"estream.h%"]"
		end

	cwel_release_editstream_object is
		external
			"C [macro %"estream.h%"]"
		end

	cwel_set_editstream_buffer (value: POINTER) is
		external
			"C [macro %"estream.h%"]"
		end

	cwel_set_editstream_buffer_size (value: INTEGER) is
		external
			"C [macro %"estream.h%"]"
		end

	cwel_set_editstream_in (value: BOOLEAN) is
		external
			"C [macro %"estream.h%"]"
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

