indexing
	description: "[
			A feature body's editor analyzer's state, used in processing tokens between do..end tokens.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EDITOR_ANALYZER_FEATURE_BODY_STATE

inherit
	ES_EDITOR_ANALYZER_FEATURE_STATE_BASE
		redefine
			is_valid_start_token
		end

feature -- Status report

	is_valid_start_token (a_token: !EDITOR_TOKEN; a_line: !EDITOR_LINE): BOOLEAN
			-- <Precursor>
		do
			Result := Precursor (a_token, a_line) and then (is_feature_body_token (a_token, a_line))
		end

feature {NONE} -- Basic operation

	process_next_tokens (a_info: !ES_EDITOR_ANALYZER_FEATURE_STATE_INFO; a_end_token: ?EDITOR_TOKEN)
			-- <Precursor>
		local
			l_next: ?like next_token
			l_state: ES_EDITOR_ANALYZER_STATE [ES_EDITOR_ANALYZER_FEATURE_STATE_INFO]
			l_stop: BOOLEAN
		do
			from until l_stop loop
				l_next := next_token (a_info.current_token, a_info.current_line, True, a_end_token,
					agent (ia_start_token: !EDITOR_TOKEN; ia_start_line: !EDITOR_LINE): BOOLEAN
							-- Locate an if token.
						do
							Result := is_keyword_token (ia_start_token, {EIFFEL_KEYWORD_CONSTANTS}.if_keyword)
						end)

				a_info.has_runout := l_next = Void
				if l_next /= Void then
					a_info.set_current_line (l_next.line, l_next.token)
					a_info.increment_current_frame (False)
					create {ES_EDITOR_ANALYZER_IF_BLOCK_STATE} l_state
					l_state.process (a_info, a_end_token)
					if not a_info.has_runout then
						a_info.decrement_current_frame
					else
						l_stop := True
					end
				else
					l_stop := True
					a_info.has_runout := True
				end
			end
		end

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
