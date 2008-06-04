indexing
	description: "Constants for execution modes."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class

	EXEC_MODES

feature -- Execution mode properties

	frozen is_valid_mode (a_mode: INTEGER): BOOLEAN is
			-- Is `a_mode' valid ?
		do
			Result := a_mode >= Run and a_mode <= step_out
		end

	Run: INTEGER = 1

	Step_into: INTEGER = 2
			-- Execution with flag 'step_into' set
			-- so that application knows it must stop to the next breakable statement

	Step_next: INTEGER = 3
			-- Execution with all breakable points of current
			-- routine set and a breakpoint set just after the
			-- calling routine (like step-out)

	Step_out: INTEGER = 4
			-- Execution with all breakable points set except
			-- those of the current routine.

;indexing
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

end -- class EXEC_MODES
