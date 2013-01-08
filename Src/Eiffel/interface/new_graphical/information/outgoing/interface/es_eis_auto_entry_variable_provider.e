note
	description: "Variable provider for auto entry completion"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIS_AUTO_ENTRY_VARIABLE_PROVIDER

inherit
	ES_EIS_VARIABLE_PROVIDER
		redefine
			completion_possibilities
		end

create
	make

feature {NONE} -- Initialization

	make (a_target: like target)
			-- Initialization
		require
			a_target_not_void: a_target /= Void
		do
			target := a_target
		ensure
			target_set: target = a_target
		end

feature -- Access

	completion_possibilities: SORTABLE_ARRAY [like name_type]
			-- Completions proposals found by `prepare_auto_complete'
		local
			l_variables: like eis_variables.all_supported_variables_from_entry
			i: INTEGER
			l_string: STRING_32
			l_name: like name_type
		do
			l_variables := eis_variables.all_supported_variables_for_auto_entry (target)
			create Result.make_filled (Void, 0, l_variables.count - 1)
			from
				l_variables.start
				i := 0
			until
				l_variables.after
			loop
				create l_string.make (100)
				l_string.append_character ({ES_EIS_TOKENS}.variable_start)
				l_string.append_character ({ES_EIS_TOKENS}.left_paranthsis)
				l_string.append_string_general (l_variables.key_for_iteration)
				l_string.append_character ({ES_EIS_TOKENS}.right_paranthsis)
				create l_name.make (l_string)
				Result.put (l_name, i)
				i := i + 1
				l_variables.forth
			end
			Result.sort
		end

feature {NONE} -- Implementation

	target: CONF_TARGET
			-- Related target

invariant
	target_not_void: target /= Void

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
