indexing
	description: "Defines the general notions of a stream in for the rich %
		%edit control."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEL_RICH_EDIT_STREAM_IN

inherit
	WEL_RICH_EDIT_STREAM
		redefine
			make
		end

feature {NONE} -- Initialization

	make is
			-- Initialize the C variables.
		do
			Precursor {WEL_RICH_EDIT_STREAM}
			cwel_set_editstream_in_procedure_address ($internal_callback)
			cwel_editstream_set_pfncallback_in (item)
		end

feature -- Access

	buffer: WEL_STRING
			-- Buffer to set in `read_buffer'.

feature -- Basic operations

	read_buffer (length: INTEGER) is
			-- Set to `buffer' a string of `length' (or
			-- less) characters.
		require
			positive_length: length >= 0
		deferred
		ensure
			buffer_not_void: buffer /= Void
			valid_buffer_length: buffer.count <= length
		end

feature {NONE} -- Implementation

	internal_callback (a_buffer: POINTER; a_buffer_length: INTEGER; a_data_length: POINTER): INTEGER is
			-- Set to `a_buffer' a string of at most `a_length' characters.
			-- `a_data_length' is a C-pointer to an integer, that has to
			-- be set to the length of the data that was actually
			-- written into `a_buffer'.
		do
			stream_result := 0
			read_buffer (a_buffer_length)
			a_buffer.memory_copy (buffer.item, buffer.count)
			cwel_set_integer_reference_value (a_data_length, buffer.count)
			Result := stream_result
		end

feature {NONE} -- Externals

	cwel_set_integer_reference_value (ref: POINTER; value: INTEGER) is
			-- Sets the contents of a C-pointer to an LONG (`ref') to
			-- `value'.
		external
			"C [macro <estream.h>] (LONG FAR *, int)"
		end

	cwel_editstream_set_pfncallback_in (ptr: POINTER) is
		external
			"C [macro %"estream.h%"]"
		end

	cwel_set_editstream_in_procedure_address (address: POINTER) is
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




end -- class WEL_RICH_EDIT_STREAM_IN

