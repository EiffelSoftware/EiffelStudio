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

	internal_callback (buffer: STRING): INTEGER is
			-- `a_buffer' contains `a_length' characters.
		do
			stream_result := 0
			write_buffer (buffer)
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

end -- class WEL_RICH_EDIT_STREAM_OUT


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

