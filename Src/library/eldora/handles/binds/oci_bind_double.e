indexing
	description: "Bind Variable of type DOUBLE"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"
	history: "$History: oci_bind_double.e $"

class
	OCI_BIND_DOUBLE

inherit
	OCI_BIND

	OCI_DEFINE_DOUBLE
		undefine
			handle_type
		end

create
	make

feature -- Basic operations

	set_value (new_value: DOUBLE_REF) is
			-- Set value of bind-variable to `new_value'
		local
			temp: DOUBLE
			temp_ptr: POINTER
		do
			temp := new_value.item
			temp_ptr := $temp
			buffer.memory_copy (temp_ptr, Double_bytes)
		end
		
end -- class OCI_BIND_DOUBLE
