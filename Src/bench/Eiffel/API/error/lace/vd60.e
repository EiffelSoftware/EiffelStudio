indexing
	description: "[
		Error when an assembly refers to another assembly which is not
		listed in the Ace file.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	VD60

inherit
	LACE_ERROR
		redefine
			build_explain
		end

create
	make

feature {NONE} -- Initialization

	make (an_assembly: like assembly; a_referred_assembly: like referred_assembly) is
			-- Create VD60 error using data from `an_assembly' and `a_referred_assembly'.
		require
			an_assembly_not_void: an_assembly /= Void
			a_referred_assembly_not_void: a_referred_assembly /= Void
		do
			assembly := an_assembly
			referred_assembly := a_referred_assembly
		ensure
			assembly_set: assembly = an_assembly
			referred_assembly_set: referred_assembly = a_referred_assembly
		end

feature {NONE} -- Properties

	assembly: ASSEMBLY_I
			-- Assembly which refer to `referred_assembly' which is unknown.

	referred_assembly: CONSUMED_ASSEMBLY
			-- Referred assembly from `assembly' that is unknown in system.

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Assembly: ")
			st.add_string (assembly.cluster_name)
			st.add_new_line
			st.add_string ("Referred assembly: ")
			st.add_string (referred_assembly.out)
			st.add_new_line
		end

invariant
	assembly_not_void: assembly /= Void
	referred_assembly_not_void: referred_assembly /= Void

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

end -- class VD60
