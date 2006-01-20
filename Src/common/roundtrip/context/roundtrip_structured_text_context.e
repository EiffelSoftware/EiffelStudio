indexing
	description: "Object that stores formatted Eiffel code in structured text"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	ROUNDTRIP_STRUCTURED_TEXT_CONTEXT

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
			ctxt.add_string (s)
			byte_count := byte_count + s.count
		end

	clear is
		do
			create ctxt.make
			byte_count := 0
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
					Result.append (ctxt.item.image)
					ctxt.forth
				end
			end
		end

	count: INTEGER is
		do
			Result := byte_count
		end

feature{NONE} -- Implementation

	ctxt: STRUCTURED_TEXT
			-- Structured text used to store content

	byte_count: INTEGER
			-- Number in byte of length of content

invariant
	ctxt_not_void: ctxt /= VOid

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
