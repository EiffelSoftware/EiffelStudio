note
	description: "[
		Represents a located assembly and exposes a real code base path, not the
		.NET determined code base, which can sometimes be the same as the GAC path.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

class
	LOCATED_ASSEMBLY

inherit
	ANY
		redefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (a_asm: like assembly; a_path: like real_path)
			-- Initialize a new located assembly
		require
			a_asm_attached: a_asm /= Void
			a_path_attached: a_path /= Void
			not_a_path_is_empty: not a_path.is_empty
		do
			assembly := a_asm
			real_path := a_path
		ensure
			assembly_set: assembly = a_asm
			real_path_set: real_path = a_path
		end

feature -- Access

	assembly: ASSEMBLY
			-- Assembly that was located

	real_path: STRING
			-- Code base of assembly, most probably not in GAC.
			-- Note: this is not necessarly `assembly.location'

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := assembly.equals (other.assembly)
		end

invariant
	assembly_attached: assembly /= Void
	real_path_attached: real_path /= Void
	not_real_path_is_empty: not real_path.is_empty

note
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

end -- class {LOCATED_ASSEMBLY}
