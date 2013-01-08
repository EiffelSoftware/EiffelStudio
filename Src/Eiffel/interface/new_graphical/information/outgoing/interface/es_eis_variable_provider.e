note
	description: "Provider for EIS variable completion"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIS_VARIABLE_PROVIDER

inherit
	COMPLETION_POSSIBILITIES_PROVIDER
		redefine
			code_completable,
			completion_possibilities
		end

	ES_EIS_SHARED

create
	make_from_entry

feature {NONE} -- Initialization

	make_from_entry (a_entry: like eis_entry)
			-- Initialize with EIS entry.
		require
			a_entry_not_void: a_entry /= Void
		do
			eis_entry := a_entry
		ensure
			eis_entry_set: eis_entry = a_entry
		end

feature -- Access

	code_completable: ES_EIS_COMPLETABLE_TEXT_FIELD
			-- <Precursor>

	completion_possibilities: SORTABLE_ARRAY [like name_type]
			-- Completions proposals found by `prepare_auto_complete'
		local
			l_variables: like eis_variables.all_supported_variables_from_entry
			i: INTEGER
			l_string: STRING_32
			l_name: like name_type
		do
			if attached eis_entry as l_entry then
				l_variables := eis_variables.all_supported_variables_from_entry (l_entry)
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
			else
				create Result.make_empty
			end
		end

feature {NONE} -- Access

	eis_entry: detachable EIS_ENTRY
			-- The related EIS entry

	insertion: STRING_32
			-- String to be partially completed
		local
			l_text: STRING_32
			l_index: INTEGER
			done: BOOLEAN
		do
			if attached code_completable as l_completable then
				l_text := l_completable.text
				if l_completable.caret_position /= 1 then
					from
						l_index := l_completable.caret_position - 1
					until
						l_index < 1 or done
					loop
						if
							l_text.item (l_index) = {ES_EIS_TOKENS}.variable_start
						then
							done := True
						else
							l_index := l_index - 1
						end
					end
					if l_index >= 1 then
						Result := l_text.substring (l_index, l_completable.caret_position - 1)
					else
						create Result.make_empty
					end
				else
					create Result.make_empty
				end
			end
		end

	insertion_remainder: INTEGER = 0
			-- <Precursor>

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
