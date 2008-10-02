indexing
	description: "[
			A base implementation for feature-based analyzer states ({ES_EDITOR_ANALYZER_STATE}).
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_EDITOR_ANALYZER_FEATURE_STATE_BASE

inherit
	ES_EDITOR_ANALYZER_STATE [ES_EDITOR_ANALYZER_FEATURE_STATE_INFO]
		redefine
			is_valid_state_info
		end

feature -- Status report

	is_valid_state_info (a_info: !ES_EDITOR_ANALYZER_STATE_INFO): BOOLEAN
			-- <Precursor>
		do
			Result := Precursor (a_info)
			if Result and then {l_info: ES_EDITOR_ANALYZER_FEATURE_STATE_INFO} a_info then
				Result := l_info.has_current_frame
			end
		ensure then
			a_info_has_current_frame: Result implies (
					({?ES_EDITOR_ANALYZER_FEATURE_STATE_INFO}) #? a_info /= Void and then
					(({?ES_EDITOR_ANALYZER_FEATURE_STATE_INFO}) #? a_info).has_current_frame
				)
		end

feature {NONE} -- Status report

	is_feature_body_token (a_token: !EDITOR_TOKEN; a_line: !EDITOR_LINE): BOOLEAN
			-- Determines if a token represents a feature body keyword token.
			--
			-- `a_token': Token to check as a feature body token.
			-- `a_line' : The line where the supplied token is resident.
			-- `Result' : True if the token is a feature body token; False otherwise.
		local
			l_next: ?like next_token
		do
			Result := is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.do_keyword) or else
				is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.attribute_keyword)
			if not Result then
				if is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.deferred_keyword) or else is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.external_keyword) then
						-- Make sure there is no class keyword
					l_next := next_token (a_token, a_line, True, Void, Void)
					Result := l_next = Void or else not is_keyword_token (l_next.token, {EIFFEL_KEYWORD_CONSTANTS}.class_keyword)
				elseif is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.once_keyword) then
						-- Make sure there is no string keyword after the once
					l_next := next_token (a_token, a_line, True, Void, Void)
					Result := l_next = Void or else not {l_string: EDITOR_TOKEN_STRING} l_next.token
				end
			end
		end

feature {NONE} -- Helpers

	local_list_state: !ES_EDITOR_ANALYZER_LOCAL_LIST_STATE
			-- Access to the local list state.
		once
			create Result
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
