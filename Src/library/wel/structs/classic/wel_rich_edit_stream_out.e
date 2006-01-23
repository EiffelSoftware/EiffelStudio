indexing
	description: "Defines the general notions of a stream out for the rich %
		%edit control."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEL_RICH_EDIT_STREAM_OUT

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
			cwel_set_editstream_out_procedure_address ($internal_callback)
			cwel_editstream_set_pfncallback_out (item)
		end

feature -- Basic operations

	write_buffer (buffer: STRING) is
			-- Write `buffer'.
		require
			buffer_not_void: buffer /= Void
		deferred
		end

feature {NONE} -- Implementation

	internal_callback (buffer: POINTER; length: INTEGER): INTEGER is
			-- `buffer' contains `length' characters.
		local
			l_value: STRING
		do
			create l_value.make (length + 1)
			l_value.from_c_substring (buffer, 1, length)
			stream_result := 0
			write_buffer (l_value)
			Result := stream_result
		end

feature {NONE} -- Externals

	cwel_editstream_set_pfncallback_out (ptr: POINTER) is
		external
			"C [macro %"estream.h%"]"
		end

	cwel_set_editstream_out_procedure_address (address: POINTER) is
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




end -- class WEL_RICH_EDIT_STREAM_OUT

