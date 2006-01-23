indexing
	description: "Bind Variable of type CURSOR"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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




end -- class OCI_BIND_CURSOR
