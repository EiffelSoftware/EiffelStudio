indexing
	description: "Generator for types of Help Project."
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
			l_mshelp_project: MSHELP_PROJECT			
			l_html_dir, l_help_dir: DIRECTORY			
			l_src_file, l_dest_file: RAW_FILE
			l_src_name, l_dest_name: FILE_NAME
		do		
					-- First copy the HTML files in to a sub-directory of the Help project.  This
					-- must be done because HTML Help 1.x won't compile in HTML files which are not
					-- outside the directory hierarchy of the project.  It also ensures we know exactly
					-- where all the files which should be included in the new help project are located.
			create l_html_dir.make (Shared_constants.Application_constants.Temporary_html_directory)
			create l_help_dir.make (Shared_constants.Application_constants.Temporary_help_directory)
			copy_directory (l_html_dir, l_help_dir)
		
			l_html_help_project ?= project
			if l_html_help_project /= Void then				
				generate_html_help (l_html_help_project)
			else
				l_mshelp_project ?= project
				if l_mshelp_project /= Void then
					generate_vsip_help (l_mshelp_project)
				end
			end
			
					-- Copy new Help files to required path
			create l_constants
			if not l_constants.Temporary_help_directory.out.is_equal (project.location.name) then										
				create l_src_name.make_from_string (l_constants.Temporary_help_directory.out)
				l_src_name.extend (project.name)
				l_src_name.add_extension (project.compiled_filename_extension)
				l_dest_name.make_from_string (project.location.name)
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
			l_command: STRING
			l_constants: HELP_SETTING_CONSTANTS
		do		
			l_constants := Shared_constants.Help_constants
			create l_project_file_path.make_from_string (project.project_file.name)
					-- Change to executable directory			
			change_working_directory (l_constants.help_compiler_location.string)
			l_command := l_constants.help_compiler_name
			l_command.append (" %"")
			l_command.append (l_project_file_path)
			l_command.append ("%"")
					-- Execute HTML Help compiler
			system (l_command)			
		end
		
	generate_vsip_help (a_project: MSHELP_PROJECT) is
			-- Generate help for MS HELP 2.0 for Visual Studio Integration
			-- from `project'
		do
			a_project.generate
		end

feature {NONE} -- Implementation

	project: HELP_PROJECT
			-- Project

end -- class HELP_GENERATOR
