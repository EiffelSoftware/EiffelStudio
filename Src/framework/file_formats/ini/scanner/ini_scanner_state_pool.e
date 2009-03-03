note
	description: "A state scanner state pool for retrieving cached states by a corresponding TYPE [G]."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	INI_SCANNER_STATE_POOL

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize scanner state pool.
		local
			l_pool: like state_pool
		do
			create l_pool.make (3)
			l_pool.compare_objects
			state_pool := l_pool
		end

feature -- Access

	state (a_type: TYPE [INI_SCANNER_STATE]): INI_SCANNER_STATE
			-- Retrieve a scanner state for type `a_type'
		require
			a_type_attached: a_type /= Void
		local
			l_key: STRING
		do
			l_key := a_type.generating_type
			Result := state_pool.item (l_key)
			if Result = Void then
				if a_type ~ {INI_SCANNER_INITIAL_STATE} then
					create {INI_SCANNER_INITIAL_STATE} Result
				elseif a_type ~ {INI_SCANNER_OPEN_SECTION_STATE} then
					create {INI_SCANNER_OPEN_SECTION_STATE} Result
				elseif a_type ~ {INI_SCANNER_POST_PROPERTY_STATE} then
					create {INI_SCANNER_POST_PROPERTY_STATE} Result
				elseif a_type ~ {INI_SCANNER_POST_ASSIGNER_STATE} then
					create {INI_SCANNER_POST_ASSIGNER_STATE} Result
				end
				state_pool.extend (Result, l_key)
			end
		ensure
			result_attached: Result /= Void
			state_pool_has_a_type: state_pool.item (a_type.generating_type) /= Void
		end

feature {NONE} -- Implementation

	state_pool: HASH_TABLE [INI_SCANNER_STATE, STRING]
			-- Scanner state pool
			-- Key: Scanner type name
			-- Value: Scanner state

invariant
	state_pool_attahed: state_pool /= Void
	state_pool_compares_objects: state_pool.object_comparison

note
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

end -- class {INI_SCANNER_STATE_POOL}
