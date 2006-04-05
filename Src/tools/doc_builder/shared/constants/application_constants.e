indexing
	description: "Application-wide constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION_CONSTANTS

inherit
	EXECUTION_ENVIRONMENT

	SHARED_OBJECTS

feature -- Directory Paths

	application_root_directory: DIRECTORY_NAME is
			-- Root working directory for application
		local
			l_path: STRING
		once
			l_path := get ("EIFFEL_SRC")
 			if l_path /= Void then
          		create Result.make_from_string (l_path)	
           		Result.extend ("tools")
             	Result.extend ("doc_builder")						
          	else
				create Result.make_from_string ((create {EXECUTION_ENVIRONMENT}).current_working_directory)
			end
		end

	resources_directory: DIRECTORY_NAME is
			-- Directory holding all application resources
		once
			create Result.make_from_string (application_root_directory)
			Result.extend ("resources")
		end
		
	bin_directory: DIRECTORY_NAME is
			-- Directory holding binaries
		once
			create Result.make_from_string (resources_directory)
			Result.extend ("bin")
		end

	syntax_files_directory: DIRECTORY_NAME is
			-- Directory holding syntax files
		once
			create Result.make_from_string (resources_directory)
			Result.extend ("syntax_definitions")
		end

	documentation_directory: DIRECTORY_NAME is
			-- Directory holding documentation
		once
			create Result.make_from_string (application_root_directory)
			Result.extend ("documentation")
		end

	templates_path: DIRECTORY_NAME is
			-- Path to folder containing template files
		once
			create Result.make_from_string (resources_directory)
			Result.extend ("templates")
		end

	icon_resources_directory: DIRECTORY_NAME is
			-- Directory holding all graphical icons
		once
			create Result.make_from_string (Resources_directory)
			Result.extend ("icons")
		end

	cursor_resources_directory: DIRECTORY_NAME is
			-- Directory holding all cursor
		once
			create Result.make_from_string (Resources_directory)
			Result.extend ("cursors")
		end
		
	parser_file_resources_directory: DIRECTORY_NAME is
			-- Directory holding all predefinde regular expression parser files
		once
			create Result.make_from_string (resources_directory)
			Result.extend ("parsers")
		end
		
	temporary_directory: DIRECTORY_NAME is
			-- Directory for temporary file generation
		do
			create Result.make_from_string (shared_preferences.tool_data.output_directory)
		end
		
	temporary_html_directory: DIRECTORY_NAME is
			-- Directory location for temporary HTML
		do
			create Result.make_from_string (Temporary_directory)
			Result.extend ("HTML")
		end
		
	temporary_xml_directory: DIRECTORY_NAME is
			-- Directory location for temporary XML
		do
			create Result.make_from_string (Temporary_directory)
			Result.extend ("XML")
		end
		
	temporary_help_directory: DIRECTORY_NAME is
			-- Directory location for temporary help files
		do
			create Result.make_from_string (Temporary_directory)
			Result.extend ("Help")
		end	
		
	script_output: PLAIN_TEXT_FILE is
			-- File containing output information regarding command prompt processing
		local
			l_filename: FILE_NAME
		once
			create l_filename.make_from_string (application_root_directory.out)
			l_filename.extend ("output_log.txt")
			create Result.make (l_filename.string)
			if not Result.exists then
				Result.create_read_write
				Result.close
			end
			Result.open_append
			Result.putstring ((create {MESSAGE_CONSTANTS}).output_report_header)
			Result.close
		end		
		
feature -- Display Constants		

	is_gui_mode: BOOLEAN
			-- Is application in GUI or command prompt mode?

	error_color: EV_COLOR is
			-- Color for error messages
		once
			create Result.make_with_rgb (1.0, 0.0, 0.0)
		end
		
	no_error_color: EV_COLOR is
			-- Color for non-error messages
		once
			create Result.make_with_rgb (0.0, 0.0, 0.0)
		end

feature -- Schema preferences			

	auto_validation: BOOLEAN
			-- Should document auto validate against schema
			-- during editing?

feature -- Table of Contents Preferences

	index_file_name: STRING
			-- File name to use for index/root nodes
			
	code_directories: ARRAYED_LIST [STRING] is
			-- Directories containing code XML.  Output specific to output type.
		local
			l_project_root,
			l_code_dir: FILE_NAME
			l_proj: DOCUMENT_PROJECT
		once
			create Result.make (10)
			Result.compare_objects
			l_proj := (create {SHARED_OBJECTS}).shared_project
			create l_project_root.make_from_string (l_proj.root_directory)
			
			l_project_root.extend ("libraries")
				-- Base
			create l_code_dir.make_from_string (l_project_root.string)
			l_code_dir.extend ("base")
			l_code_dir.extend ("reference")
			Result.extend (l_code_dir.string)
			
				-- Wel
			create l_code_dir.make_from_string (l_project_root.string)
			l_code_dir.extend ("wel")			
			l_code_dir.extend ("reference")
			Result.extend (l_code_dir.string)
			
				-- Vision2
			create l_code_dir.make_from_string (l_project_root.string)
			l_code_dir.extend ("vision2")
			l_code_dir.extend ("reference")
			Result.extend (l_code_dir.string)

				-- Lex
			create l_code_dir.make_from_string (l_project_root.string)
			l_code_dir.extend ("lex")
			l_code_dir.extend ("reference")
			Result.extend (l_code_dir.string)
			
				-- Parse
			create l_code_dir.make_from_string (l_project_root.string)
			l_code_dir.extend ("parse")
			l_code_dir.extend ("reference")
			Result.extend (l_code_dir.string)
			
				-- COM
			create l_code_dir.make_from_string (l_project_root.string)			
			l_code_dir.extend ("com")
			l_code_dir.extend ("reference")
			Result.extend (l_code_dir.string)
			
				-- Java
			create l_code_dir.make_from_string (l_project_root.string)
			l_code_dir.extend ("eiffel2java")
			l_code_dir.extend ("reference")
			Result.extend (l_code_dir.string)			
			
				-- Net	
			create l_code_dir.make_from_string (l_project_root.string)
			l_code_dir.extend ("net")			
			l_code_dir.extend ("reference")
			Result.extend (l_code_dir.string)
			
				-- Time
			create l_code_dir.make_from_string (l_project_root.string)			
			l_code_dir.extend ("time")
			l_code_dir.extend ("reference")
			Result.extend (l_code_dir.string)
			
				-- Web
			create l_code_dir.make_from_string (l_project_root.string)
			l_code_dir.extend ("web")
			l_code_dir.extend ("reference")
			Result.extend (l_code_dir.string)
			
				-- Store
			create l_code_dir.make_from_string (l_project_root.string)
			l_code_dir.extend ("store")
			l_code_dir.extend ("reference")
			Result.extend (l_code_dir.string)
			
				-- Thread
			create l_code_dir.make_from_string (l_project_root.string)
			l_code_dir.extend ("thread")
			l_code_dir.extend ("reference")
			Result.extend (l_code_dir.string)

				-- Preferences
			create l_code_dir.make_from_string (l_project_root.string)
			l_code_dir.extend ("preferences")
			l_code_dir.extend ("reference")
			Result.extend (l_code_dir.string)
		end
			
	studio_libraries: ARRAYED_LIST [STRING] is
			-- Studio libraries
		once
			create Result.make (10)
			Result.compare_objects
			Result.extend ("base")
			Result.extend ("wel")
			Result.extend ("vision2")
			Result.extend ("time")
			Result.extend ("web")
			Result.extend ("net")
			Result.extend ("com")
			Result.extend ("lex")
			Result.extend ("parse")
			Result.extend ("eiffel2java")
			Result.extend ("store")
			Result.extend ("thread")
			Result.extend ("preferences")
		end
	
	envision_libraries: ARRAYED_LIST [STRING] is
			-- ENViSioN! libraries
		once
			create Result.make (10)
			Result.compare_objects
			Result.extend ("base")
			Result.extend ("lex")
			Result.extend ("net")
			Result.extend ("parse")
			Result.extend ("store")
			Result.extend ("thread")
			Result.extend ("time")
			Result.extend ("wel")
			Result.extend ("vision2")
		end	
			
feature -- Status Setting

	set_gui_mode (a_mode: BOOLEAN) is
			-- Set `is_gui_mode'
		do
			is_gui_mode := a_mode	
		end	

	set_index_file_name (a_name: STRING) is
			-- Set `index_file_name'
		require
			name_valid: a_name /= Void and then not a_name.is_empty
		do
			index_file_name := a_name
		end		

	set_auto_validation (flag: BOOLEAN) is
			-- Should documents be auto validated?
		do
			auto_validation := flag
		ensure
			av_set: auto_validation = flag
		end

	set_tags_uppercase (flag: BOOLEAN) is
			-- Should XML tags be in uppercase?
		do
			tags_uppercase := flag
		ensure
			tags_set: tags_uppercase = flag
		end

	add_code_directory (a_dir_name: STRING) is
			-- Add to `code_directories'
		do
			code_directories.extend (a_dir_name)	
		end		

	set_is_include_list (a_mode: BOOLEAN) is
			-- Set `is_include_list'
		do
			is_include_list := a_mode	
		end	

feature -- Document
			
	tags_uppercase: BOOLEAN
			-- Should element tags be uppercase?			

feature -- Platform

	set_mode (a_mode: STRING) is
			-- Set `mode'
		require
			mode_not_void: a_mode /= Void
			mode_valid: available_modes.has (a_mode)
		once
			mode := a_mode
		ensure
			mode_is_mode: mode = A_mode
		end

	mode: STRING
			-- Platform mode

	available_modes: ARRAYED_LIST [STRING] is
			-- Available platform modes
		once
			create Result.make (3)
			Result.compare_objects
			Result.extend ("classic")
			Result.extend (".net")
		end

feature -- Access 

	allowed_file_types: ARRAYED_LIST [STRING] is
			-- List of recognized file types in application with appropriate icon identifier
		once
			create Result.make (9)
			Result.compare_objects
			Result.extend ("xml")
			Result.extend ("htm")
			Result.extend ("html")
			Result.extend ("png")
			Result.extend ("gif")
			Result.extend ("jpg")
			Result.extend ("css")
			Result.extend ("js")
			Result.extend ("ico")
			Result.extend ("bmp")
		end	

	file_type_icons: HASH_TABLE [EV_PIXMAP, STRING] is
			-- Hash of recognized file types in application with appropriate icon identifier
		local
			l_graphical_constants: GRAPHICAL_CONSTANTS
		once
			create l_graphical_constants
			create Result.make (3)
			Result.compare_objects
			Result.extend (l_graphical_constants.xml_file_icon, "xml")
			Result.extend (l_graphical_constants.html_file_icon, "htm")
			Result.extend (l_graphical_constants.html_file_icon, "html")
			Result.extend (l_graphical_constants.png_file_icon, "png")
			Result.extend (l_graphical_constants.gif_file_icon, "gif")
			Result.extend (l_graphical_constants.jpg_file_icon, "jpg")
			Result.extend (l_graphical_constants.css_file_icon, "css")
			Result.extend (l_graphical_constants.js_file_icon, "js")
			Result.extend (l_graphical_constants.png_file_icon, "bmp")
		end	

	is_include_list: BOOLEAN;

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
end -- class APPLICATION_CONSTANTS
