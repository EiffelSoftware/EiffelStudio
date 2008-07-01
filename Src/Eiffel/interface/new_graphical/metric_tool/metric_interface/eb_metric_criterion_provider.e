indexing
	description: "Criterion list auto-completion provider"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_CRITERION_PROVIDER

inherit
	COMPLETION_POSSIBILITIES_PROVIDER
		redefine
			code_completable,
			completion_possibilities
		end

create
	make

feature{NONE} -- Initialization

	make (a_possibilities: like completion_possibilities) is
			-- Initialize `completion_possibilities' with `a_possibilities'.
		require
			a_possibilities_attached: a_possibilities /= Void
		do
			completion_possibilities := a_possibilities
		ensure
			completion_possibilities_set: completion_possibilities = a_possibilities
		end

feature -- Access

	code_completable: COMPLETABLE_TEXT_FIELD
			-- A code completable.

	completion_possibilities: SORTABLE_ARRAY [like name_type]
			-- Completions proposals found by `prepare_auto_complete'

feature{NONE} -- Implementation

	insertion: STRING_32 is
			-- String to be partially completed
		local
			l_text: STRING_32
			l_index: INTEGER
			done: BOOLEAN
		do
			l_text := code_completable.text
			if code_completable.caret_position /= 1 then
				from
					l_index := code_completable.caret_position - 1
				until
					l_index < 1 or done
				loop
					if l_text.item (l_index).is_space then
						done := True
						l_index := l_index + 1
					else
						l_index := l_index - 1
					end
				end
				if l_index < 1 then
					l_index := 1
				end
				Result := l_text.substring (l_index, code_completable.caret_position - 1)
			else
				Result := ""
			end
		end

	insertion_remainder: INTEGER is
			-- The number of characters in the insertion remaining from the cursor position to the
			-- end of the token
		local
--			l_text: STRING_32
		do
			Result := 0
--			l_text := code_completable.text
--			Result := l_text.count - code_completable.caret_position + 1
		end

invariant
	completion_possibilities_attached: completion_possibilities /= Void

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
