indexing
	description: "Project Manager for testing purposes"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TESTING_PROJECT_MANAGER

inherit
	PROJECT_MANAGER
		redefine
			compiler
		end
	
	COMPILER_TESTER_SHARED

		
create
	make
	
feature -- Access

	compiler: IEIFFEL_COMPILER_INTERFACE is
			-- retrieve compiler
		local
			l_compiler: COMPILER
		do
			l_compiler ?= Precursor {PROJECT_MANAGER}
			l_compiler.set_output_to_console
			Result := l_compiler
		end
		
	
feature -- Basic Operations

	reload_ace_project: BOOLEAN is
			-- reload ace file project
		require
			project_already_loaded: project_loaded
		do
			-- reset flags
			project_loaded_internal.set_item (False)
			Valid_project_ref.set_item (False)
			Result := load_Ace_project (ace_filename)
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
end -- class TESTING_PROJECT_MANAGER
