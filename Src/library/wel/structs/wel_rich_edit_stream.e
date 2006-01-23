indexing
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
			ptr := c_protect_cookie ($Current)
			set_cookie (ptr)
		ensure
			cookie_set: cookie /= default_pointer
		end

	free_current_from_cookie is
			-- Free protected reference on Current
		require
			valid_cookie: cookie /= default_pointer
		do
			c_free_cookie (cookie)
			set_cookie (default_pointer)
		ensure
			cookie_set: cookie = default_pointer
		end

	cookie: POINTER is
			-- Current protected object passed to callback function.
		do
			Result := cwel_editstream_get_dwcookie (item)
		end

	set_cookie (a_cookie: POINTER) is
			-- Set `cookie' with `a_cookie'.
			--| Contains Current, so the C callback function knows
			--| which object to call.
		do
			cwel_editstream_set_dwcookie (item, a_cookie)
		ensure
			cookie_set: cookie = a_cookie
		end

	c_protect_cookie (a: POINTER): POINTER is
			-- Protect `a'.
		external
			"C [macro %"estream.h%"] (EIF_REFERENCE): EIF_POINTER"
		alias
			"eif_protect"
		end

	c_free_cookie (ptr: POINTER) is
			-- Remove protection on `ptr'.
		external
			"C [macro %"estream.h%"] (EIF_OBJECT)"
		alias
			"eif_wean"
		end

feature {NONE} -- Externals

	c_size_of_editstream: INTEGER is
		external
			"C [macro %"estream.h%"]"
		alias
			"sizeof (EDITSTREAM)"
		end

	cwel_editstream_set_dwcookie (ptr: POINTER; value: POINTER) is
		external
			"C [macro %"estream.h%"]"
		end

	cwel_editstream_set_dwerror (ptr: POINTER; value: INTEGER) is
		external
			"C [macro %"estream.h%"]"
		end

	cwel_editstream_get_dwcookie (ptr: POINTER): POINTER is
		external
			"C [macro %"estream.h%"]"
		end

	cwel_editstream_get_dwerror (ptr: POINTER): INTEGER is
		external
			"C [macro %"estream.h%"]"
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_RICH_EDIT_STREAM

