note
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

	make
			-- Initialize the C variables.
		do
			Precursor {WEL_RICH_EDIT_STREAM}
			create stream_out_delegate.make (Current, $internal_callback)
			cwel_set_editstream_out_procedure_address (stream_out_delegate)
			cwel_editstream_set_pfncallback_out (item)
		end

feature -- Access

	buffer: detachable MANAGED_POINTER
			-- Buffer to set in `read_buffer'.

feature -- Basic operations

	write_buffer
			-- Write `buffer'.
		require
			buffer_not_void: buffer /= Void
		deferred
		end

feature {NONE} -- Implementation

	internal_callback (a_buffer: POINTER; a_length: INTEGER): INTEGER
			-- `buffer' contains `length' characters.
		do
			if attached buffer as l_buffer then
				l_buffer.set_from_pointer (a_buffer, a_length)
			else
				create buffer.share_from_pointer (a_buffer, a_length)
			end
			stream_result := 0
			write_buffer
			Result := stream_result
		end

	stream_out_delegate: detachable WEL_RICH_EDIT_STREAM_OUT_DELEGATE

feature {NONE} -- Externals

	cwel_editstream_set_pfncallback_out (ptr: POINTER)
		external
			"C [macro %"estream.h%"]"
		end

	cwel_set_editstream_out_procedure_address (address: like stream_out_delegate)
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


end -- class WEL_RICH_EDIT_STREAM_OUT


