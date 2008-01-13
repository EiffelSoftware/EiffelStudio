indexing
	description: "[
		Place where all the onces of the compiler that needs to be set differently depending
		on the version of the compiler being compiled. 
		If not used, then the compiler will use the default settings (usually for batch compilation).
		
		Note: some inheritance clauses are not used, they are here to show which settings
		the compiler may modify by using the mentioned classes.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SETTABLE_COMPILER_OBJECTS

inherit
	SHARED_NAMES_HEAP

	SHARED_COMPILER_PREFERENCES

feature -- Access

	command_executor: COMMAND_EXECUTOR is
			-- Objects that launches commands.
		do
			Result := command_executor_cell.item
		ensure
			command_executor_not_void: Result /= Void
		end

feature -- Settings

	set_command_executor (c: like command_executor) is
			-- Set `command_executor' with `c'.
		require
			c_not_void: c /= Void
		do
			command_executor_cell.put (c)
		ensure
			command_executor_set: command_executor = c
		end

feature {NONE} -- Implementation

	command_executor_cell: CELL [COMMAND_EXECUTOR] is
			-- Storage for `command_executor'.
		once
			create Result
			Result.put (create {COMMAND_EXECUTOR})
		ensure
			command_executor_cell_not_void: Result /= Void
			command_executor_not_void: Result.item /= Void
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
