indexing
	description: "[
			Message to be print when Current is reached.
			If Void, no message is printed.
			 You can include value of expression in the message
			 by placing it in curly braces , such as "value of x is {x}."
			 to insert a curly braces, use "\{" to insert a backslash use "\\"
			 Special keywords:
				$ADDRESS
				$CALLSTACK - Current call stack
				$FEATURE - Current feature name
				$THREADID - Current thread id	
				...
	]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BREAKPOINT_WHEN_HITS_ACTION_PRINT_MESSAGE

inherit
	BREAKPOINT_WHEN_HITS_ACTION_I

create
	make

feature {NONE} -- Initialization

	make (a_message: STRING) is
		do
			set_message (a_message)
		end

feature -- Access

	message: STRING

feature -- Change

	set_message (v: like message) is
		do
			if v = Void or else v.is_empty then
				message := Void
			else
				message := v
			end
		end

feature -- Execute

	execute (a_bp: BREAKPOINT; a_dm: DEBUGGER_MANAGER) is
		do
			if message /= Void then
				a_dm.debugger_message (a_dm.computed_breakpoint_message (a_bp, message))
			end
		end

indexing
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
