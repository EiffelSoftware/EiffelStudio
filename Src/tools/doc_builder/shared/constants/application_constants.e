indexing
	description: "Application-wide constants."
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION_CONSTANTS

inherit
	EXECUTION_ENVIRONMENT
	
	CONSTANTS
		rename
			pixmap_directory as icon_resources_directory
		redefine
			icon_resources_directory
		end			

feature -- Directory Paths

	application_root_directory: DIRECTORY_NAME is
			-- Root working directory for application
		local
			l_path: STRING
		once
			l_path := get ("ISE_DOC_BUILDER")
			if l_path = Void then
				l_path := get ("ISE_EIFFEL")
			end
			if l_path /= Void then
				create Result.make_from_string (l_path)				
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
		
	output_filter: INTEGER
			-- Current output filter (default: all)

feature -- XSL Preferences

	is_studio: BOOLEAN is
			-- Is output filter for EiffelStudio?
		do
			Result := output_filter = Studio_filter
		end
		
	is_envision: BOOLEAN is
			-- Is output filter for Eiffel ENViSioN!?
		do
			Result := output_filter = Envision_filter
		end
		
	is_all: BOOLEAN is
			-- Is output filter unfiltered?
		do
			Result := output_filter = All_filter or (not is_studio or not is_envision)
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

	make_root_from_index: BOOLEAN
			-- Should TOC generation automatically make root nodes out of
			-- files matching `index_file_name'
		
	include_empty_directories: BOOLEAN
			-- Should TOC generation automatically skip empty directories
			-- and thus not include them in the final TOC?

	include_directories_no_index: BOOLEAN
			-- Should TOC generation automatically skip directories without index file?
			
	include_skipped_sub_directories: BOOLEAN
			-- Should sub-directories of not included directories in TOC be processed?
			
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

	set_include_empty_directories (a_flag: BOOLEAN) is
			-- Set `include_empty_directories'
		do
			include_empty_directories := a_flag
		end
	
	set_include_skipped_sub_directories (a_flag: BOOLEAN) is
			-- Set `include_skipped_sub_directories'
		do
			include_skipped_sub_directories := a_flag
		end
		
	set_include_directories_no_index (a_flag: BOOLEAN) is
			-- Set `include_directories_no_index'
		do
			include_directories_no_index := a_flag
		end
	
	set_make_index_root (a_flag: BOOLEAN) is
			-- Set `make_root_from_index'
		do
			make_root_from_index := a_flag
		end

	set_index_file_name (a_name: STRING) is
			-- Set `index_file_name'
		require
			name_valid: a_name /= Void and then not a_name.is_empty
		do
			index_file_name := a_name
		end		

	set_output_filter (a_filter: INTEGER) is
			-- Set output filter
		require
			valid_filter: a_filter = all_filter or a_filter = studio_filter or a_filter = envision_filter
		do
			if a_filter = all_filter then
				output_filter := all_filter
			elseif a_filter = studio_filter then				
				output_filter := studio_filter
			elseif a_filter = envision_filter then
				output_filter := envision_filter
			end
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

feature -- Implementation

	all_filter, studio_filter, envision_filter: INTEGER is unique

end -- class APPLICATION_CONSTANTS
