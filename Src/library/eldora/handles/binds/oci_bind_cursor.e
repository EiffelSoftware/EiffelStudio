indexing
	description: "Bind Variable of type CURSOR"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"
	history: "$History: oci_bind_cursor.e $"

class
	OCI_BIND_CURSOR

inherit
	OCI_BIND

	OCI_DEFINE_CURSOR
		undefine
			handle_type
		end

create
	make

feature -- Basic operations

	set_value (new_value: OCI_STATEMENT) is
			-- Set value of bind-variable to `new_value'
		local
			temp: POINTER
		do
			temp := new_value.handle
			buffer.memory_copy ($temp, Pointer_bytes)
		end
		
end -- class OCI_BIND_CURSOR
