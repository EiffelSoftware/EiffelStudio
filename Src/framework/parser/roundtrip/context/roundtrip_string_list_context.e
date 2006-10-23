indexing
	description: "Object that stores formatted Eiffel code in linked list"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	ROUNDTRIP_STRING_LIST_CONTEXT

inherit
	ROUNDTRIP_CONTEXT

create
	make

feature{NONE} -- Initialization

	make is
			-- Initialize instance.
		do
			create ctxt.make
		end

feature -- Operation

	add_string (s: STRING) is
		do
			ctxt.extend (s)
			byte_count := byte_count + s.count
			ctxt.finish
		ensure then
			string_added: ctxt.count = old ctxt.count + 1
		end

	clear is
		do
			from

			until
				ctxt.is_empty
			loop
				ctxt.start
				ctxt.remove
			end
			byte_count := 0
		ensure then
			ctxt_is_empty: ctxt.is_empty
		end

	string_representation: STRING is
		do
			if byte_count > 0 then
				from
					ctxt.start
					create Result.make (byte_count)
				until
					ctxt.after
				loop
					Result.append (ctxt.item)
					ctxt.forth
				end
			else
				Result := ""
			end
		end

	count: INTEGER is
		do
			Result := byte_count
		end

feature{NONE} -- Implementation

	ctxt: LINKED_LIST [STRING]
			-- Internal linked list to store formatted code

	initial_list_capacity: INTEGER is 2000
			-- Initial capacity of `ctxt'.

	byte_count: INTEGER
			-- Length (in bytes) of formatted code stored in `ctxt'.

invariant
	ctxt_not_void: ctxt /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
