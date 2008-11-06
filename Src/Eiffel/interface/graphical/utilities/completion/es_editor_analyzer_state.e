indexing
	description: "[
			A base to representing a single editor analyzer's state when, used when processing tokens.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_EDITOR_ANALYZER_STATE  [G -> ES_EDITOR_ANALYZER_STATE_INFO]

inherit
	ES_EDITOR_ANALYZER_UTILITIES
		export
			{NONE} all
		end

	ANY

feature -- Status report

	is_valid_state_info (a_info: !ES_EDITOR_ANALYZER_STATE_INFO): BOOLEAN
			-- Detemines if a given state info object is valid for Current.
			--
			-- `a_info': The info object to test for validity.
			-- `Result': True if the given object was valid; False otherwise.
		do
			Result := (({?G}) #? a_info) /= Void
		ensure
			non_generic_cat_call: Result implies (({?G}) #? a_info) /= Void
		end

	is_valid_start_token (a_token: !EDITOR_TOKEN; a_line: !EDITOR_LINE): BOOLEAN
			-- Determines if a given token is valid as the state's start token.
			--
			-- `a_token': The editor token to test to applicablity for use as the state's starting token.
			-- `Result' : True if the given token is a valid start token; False otherwise.
		do
			Result := True
		end

feature -- Basic operation

	frozen process (a_info: !G; a_end_token: ?EDITOR_TOKEN)
			-- Processes a token for the next state.
			--
			-- `a_info'     : The state information to use when processing the tokens.
			-- `a_end_token': The token to stop processing at, or Void to process to the end of the
			--                document.
		require
			a_info_is_valid_state_info: is_valid_state_info (a_info)
			result_has_valid_start_token: is_valid_start_token (a_info.current_token, a_info.current_line)
		do
			reset
			if a_info.current_token /~ a_end_token then
				process_next_tokens (a_info, a_end_token)
			else
				a_info.has_runout := True
			end
		end

feature {NONE} -- Basic operation

	process_next_tokens (a_info: !G; a_end_token: ?EDITOR_TOKEN)
			-- Processes a token for the current state.
			--
			-- `a_info'     : The state information to use when processing the tokens.
			-- `a_end_token': The token to stop processing at, or Void to process to the end of the
			--                document.
		require
			a_info_is_valid_state_info: is_valid_state_info (a_info)
			a_start_token_is_valid_start_token: is_valid_start_token (a_info.current_token, a_info.current_line)
			a_info_current_token_not_a_end_token: a_info.current_token /~ a_end_token
		deferred
		end

	reset
			-- Resets the current state for reuse.
		do
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
