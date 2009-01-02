note
	description: "[
		A INI line  token state scanner.
		
		Using this scanner will provider clients with better contextual information for
		each token found. This scanner implementation can distinguish between tokens that
		have that same expressional representation.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	INI_SCANNER

inherit
	ANY

	INI_SHARED_SCANNER_STATE_POOL
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize scanner for first use.
		do
			initial_state ?= state_pool.state ({INI_SCANNER_INITIAL_STATE})
			next_state := initial_state
		end

feature -- Access

	token: INI_SCANNER_TOKEN_INFO
			-- Last token info generated from `scan_for_next_token'

	initial_state: INI_SCANNER_INITIAL_STATE
			-- Scanner's initial state

	next_state: INI_SCANNER_STATE
			-- Next state to process

feature -- Basic Operations

	scan_for_next_token_info (a_line: STRING; a_index: INTEGER; a_state: like next_state)
			--
		require
			a_line_attached: a_line /= Void
			a_index_positive: a_index > 0
			a_state_attached: a_state /= Void
		do
			reset
			a_state.reset
			a_state.scan (a_line, a_index)
			token := a_state.token
			next_state := a_state.next_state
		ensure
			token_attached: token /= Void
			next_state_attached: next_state /= Void
		end

feature {NONE} -- Basic Operations

	reset
			-- Resets scanner, clearing cached information.
		do
			token := Void
			next_state := Void
		ensure
			token_unattached: token = Void
			next_state_unattached: next_state = Void
		end

invariant
	next_state_attached: next_state /= Void

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

end -- class {INI_SCANNER}
