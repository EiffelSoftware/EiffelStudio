indexing
	description: "Constants for Help generation"
	date: "$Date$"
	revision: "$Revision$"

class
	HELP_SETTING_CONSTANTS

inherit
	APPLICATION_CONSTANTS

feature -- Access

	is_html_help: BOOLEAN
			-- Is Microsoft HTML Help 1.x?
			
	is_vsip_help: BOOLEAN
			-- Visual Studio .NET Integration help?
			
	is_web_help: BOOLEAN
			-- Help for web page content?
			
	toc: XML_TABLE_OF_CONTENTS
			-- Table of Contents
			
	help_project_name: STRING
			-- Name chosen for help project

	toc_is_physical: BOOLEAN
			-- Table of Contents is generated from a physical location on 
			-- disk rather than other structure such as tree widget or XML file

feature -- Path Locations

	help_directory: DIRECTORY_NAME is
			-- Root directory for help generation	
		do
			Result := help_directory_cell.item
		end

	toc_path: DIRECTORY_NAME is
			-- Path to TOC directory
		once
			create Result.make_from_string (Temporary_help_directory)
			Result.extend ("toc")
		end
		
	help_compiler_location: FILE_NAME is
			-- Location of HTML Help 1.x compiler executable
		local
			l_registry: WEL_REGISTRY
			l_key_value: WEL_REGISTRY_KEY_VALUE
			l_reg_key_ptr: POINTER
		do
			create l_registry
			l_reg_key_ptr := l_registry.open_key (feature {WEL_HKEY}.hkey_local_machine, "Software\Microsoft\Windows\CurrentVersion", feature {WEL_REGISTRY_ACCESS_MODE}.key_query_value)
			l_key_value := l_registry.key_value (l_reg_key_ptr, "ProgramFilesDir")
			if l_key_value /= void then
				create Result.make_from_string (l_key_value.string_value)
				Result.extend ("HTML Help Workshop")
			end
		end		
		
	help_compiler_name: STRING is
			-- Name of HTML Help 1.x compiler executable
		once
			Result := "hhc.exe"
		end		
		
feature -- XML Tags

	directory_tag: STRING is "working_directory"

	help_project_tag: STRING is "help_project"
	
	name_tag: STRING is "name"
	
	title_tag: STRING is "title"
	
	files_tag: STRING is "files"
	
	project_file_tag: STRING is "project_file"
	
	compiled_file_tag: STRING is "compiled_file"
	
	toc_file_tag: STRING is "table_of_contents"
	
	log_file_tag: STRING is "log_file"

feature -- Status Setting

	set_help_directory (a_dir: DIRECTORY_NAME) is
			-- Set root location for help project generation
		require
			directory_not_void: a_dir /= Void
			directory_valid: (create {DIRECTORY}.make (a_dir)).exists
		do
			help_directory_cell.put (a_dir)		
		end
	
	set_help_toc (a_toc: like toc) is
			-- Set Table of Contents
		do
			toc := a_toc
		end
		
	set_help_project_name (a_name: STRING) is
			-- Set name for help project
		do
			help_project_name := a_name
		end	
		
	set_help_type (a_type: INTEGER) is
			-- Set chosen help generation type
		do
			inspect
				a_type
			when html_help then
				is_html_help := True
				is_vsip_help := False
				is_web_help := False
			when vsip_help then
				is_html_help := False
				is_vsip_help := True
				is_web_help := False
			when web_help then
				is_html_help := False
				is_vsip_help := False
				is_web_help := True
			end
		end	
		
	set_toc_is_physical	(a_flag: BOOLEAN) is
			-- Set `toc_is_physical'
		do
			toc_is_physical := a_flag	
		end		
		
feature -- Implementation

	html_help,
	vsip_help,
	web_help: INTEGER is unique
			-- Transformation type chosen identifier

	help_directory_cell: CELL [DIRECTORY_NAME] is
			-- Once cell containing help directory name
		once
			create Result			
		end
		
invariant
	html_help_exclusive: is_html_help implies (not is_vsip_help and not is_web_help)
	vsip_help_exclusive: is_vsip_help implies (not is_html_help and not is_web_help)
	web_help_exclusive: is_web_help implies (not is_vsip_help and not is_html_help)

end -- class HELP_SETTING_CONSTANTS
