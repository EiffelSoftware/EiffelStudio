indexing
	description: "[

		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EDITOR_ANALYZER_STATE_RESULT

create
	make

feature {NONE} -- Initialization

	make (a_class: !like context_class; a_token: !like current_token; a_line: !like current_line)
			-- Initialize a state result using a context class and an initial editor token and hosting line.
			--
			-- `a_class': The context class, used to resolve any type or feature information.
			-- `a_token': The state's current token.
			-- `a_line' : The state's current line, where the supplied token is resident.
		require
			a_line_has_a_token: a_line.has_token (a_token)
		do
			context_class := a_class
			set_current_line (a_line, a_token)
		ensure
			context_class_set: context_class ~ a_class
			current_line_set: current_line ~ a_line
			current_token_set: current_token ~ a_token
		end

feature -- Access

	context_class: !CLASS_I
			-- The context class

	current_token: !EDITOR_TOKEN assign set_current_token
			-- Last editor token processed.

	current_line: !EDITOR_LINE
			-- Last editor line processed.

	next_state: ?ES_CLASS_CONTEXT_ANALYZER_STATE assign set_next_state
			-- Next state to be processed with the last token and line information,

feature -- Element change

	set_current_token (a_token: !like current_token)
			-- Sets the current token.
			-- Note: Setting the current token in this fashion assumes the token belongs to the current
			--       line. Use `set_current_line' when changing lines and tokens.
			--
			-- `a_token': The new token to set on the state result.
		require
			current_line_has_a_token: current_line.has_token (a_token)
		do
			current_token := a_token
		ensure
			current_token_set: current_token ~ a_token
		end

	set_current_line (a_line: !like current_line; a_initial_token: !like current_token)
			-- Stets the current line and current token
			--
			-- `a_line'         : The new line to set on the state result.
			-- `a_initial_token': The initial line token to set on the state result.
		require
			a_line_has_a_initial_token: a_line.has_token (a_initial_token)
		do
			current_line := a_line
			set_current_token (a_initial_token)
		ensure
			current_line_set: current_line ~ a_line
			current_token_set: current_token ~ a_initial_token
		end

	set_next_state (a_state: ?ES_CLASS_CONTEXT_ANALYZER_STATE)
			-- Sets the next state an analyzer should use when done with Current's associated state
			-- processing.
			--
			-- `a_state': The next state to process or Void if processing should be aborted or left up to
			--            the analyzer to figure out.
		require
			a_state_attached: a_state /= Void
		do
			next_state := a_state
		ensure
			next_state_set: next_state ~ a_state
		end

feature -- Status report

	has_runout: BOOLEAN assign set_has_runout
			-- Indicates if the scanner has run out of tokens to process

feature -- Status setting

	set_has_runout (a_runout: like has_runout)
			-- Sets runout token state.
			--
			-- `a_runout': True if there are no more tokens to process; False otherwise.
		do
			has_runout := a_runout
		ensure
			has_runout_set: has_runout = a_runout
		end

invariant
	current_line_has_current_token: current_line.has_token (current_token)

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
