indexing
	description: "[
			Represents a single state when used when processing tokens.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_CLASS_CONTEXT_ANALYZER_STATE

inherit
	ES_EDITOR_TOKEN_ANALYZER
		export
			{NONE} all
		end

--feature -- Access

--	current_token: ?EDITOR_TOKEN
--			-- Last editor token processed

--	current_line: ?EDITOR_LINE
--			-- Last editor line processed

--	next_state: ?ES_CLASS_CONTEXT_ANALYZER_STATE
--			-- Next state to be processed with the last token and line information

feature -- Status report

	is_valid_start_token (a_token: !EDITOR_TOKEN): BOOLEAN
			-- Determines if a given token is valid as the state's start token.
		do
			Result := True
		end

feature -- Basic operation

	frozen process (a_class: !CLASS_I; a_start_token: !EDITOR_TOKEN; a_start_line: !EDITOR_LINE; a_end_token: ?EDITOR_TOKEN): !ES_EDITOR_ANALYZER_STATE_RESULT
			-- Processes a token for the current state.
			--
			-- `a_class'      : A context class used to resolve any type for feature information.
			-- `a_start_token': The token on the supplied line to process.
			-- `a_start_line' : The line where the supplied token is resident.
			-- `a_end_token'  : The token to stop processing at, or Void to process to the end of the
			--                  document.
		require
			a_start_line_has_a_token: a_start_line.has_token (a_start_token)
			a_start_token_is_valid_start_token: is_valid_start_token (a_start_token)
		do
			Result := new_state_result (a_class, a_start_token, a_start_line)
--			reset
--			curent_token := a_start_token
--			current_line := a_start_line
			process_tokens (Result, a_end_token)
--			is_processed := True
		ensure
--			is_processed: is_processed
		end

feature {NONE} -- Basic operation

	reset
			-- Resets the current state for reuse.
		do
--			current_token := Void
--			current_line := Void
--			next_state := Void
--			is_processed := False
--		ensure
--			current_token_detached: current_token = Void
--			current_line_detached: current_line = Void
--			next_state_detached: next_state = Void
--			not_is_processed: not is_processed
		end

	process_tokens (a_result: !like new_state_result; a_end_token: ?EDITOR_TOKEN)
			-- Processes a token for the current state.
			--
			-- `a_result'   : The state result to use when processing the tokens.
			-- `a_end_token': The token to stop processing at, or Void to process to the end of the
			--                document.
		require
--			not_is_processed: not is_processed
		deferred
		ensure
--			is_processed_unchanged: is_processed = old is_processed
		end

--	process_tokens (a_start_token: !EDITOR_TOKEN; a_start_line: !EDITOR_LINE)
--			-- Processes a token for the current state.
--			--
--			--|The implementation should not process the next state itself, just set the `next_state'
--			--|and return from the routine.
--			--
--			-- `a_start_token': The token on the supplied line to process.
--			-- `a_start_line': The line where the supplied token is resident.
--		require
--			current_token_set: current_token = a_start_token
--			current_line_set: current_line = a_start_line
--			not_is_processed: not is_processed
--		deferred
--		ensure
--			is_processed_unchanged: is_processed = old is_processed
--		end

feature {NONE} -- Factory

	new_state_result (a_class: !CLASS_I; a_token: !EDITOR_TOKEN; a_line: !EDITOR_LINE): !ES_EDITOR_ANALYZER_STATE_RESULT
			-- Creates a new state result for processing.
			--
			-- `a_class': A context class used to resolve any type for feature information.
			-- `a_token': The token on the supplied line to process.
			-- `a_line' : The line where the supplied token is resident.
		do
			create Result.make (a_class, a_token, a_line)
		end

--invariant
--	current_line_has_current_token: current_line.has_token (current_token)

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
