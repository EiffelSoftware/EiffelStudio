indexing
	description: "Validity errors by id"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_VALIDITY_STATUS_IDS

feature -- Access

	Eiffel_project, Ace_file, Eiffel_class, Eiffel_cluster,
	Component_definition_file, Destination_folder, Project_name, End_id: INTEGER is unique
			-- ids
	
	errors: ARRAY [STRING] is
			-- Error messages
		once
			create Result.make (1, 10)
			Result.put ("Path to Eiffel project file is invalid", Eiffel_project)
			Result.put ("Path to Eiffel project ACE file is invalid", Ace_file)
			Result.put ("Not a valid Eiffel class name", Eiffel_class)
			Result.put ("Not a valid Eiffel cluster name", Eiffel_cluster)
			Result.put ("Path to component definition file is invalid", Component_definition_file)
			Result.put ("Missing destination folder", Destination_folder)
			Result.put ("Project name contains invalid characters", Project_name)
		end

feature -- Status Report

	is_valid_status_id (a_id: INTEGER): BOOLEAN is
			-- Is `a_id' a valid status id?
		do
			Result := a_id > 0 and a_id < End_id
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
