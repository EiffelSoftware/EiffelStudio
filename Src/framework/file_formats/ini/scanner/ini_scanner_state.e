note
	description: "Base implementation for all state scanner states."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	INI_SCANNER_STATE

inherit
	ANY

	INI_SHARED_SCANNER_STATE_POOL
		export
			{NONE} all
		end

feature -- Access

	token: detachable INI_SCANNER_TOKEN_INFO
			-- Last token info generated from `scan_for_next_token'

	next_state: detachable INI_SCANNER_STATE
			-- Next state

feature -- Basic Operations

	scan (a_line: STRING; a_index: INTEGER)
			-- Scans `a_line' for token information and set `token' with any located
			-- token information. `next_state' will also be set to indicate what state
			-- should be processed next.
		require
			a_line_attached: a_line /= Void
			not_a_line_is_empty: not a_line.is_empty
			a_index_positive: a_index > 0
			token_unattached: token = Void
			next_state_unattached: next_state = Void
		deferred
		ensure
			token_attached: token /= Void
			next_state_attached: next_state /= Void
		end

	reset
			-- Resets state, clearing cached information.
		do
			token := Void
			next_state := Void
		ensure
			token_unattached: token = Void
			next_state_unattached: next_state = Void
		end

feature {NONE} -- Implementation

	non_whitespace_index (a_text: STRING): INTEGER
			-- First index of a non-whitespace character in `a_text'.
			-- Results of zero indicate line is blank.
		require
			a_text_attached: a_text /= Void
			not_a_text_is_empty: not a_text.is_empty
		local
			l_count: INTEGER
			i: INTEGER
		do
			from
				i := 1
				l_count := a_text.count
			until
				Result > 0 or i > l_count
			loop
				if not a_text.item (i).is_space then
					Result := i
				else
					i := i + 1
				end
			end
		ensure
			result_non_negative: Result >= 0
			result_valid: Result > 0 implies not a_text.item (Result).is_space
		end

	set_token_info (a_text: STRING; a_type: INI_SCANNER_TOKEN_TYPE; a_start_index: INTEGER)
			-- Set `token'
		do
			create token.make (a_text, a_type, a_start_index)
		ensure
			token_attached: attached token as t
			token_text_set: t.text ~ a_text
			token_type_type: t.type = a_type
			token_span_start_index: t.start_index = a_start_index
		end

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software"
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

