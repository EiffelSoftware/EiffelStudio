indexing
	description: "Define Variable of type CURSOR"
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
	
end -- class OCI_DEFINE_CURSOR
