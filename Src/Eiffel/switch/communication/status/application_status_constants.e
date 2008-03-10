indexing

	description:
		"Constants used in Application Status information "
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class
	APPLICATION_STATUS_CONSTANTS

inherit
	APPLICATION_STATUS_EXPORTER

feature {APPLICATION_STATUS_EXPORTER} -- Constants

	Pg_raise: INTEGER = 1
			-- Explicitely raised exception

	Pg_viol: INTEGER = 2
			-- Implicitely raised exception

	Pg_break: INTEGER = 3
			-- Breakpoint reached

	Pg_interrupt: INTEGER = 4
			-- System execution interrupted

	Pg_update_breakpoint: INTEGER = 5
			-- Breakpoints changed while running. The application should stop
			-- to record the change in breakpoints.
			-- (mainly for classic debugger)

	Pg_step: INTEGER = 6
			-- The application completed a step operation.

	Pg_overflow: INTEGER = 7
			-- The application might run into a stack overflow.

	Pg_catcall: INTEGER = 8
			-- The application ran into a catcall.

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

end
