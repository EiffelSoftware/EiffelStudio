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
			
	is_tree_web_help: BOOLEAN
			-- Is web help for a tree toc?
			
	toc: TABLE_OF_CONTENTS
			-- Table of Contents
			
	help_project_name: STRING
			-- Name chosen for help project

	toc_is_physical: BOOLEAN
			-- Table of Contents is generated from a physical location on 
			-- disk rather than other structure such as tree widget or XML file

	compile: BOOLEAN
			-- Should HTML Help be compiled?

feature -- Path Locations
		
	help_compiler_location: FILE_NAME is
			-- Location of HTML Help 1.x compiler executable
		do
		end		
		
	help_compiler_name: STRING is
			-- Name of HTML Help 1.x compiler executable
		once
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
	
	set_help_toc (a_toc: like toc) is
			-- Set Table of Contents
		do
			toc := a_toc
		end
		
	set_compile (a_flag: BOOLEAN) is
			-- Set compile option
		do
			compile := a_flag
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
			when web_help_tree then
				is_html_help := False
				is_vsip_help := False
				is_web_help := True
				is_tree_web_help := True
			when web_help_simple then				
				is_html_help := False
				is_vsip_help := False
				is_web_help := True
				is_tree_web_help := False
			end
		end			
		
feature -- Implementation

	html_help,
	vsip_help,
	web_help_tree,
	web_help_simple: INTEGER is unique
			-- Transformation type chosen identifier
		
invariant
	html_help_exclusive: is_html_help implies (not is_vsip_help and not is_web_help)
	vsip_help_exclusive: is_vsip_help implies (not is_html_help and not is_web_help)
	web_help_exclusive: is_web_help implies (not is_vsip_help and not is_html_help)

end -- class HELP_SETTING_CONSTANTS
