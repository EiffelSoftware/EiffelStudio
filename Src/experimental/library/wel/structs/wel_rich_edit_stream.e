note
	description: "Defines the general notions of a stream for the rich %
		%edit control."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEL_RICH_EDIT_STREAM

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		end

feature {NONE} -- Initialization

	make
			-- Make the structure
		do
			structure_make
			record_current_in_cookie
			set_error (0)
		end

feature -- Access

	is_unicode_data: BOOLEAN
			-- Is current stream Unicode based?

	error: INTEGER
			-- Error encountered while streaming. If there was no
			-- error, the value is zero.
		do
			Result := cwel_editstream_get_dwerror (item)
		end

	stream_result: INTEGER
			-- Result of the last stream operation. Must be zero if
			-- the read or write operation was successful.

feature -- Element change

	set_error (an_error: INTEGER)
			-- Set `error' with `an_error'.
		do
			cwel_editstream_set_dwerror (item, an_error)
		ensure
			error_set: error = an_error
		end

feature {NONE} -- Element change

	set_is_unicode_data (v: like is_unicode_data)
			-- Set `is_unicode_data' with `v'.
			-- It is not exported here because some descendants
			-- cannot handle a switch of mode once created.
		do
			is_unicode_data := v
		ensure
			is_unicode_data_set: is_unicode_data = v
		end

feature -- Basic operations

	init_action
			-- Called before the streams.
			-- May be redefined to make special operations.
		do
		end

	finish_action
			-- Called after the streams.
			-- May be redefined to make special operations.
		do
		end

	release_stream
			-- In order to avoid a memory leak when using a WEL_RICH_EDIT_STREAM
			-- descendant, this need to be called.
		do
			free_current_from_cookie
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_editstream
		end

feature {NONE} -- Cookie access and settings

	record_current_in_cookie
			-- Record protected reference on Current object in `cookie'
		require
			valid_cookie: cookie = default_pointer
		local
			ptr: POINTER
		do
			ptr := c_protect_cookie ($Current)
			set_cookie (ptr)
		ensure
			cookie_set: cookie /= default_pointer
		end

	free_current_from_cookie
			-- Free protected reference on Current
		require
			valid_cookie: cookie /= default_pointer
		do
			c_free_cookie (cookie)
			set_cookie (default_pointer)
		ensure
			cookie_set: cookie = default_pointer
		end

	cookie: POINTER
			-- Current protected object passed to callback function.
		do
			Result := cwel_editstream_get_dwcookie (item)
		end

	set_cookie (a_cookie: POINTER)
			-- Set `cookie' with `a_cookie'.
			--| Contains Current, so the C callback function knows
			--| which object to call.
		do
			cwel_editstream_set_dwcookie (item, a_cookie)
		ensure
			cookie_set: cookie = a_cookie
		end

	c_protect_cookie (a: POINTER): POINTER
			-- Protect `a'.
		external
			"C [macro %"estream.h%"] (EIF_REFERENCE): EIF_POINTER"
		alias
			"eif_protect"
		end

	c_free_cookie (ptr: POINTER)
			-- Remove protection on `ptr'.
		external
			"C [macro %"estream.h%"] (EIF_OBJECT)"
		alias
			"eif_wean"
		end

feature {NONE} -- Externals

	c_size_of_editstream: INTEGER
		external
			"C [macro %"estream.h%"]"
		alias
			"sizeof (EDITSTREAM)"
		end

	cwel_editstream_set_dwcookie (ptr: POINTER; value: POINTER)
		external
			"C [macro %"estream.h%"]"
		end

	cwel_editstream_set_dwerror (ptr: POINTER; value: INTEGER)
		external
			"C [macro %"estream.h%"]"
		end

	cwel_editstream_get_dwcookie (ptr: POINTER): POINTER
		external
			"C [macro %"estream.h%"]"
		end

	cwel_editstream_get_dwerror (ptr: POINTER): INTEGER
		external
			"C [macro %"estream.h%"]"
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
