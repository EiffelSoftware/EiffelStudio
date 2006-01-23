indexing
	description: "Define Variable of type CURSOR"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"
	history: "$History: oci_define_cursor.e $"

class
	OCI_DEFINE_CURSOR

inherit
	OCI_DEFINE
	
	PLATFORM
		undefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make is
		do
			make_variable (Sqlt_cur, Pointer_bytes)
		end

feature -- Access

	value: OCI_STATEMENT is
			-- Current value of define variable
		local
			cursor_handle: POINTER
		do
			($cursor_handle).memory_copy (buffer, Pointer_bytes)
			create Result.make_by_handle (cursor_handle)
		end
	
	valid_data_type_and_size (type: INTEGER_16; size: INTEGER): BOOLEAN is
			-- Are `type' and `size' valid values for `data_type' and `data_size' ?
		do
			Result := type = Sqlt_cur and size = Pointer_bytes
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




end -- class OCI_DEFINE_CURSOR
