indexing
	description: "Application-wide constants."
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION_CONSTANTS

inherit
	EXECUTION_ENVIRONMENT

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
		
	parser_file_resources_directory: DIRECTORY_NAME is
			-- Directory holding all predefinde regular expression parser files
		once
			create Result.make_from_string (resources_directory)
			Result.extend ("parsers")
		end
		
	temporary_directory: DIRECTORY_NAME is
			-- Directory for temporary file generation
		once
			create Result.make_from_string ("C:")
			Result.extend ("doc_temp")
		end
		
	temporary_html_directory: DIRECTORY_NAME is
			-- Directory location for temporary HTML
		once
			create Result.make_from_string (Temporary_directory)
			Result.extend ("HTML")
		end
		
	temporary_xml_directory: DIRECTORY_NAME is
			-- Directory location for temporary XML
		once
			create Result.make_from_string (Temporary_directory)
			Result.extend ("XML")
		end
		
	temporary_help_directory: DIRECTORY_NAME is
			-- Directory location for temporary help files
		once
			create Result.make_from_string (Temporary_directory)
			Result.extend ("Help")
		end	
		
	script_output: PLAIN_TEXT_FILE is
			-- File containing output information regarding command prompt processing
		once
			create Result.make (application_root_directory.out + "\output_log.txt")
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
			create Result.make_with_rgb (0.0, 0.8, 0.0)
		end

feature -- Schema preferences			

	auto_validation: BOOLEAN
			-- Should document auto validate against schema
			-- during editing?

	output_list: ARRAYED_LIST [STRING] is
			-- List of possible output types
		once
			create Result.make (3)
			Result.compare_objects
			Result.extend ("all")
			Result.extend ("studio")
			Result.extend ("envision")
		end		

feature -- Table of Contents Preferences

	index_file_name: STRING
			-- File name to use for index/root nodes

	html_location: STRING
			-- Location of HTML from which TOC is generated
			
feature -- Status Setting

	set_gui_mode (a_mode: BOOLEAN) is
			-- Set `is_gui_mode'
		do
			is_gui_mode := a_mode	
		end

	set_html_location (a_location: STRING) is
			-- Set `html_location'
		do
			html_location := a_location	
		end		

	set_synchronize_document_widgets (a_flag: BOOLEAN) is
			-- Set 'synchronize_document_widgets'
		do
			synchronize_document_widgets := a_flag
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
		require
			flag_not_void: flag /= Void
		do
			auto_validation := flag
		ensure
			av_set: auto_validation = flag
		end

	set_tags_uppercase (flag: BOOLEAN) is
			-- Should XML tags be in uppercase?
		require
			flag_not_void: flag /= Void
		do
			tags_uppercase := flag
		ensure
			tags_set: tags_uppercase = flag
		end

feature -- Document
			
	synchronize_document_widgets: BOOLEAN
			-- Should widgets representing document views be in synch?		
			
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
			Result.extend ("unix")
			Result.extend ("classic")
			Result.extend (".net")
		end

end -- class APPLICATION_CONSTANTS
