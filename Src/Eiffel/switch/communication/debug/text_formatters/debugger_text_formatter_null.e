indexing
	description: "Routines for use by classes that need to display debugger related objects in TEXT_FORMATTER."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DEBUGGER_TEXT_FORMATTER_NULL

inherit
	DEBUGGER_TEXT_FORMATTER_VISITOR

feature -- Generic

	append_to (v: ABSTRACT_DEBUG_VALUE; st: TEXT_FORMATTER; indent: INTEGER) is
		do
		end

	append_type_and_value (v: ABSTRACT_DEBUG_VALUE; st: TEXT_FORMATTER) is
		do
		end

feature -- Application status

	append_status (appstatus: APPLICATION_STATUS; st: TEXT_FORMATTER) is
			-- Display the status of the running application.
		do
		end

	append_exception (appstatus: APPLICATION_STATUS; st: TEXT_FORMATTER) is
			-- Display exception in `st'.		
		do
		end

feature -- Call stack

	append_stack (ecs: EIFFEL_CALL_STACK; st: TEXT_FORMATTER) is
			-- Display callstack in `st'.
		do
		end

	append_arguments (cse: CALL_STACK_ELEMENT; st: TEXT_FORMATTER) is
			-- Display the arguments passed to the routine
			-- associated with Current call.
		do
		end

	append_locals (cse: CALL_STACK_ELEMENT; st: TEXT_FORMATTER) is
			-- Display the local entities and result (if it exists) of
			-- the routine associated with Current call.
		do
		end

	append_feature (cse: CALL_STACK_ELEMENT; st: TEXT_FORMATTER) is
			-- Display information about associated routine.
		do
		end

	append_debugger_information (dbg: DEBUGGER_MANAGER; st: TEXT_FORMATTER) is
			-- Display information about debugger
		do
		end

indexing
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
