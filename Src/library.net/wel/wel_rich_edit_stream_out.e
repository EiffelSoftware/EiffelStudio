indexing
	description: "Defines the general notions of a stream out for the rich %
		%edit control."
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
			create stream_out_delegate.make (Current, $internal_callback)
			cwel_set_editstream_out_procedure_address (stream_out_delegate)
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
		
	stream_out_delegate: WEL_RICH_EDIT_STREAM_OUT_DELEGATE

feature {NONE} -- Externals

	cwel_editstream_set_pfncallback_out (ptr: POINTER) is
		external
			"C [macro %"estream.h%"]"
		end

	cwel_set_editstream_out_procedure_address (address: WEL_RICH_EDIT_STREAM_OUT_DELEGATE) is
		external
			"C [macro %"estream.h%"]"
		end

end -- class WEL_RICH_EDIT_STREAM_OUT


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

