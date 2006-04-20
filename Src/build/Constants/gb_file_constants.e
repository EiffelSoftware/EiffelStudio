indexing
	description: "Objects that contain constants for file handling."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_FILE_CONSTANTS

feature -- Generation constants

	template_file_location: FILE_NAME is
			-- Location of templates.
		do
			create Result.make_from_string ((create {GB_EIFFEL_ENV}).Eiffel_installation_dir_name)		
			Result.extend ("build")
			Result.extend ("templates")
		end
		
	window_template_file_name: FILE_NAME is
			-- `Result' is location of build template file,
			-- including the name.
		do
			Result := template_file_location
			Result.extend ("build_class_template.e")
		end
		
	window_template_imp_file_name: FILE_NAME is
			-- `Result' is location of build template file,
			-- including the name.
		do
			Result := template_file_location
			Result.extend ("build_class_template_imp.e")
		end
		
	constants_template_imp_file_name: FILE_NAME is
			-- `Result' is location of build constants implementation template file,
			-- including name.
		do
			Result := template_file_location
			Result.extend ("constants_imp.e")
		end
		
	constants_template_file_name: FILE_NAME is
			-- `Result' is location of build constants template file,
			-- including name.
		do
			Result := template_file_location
			Result.extend ("constants.e")
		end
		
	application_template_file_name: FILE_NAME is
			-- `Result' is location of build application template file,
			-- including the name.
		do
			Result := template_file_location
			Result.extend ("build_application_template.e")
		end
		
	windows_ace_file_name: FILE_NAME is
			-- `Result' is location of windows ace file template.
		do
			Result := template_file_location
			Result.extend ("Windows")
			Result.extend ("ace_template.ace")
		end
		
	unix_ace_file_name: FILE_NAME is
			-- `Result' is location of windows ace file template.
		do
			Result := template_file_location
			Result.extend ("Unix")
			Result.extend ("ace_template.ace")
		end
		
	dotnet_ace_file_name: FILE_NAME is
			-- `Result' is location of dotnet ace file template.
		do
			Result := template_file_location
			Result.extend ("Windows")
			Result.extend ("dotnet_ace_template.ace")
		end
		
	eiffel_class_extension: STRING is ".e"
			-- String constant for class file extension to be used.

feature -- XML saving
		
	unix_ace_name: STRING is "ace.Unix.ace"
	
	windows_ace_name: STRING is "ace.Windows.ace"
	
	dotnet_ace_name: STRING is "ace.dotNet.ace"
		
	project_filename: STRING is "build_project.bpr"
		-- File name for project settings.
		
	project_file_filter: STRING is "*.bpr"
		-- Filter to be used for file dialogs searching
		-- for build projects.
		
	xml_format: STRING is "<?xml version=%"1.0%" encoding=%"UTF-8%"?>";
		-- XML format type, included at start of `document'.
			
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


end -- class GB_FILE_CONSTANTS
