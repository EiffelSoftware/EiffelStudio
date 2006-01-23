indexing
	description: "Bind Variable of type DOUBLE"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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




end -- class OCI_BIND_DOUBLE
