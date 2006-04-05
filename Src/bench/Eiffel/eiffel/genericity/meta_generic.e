indexing
	description: "[
		Representation of a parameter generic derivation. Meta because
		expanded generic parameter gets their own type, but all references gets
		a REFERENCE_I instance.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision: "

class
	META_GENERIC

inherit
	ARRAY [TYPE_I]
		rename
			make as array_make
		end

create
	make

feature -- Initialization

	make (n: INTEGER) is
		require
			n_valid: n >= 0
		do
			array_make (1, n)
		end

feature -- Comparison

	same_as (other: like Current): BOOLEAN is
			-- Is `other' equal to Current ?
		require
			other_not_void: other /= Void
		local
			i, nb: INTEGER
		do
			nb := count
			Result := nb = other.count
			from
				i := 1
			until
				i > nb or else not Result
			loop
				Result := item (i).same_as (other.item (i))
				i := i + 1
			end
		end

feature -- Status report

	is_valid: BOOLEAN is
			-- Are all the types valid ?
		local
			i, nb: INTEGER
		do
			from
				nb := count
				i := 1
				Result := True
			until
				i > nb or else not Result
			loop
				Result := item (i).is_valid
				i := i + 1
			end
		end

feature -- C code generation

	generate_cecil_values (buffer: GENERATION_BUFFER) is
			-- Generate Cecil meta-types
		require
			buffer_not_void: buffer /= Void
		local
			i: INTEGER
		do
			from
				i := lower
			until
				i > upper
			loop
				item (i).generate_cecil_value (buffer)
				buffer.put_string (",%N")
				i := i + 1
			end
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Make byte code for cecil values
		require
			ba_not_void: ba /= Void
		local
			i: INTEGER
		do
			from
				i := lower
			until
				i > upper
			loop
				ba.append_integer_32 (item (i).cecil_value)
				i := i + 1
			end
		end

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
