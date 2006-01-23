indexing
	description: "Bind Variable of type STRING"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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




end -- class OCI_BIND_STRING
