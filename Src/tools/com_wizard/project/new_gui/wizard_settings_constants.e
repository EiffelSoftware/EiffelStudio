indexing
	description: "Constants used to save settings"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_SETTINGS_CONSTANTS

feature -- Access

	Project_type_key: STRING is "Project_type_key"
			-- Project type key used to store project type settings
	
	Component_type_key: STRING is "Component_type_key"
			-- Component type key used to store component type settings

	Compile_target_key: STRING is "Compile_target_key"
			-- Compile target key used to store compile target settings
	
	Backup_key: STRING is "Backup_key"
			-- Key to store whether EiffelCOM wizard should backup overwritten files

	Overwrite_key: STRING is "Overwrite_key"
			-- Key to store whether EiffelCOM wizard should overwrite generated files

	Marshaller_key: STRING is "Marshaller_key"
			-- Key to store whether EiffelCOM wizard should generate and use marshaller

	Eiffel_project_code: STRING is "Eiffel"
			-- String encoding for Eiffel project
	
	Server_project_code: STRING is "Server"
			-- String encoding for COM Server project
	
	Client_project_code: STRING is "Client"
			-- String encoding for COM client project

	In_process_code: STRING is "InProcess"
			-- String encoding for in-process component

	Out_of_process_code: STRING is "OutOfProc"
			-- String encoding for out-of-process component

	Both_compile_code: STRING is "Both"
			-- String encoding for not compiling C nor Eiffel code

	C_compile_code: STRING is "C"
			-- String encoding for not compiling Eiffel code

	None_code: STRING is "None"
			-- String encoding for compiling C and Eiffel code

	True_code: STRING is "True";
			-- String encoding for backuping overwritten files

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
end -- class WIZARD_SETTINGS_CONSTANTS
