indexing
	description: "Generator for types of Help Project."
	date: "$Date$"
	revision: "$Revision$"

class
	HELP_GENERATOR
	
inherit	
	GENERATOR

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

	internal_generate is
			-- Generate `help_project'
		local
			l_html_help_project: HTML_HELP_PROJECT
			l_mshelp_project: MSHELP_PROJECT
		do
			update_progress_report
			l_html_help_project ?= project
			if l_html_help_project /= Void then
				generate_html_help (l_html_help_project)
			else
				l_mshelp_project ?= project
				if l_mshelp_project /= Void then
					generate_vsip_help (l_mshelp_project)
				end
			end
			update_progress_report
		end		

	generate_html_help (a_project: HTML_HELP_PROJECT) is
			-- Generate help for HTML HELP 1.x from `project'
		require
			project_not_void: a_project /= Void
		local
			l_project_file_path: FILE_NAME
			l_command: STRING
			l_src_file, l_dest_file: RAW_FILE
			l_constants: APPLICATION_CONSTANTS
		do
			l_constants := Shared_constants.Application_constants
			create l_project_file_path.make_from_string (project.project_file.name)
			change_working_directory (l_constants.Bin_directory)
			l_command := "hhc.exe "
			l_command.append ("%"")
			l_command.append (l_project_file_path)
			l_command.append ("%"")
			system (l_command)
			if not l_constants.Temporary_help_directory.out.is_equal (project.location.name) then
				create l_src_file.make (l_constants.Temporary_help_directory.out + "\" + project.name + "." + project.compiled_filename_extension)
				create l_dest_file.make_create_read_write (project.location.name + "\" + project.name + "." + project.compiled_filename_extension)
				l_dest_file.close
				if l_src_file.exists then
					copy_file (l_src_file, l_dest_file)
				end	
			end
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

	upper_range_value: INTEGER is
			-- Upper range
		do
			Result := 600
		end
		
	progress_title: STRING is
			-- Progress Title
		once
			Result := ((create {MESSAGE_CONSTANTS}).help_generation_progress_title)
		end

end -- class HELP_GENERATOR
