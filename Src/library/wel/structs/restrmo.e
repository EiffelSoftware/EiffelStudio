indexing
	description: "Defines the general notions of a stream out for the rich %
		%edit control."
	note: "Do not use more than one instance of this class at the same %
		%time. Nested streams are not supported."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEL_RICH_EDIT_STREAM_OUT

inherit
	WEL_RICH_EDIT_STREAM
		rename
			make as rich_edit_stream_make
		end

feature {NONE} -- Initialization

	make is
			-- Initialize the C variables.
		do
			rich_edit_stream_make
			cwel_set_editstream_procedure_address ($internal_callback)
			cwel_set_editstream_object (ceif_adopt (Current))
			cwel_set_editstream_in (False)
		end

feature -- Basic operations

	write_buffer (buffer: STRING) is
			-- Write `buffer'.
		require
			buffer_not_void: buffer /= Void
		deferred
		end

feature {NONE} -- Implementation

	internal_callback (a_buffer: POINTER; a_length: INTEGER): INTEGER is
			-- `a_buffer' contains `a_length' characters.
		local
			s: STRING
		do
			stream_result := 0
			!! s.make (0)
			s.from_c (a_buffer)
			write_buffer (s)
			cwel_set_editstream_buffer_size (s.count)
			Result := stream_result
		end

end -- class WEL_RICH_EDIT_STREAM_OUT

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
