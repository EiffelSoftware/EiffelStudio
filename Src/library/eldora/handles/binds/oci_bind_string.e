indexing
	description: "Bind Variable of type STRING"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"
	history: "$History: oci_bind_string.e $"

class
	OCI_BIND_STRING

inherit
	OCI_BIND

	OCI_DEFINE_STRING
		undefine
			handle_type
		end

create
	make

feature -- Basic operations

	set_value (new_value: STRING) is
			-- Set value of bind-variable to `new_value'
		local
			area: WEL_STRING
			temp: INTEGER
		do
			temp  := new_value.count
			actual_length_ptr.memory_copy ($temp, Integer_bytes)
			create area.make (new_value)
			buffer.memory_copy (area.item, actual_length)
		end
		
end -- class OCI_BIND_STRING
