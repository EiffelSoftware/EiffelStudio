indexing
	description: "Bind Variable of type INTEGER"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"
	history: "$History: oci_bind_integer.e $"

class
	OCI_BIND_INTEGER

inherit
	OCI_BIND

	OCI_DEFINE_INTEGER
		undefine
			handle_type
		end

create
	make

feature -- Basic operations

	set_value (new_value: INTEGER_REF) is
			-- Set value of bind-variable to `new_value'
		local
			temp: INTEGER
			temp_ptr: POINTER
		do
			temp := new_value.item
			temp_ptr := $temp
			buffer.memory_copy (temp_ptr, Integer_bytes)
		end
		
end -- class OCI_BIND_INTEGER
