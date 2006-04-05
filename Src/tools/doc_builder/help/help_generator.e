indexing
	description: "Generator for types of Help Project."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	HELP_GENERATOR
	
inherit
	EXECUTION_ENVIRONMENT

	SHARED_OBJECTS
	
	UTILITY_FUNCTIONS

create
	make
	
feature -- Creation

	make (help_project: HELP_PROJECT) is
			-- Make with `help_project'
		require
			project_not_void: help_project /= Void
		do
			project := help_project
		ensure
			has_project: project /= Void
		end		

feature -- Generation

	generate is
			-- Generate `help_project'
		local
			l_constants: APPLICATION_CONSTANTS
			l_html_help_project: HTML_HELP_PROJECT
			l_web_help_project: WEB_HELP_PROJECT
			l_mshelp_project: MSHELP_PROJECT			
			l_html_dir, l_help_dir: DIRECTORY			
			l_src_file, l_dest_file: RAW_FILE
			l_src_name, l_dest_name: FILE_NAME
		do		
				-- Generate the project
			l_html_help_project ?= project
			if l_html_help_project /= Void then				
				generate_html_help (l_html_help_project)
			else
				l_mshelp_project ?= project
				if l_mshelp_project /= Void then
					generate_vsip_help (l_mshelp_project)
				else
					l_web_help_project ?= project
					if l_web_help_project /= Void then
						generate_web_help (l_web_help_project)
						create l_html_dir.make (Shared_constants.Application_constants.Temporary_html_directory)
						create l_help_dir.make (Shared_constants.Application_constants.Temporary_help_directory)
						copy_directory (l_html_dir, l_help_dir)
					end
				end
			end
					-- Copy generated help project file to required path
			create l_constants
			if not l_constants.Temporary_help_directory.out.is_equal (project.location.name) then										
				create l_src_name.make_from_string (l_constants.Temporary_help_directory.out)
				l_src_name.extend (project.name)
				l_src_name.add_extension (project.compiled_filename_extension)
				create l_dest_name.make_from_string (project.location.name)
				l_dest_name.extend (project.name)
				l_dest_name.add_extension (project.compiled_filename_extension)
			
				create l_src_file.make (l_src_name)
				create l_dest_file.make (l_dest_name)
				if l_src_file.exists then
					copy_file (l_src_file, l_dest_file)
				end	
			end
		end		

	generate_html_help (a_project: HTML_HELP_PROJECT) is
			-- Generate help for HTML HELP 1.x from `project'
		require
			project_not_void: a_project /= Void
		local
			l_project_file_path: FILE_NAME
			l_command,
			old_path: STRING
			l_constants: HELP_SETTING_CONSTANTS
			l_dir: DIRECTORY
		do		
			l_constants := Shared_constants.Help_constants
			create l_project_file_path.make_from_string (project.project_file.name)
			
			if shared_constants.help_constants.compile then
						-- Change to executable directory								
				old_path := current_working_directory
				create l_dir.make (l_constants.help_compiler_location.string)
				if l_dir.exists then				
					change_working_directory (l_dir.name)	
				end
				l_command := l_constants.help_compiler_name
				l_command.append (" %"")
				l_command.append (l_project_file_path)
				l_command.append ("%"")
				
						-- Execute HTML Help compiler
				system (l_command)
				if return_code /= 0 then
					io.putstring ("Complete.  HTML Help return code is " + return_code.out + ".")
				end
				
				change_working_directory (old_path)
			end
		end
		
	generate_vsip_help (a_project: MSHELP_PROJECT) is
			-- Generate help for MS HELP 2.0 for Visual Studio Integration
			-- from `project'
		do
			a_project.generate
		end

	generate_web_help (a_project: WEB_HELP_PROJECT) is
			-- Generate help for web
		do
			a_project.generate
		end

feature {NONE} -- Implementation

	project: HELP_PROJECT;
			-- Project

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
end -- class HELP_GENERATOR
