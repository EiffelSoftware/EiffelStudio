indexing
	description: "Project preferences."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_PROJECT_PREFERENCES
	
inherit	
	DOCUMENT_PROJECT_XML_TAGS
	
	XML_ROUTINES

	UTILITY_FUNCTIONS

create
	make

feature -- Initialization

	make (a_project: DOCUMENT_PROJECT) is
			-- Create from project
		require
			project_not_void: a_project /= Void
		do
			project := a_project
			initialize
		ensure
			has_project: project /= Void
		end

	initialize is
			-- Initialize with default values
		do
			process_includes := True
			process_header := True
			use_header_file := False
			override_file_header_declarations := True
			process_footer := True	
			use_footer_file := False
			override_file_footer_declarations := True
			include_navigation_links := True
			generate_dhtml_filter := True
			process_html_stylesheet := True
			generate_feature_nodes := True
		end			

feature -- Access

	is_valid: BOOLEAN is
			-- Are loaded preferences valid?
		do
			Result := project.name /= Void and project.root_directory /= Void 
		end

feature -- Basic operations

	read is
			-- Read preferences from file
		local
			l_error_report: ERROR_REPORT
		do
			document := deserialize_document (create {FILE_NAME}.make_from_string (project.file.name))
			if document /= Void then
				process_element (document.root_element)				
			end
				
			if not is_valid then
				create l_error_report.make ("Could not load project.")
				error_description := "The project file is invalid."
				l_error_report.append_error (create {ERROR}.make (error_description))
				l_error_report.show
			end			
		end
		
	write is
			-- Write preferences to disk
		local
			l_root, l_element: XM_ELEMENT
			l_ns: XM_NAMESPACE
		do
			if document = Void then
				create document.make
			else
				document.wipe_out
			end
			
			create l_ns.make_default
			create l_root.make_root (document, project_tag, l_ns)
			document.put_first (l_root)

				-- Name
			create l_element.make (l_root, project_name_tag, l_ns)
			l_element.put_first (create {XM_CHARACTER_DATA}.make (l_element, project.name))
			l_root.put_last (l_element)
			
				-- Location
			create l_element.make (l_root, root_directory_tag, l_ns)
			l_element.put_first (create {XM_CHARACTER_DATA}.make (l_element, project.root_directory))
			l_root.put_last (l_element)
			
				-- Schema
			if project.Shared_document_manager.has_schema then
				create l_element.make (l_root, schema_file_tag, l_ns)
				l_element.put_first (create {XM_CHARACTER_DATA}.make (l_element, project.Shared_document_manager.schema.name))
				l_root.put_last (l_element)
			end
			
				-- HTML Stylesheet
			if project.Shared_document_manager.has_stylesheet then
				create l_element.make (l_root, html_stylesheet_file_tag, l_ns)
				l_element.put_first (create {XM_CHARACTER_DATA}.make (l_element, project.Shared_document_manager.stylesheet.name))
				l_root.put_last (l_element)
			end

				-- Header
			if header_name /= Void then
				create l_element.make (l_root, header_file_tag, l_ns)
				l_element.put_first (create {XM_CHARACTER_DATA}.make (l_element, header_name))
				l_root.put_last (l_element)
			end			
			
			create l_element.make (l_root, header_file_override_tag, l_ns)
			l_element.put_first (create {XM_CHARACTER_DATA}.make (l_element, override_file_header_declarations.out))
			l_root.put_last (l_element)
			
			create l_element.make (l_root, use_header_file_tag, l_ns)
			l_element.put_first (create {XM_CHARACTER_DATA}.make (l_element, use_header_file.out))
			l_root.put_last (l_element)
			
				-- Footer
			if footer_name /= Void then
				create l_element.make (l_root, footer_file_tag, l_ns)
				l_element.put_first (create {XM_CHARACTER_DATA}.make (l_element, footer_name))
				l_root.put_last (l_element)
			end

			create l_element.make (l_root, footer_file_override_tag, l_ns)
			l_element.put_first (create {XM_CHARACTER_DATA}.make (l_element, override_file_footer_declarations.out))
			l_root.put_last (l_element)
			
			create l_element.make (l_root, use_footer_file_tag, l_ns)
			l_element.put_first (create {XM_CHARACTER_DATA}.make (l_element, use_footer_file.out))
			l_root.put_last (l_element)
		
				-- Includes
			create l_element.make (l_root, process_includes_tag, l_ns)
			l_element.put_first (create {XM_CHARACTER_DATA}.make (l_element, process_includes.out))
			l_root.put_last (l_element)
			
			create l_element.make (l_root, process_header_tag, l_ns)
			l_element.put_first (create {XM_CHARACTER_DATA}.make (l_element, process_header.out))
			l_root.put_last (l_element)
			
			create l_element.make (l_root, process_footer_tag, l_ns)
			l_element.put_first (create {XM_CHARACTER_DATA}.make (l_element, process_footer.out))
			l_root.put_last (l_element)
			
			create l_element.make (l_root, process_html_stylesheet_tag, l_ns)
			l_element.put_first (create {XM_CHARACTER_DATA}.make (l_element, process_html_stylesheet.out))
			l_root.put_last (l_element)
			
			create l_element.make (l_root, include_navigation_links_tag, l_ns)
			l_element.put_first (create {XM_CHARACTER_DATA}.make (l_element, include_navigation_links.out))
			l_root.put_last (l_element)
			
			create l_element.make (l_root, generate_dhtml_filter_tag, l_ns)
			l_element.put_first (create {XM_CHARACTER_DATA}.make (l_element, generate_dhtml_filter.out))
			l_root.put_last (l_element)
			
			create l_element.make (l_root, generate_feature_nodes_tag, l_ns)
			l_element.put_first (create {XM_CHARACTER_DATA}.make (l_element, generate_feature_nodes.out))
			l_root.put_last (l_element)
			
			save_xml_document (document, project.file.name)
		end
	
feature -- Access
			
	process_includes: BOOLEAN
			-- Should include directives be processed during transformation?			
			
	process_header: BOOLEAN
			-- Should header be included in transformations?
		
	process_footer: BOOLEAN
			-- Should footer be included in transformations?
			
	use_header_file: BOOLEAN
			-- Assuming `process_header' should header come from file?

	use_footer_file: BOOLEAN
			-- Assuming `process_footer' should footer come from file?

	override_file_header_declarations: BOOLEAN
			-- Should the project header override file-level defined header files?

	override_file_footer_declarations: BOOLEAN
			-- Should the project footer override file-level defined footer files?

	header_name: STRING
			-- Header file name
			
	footer_name: STRING
			-- Footer file name
			
	process_html_stylesheet: BOOLEAN
			-- Should HTML stylesheet reference be added during transformation?
			
	generate_feature_nodes: BOOLEAN
			-- Should features nodes be generated into the toc?
			
	include_navigation_links: BOOLEAN
			-- Should easy navigation links be generated during transformation?
	
	generate_dhtml_filter: BOOLEAN
			-- Should DHTML filter combo be generated for web based outputting?
	
feature {PREFERENCES_DIALOG} -- Status Setting	
	
	set_header (a_name: STRING) is
			-- Set `header_name'
		require
			name_not_void: a_name /= Void
			name_not_empty: not a_name.is_empty
		do
			header_name := a_name
		end
	
	set_footer (a_name: STRING) is
			-- Set `footer_name'
		require
			name_not_void: a_name /= Void
			name_not_empty: not a_name.is_empty
		do
			footer_name := a_name
		end	
	
	set_use_header_file (a_flag: BOOLEAN) is
			-- Set `use_header_file'
		require
			flag_not_void: a_flag /= Void
		do
			use_header_file := a_flag
		ensure
			flag_set: use_header_file = a_flag
		end	
		
	set_use_footer_file (a_flag: BOOLEAN) is
			-- Set `use_footer_file'
		require
			flag_not_void: a_flag /= Void
		do
			use_footer_file := a_flag
		ensure
			flag_set: use_footer_file = a_flag
		end	
	
	set_override_file_header_declarations (a_flag: BOOLEAN) is
			-- Set `override_file_header_declarations'
		require
			flag_not_void: a_flag /= Void
		do
			override_file_header_declarations := a_flag
		ensure
			flag_set: override_file_header_declarations = a_flag
		end	
		
	set_override_file_footer_declarations (a_flag: BOOLEAN) is
			-- Set `override_file_footer_declarations'
		require
			flag_not_void: a_flag /= Void
		do
			override_file_footer_declarations := a_flag
		ensure
			flag_set: override_file_footer_declarations = a_flag
		end		
	
	set_process_includes (a_flag: BOOLEAN) is
			-- Set if includes should be processed when converting documents
		require
			flag_not_void: a_flag /= Void
		do
			process_includes := a_flag
		ensure
			flag_set: process_includes = a_flag
		end	
	
	set_include_header (a_flag: BOOLEAN) is
			-- Set if header should be including during conversion
		require
			flag_not_void: a_flag /= Void
		do
			process_header := a_flag
		ensure
			flag_set: process_header = a_flag
		end	
		
	set_include_footer (a_flag: BOOLEAN) is
			-- Set if footer should be included during conversion
		require
			flag_not_void: a_flag /= Void
		do
			process_footer := a_flag
		ensure
			flag_set: process_footer = a_flag
		end	
	
	set_include_html_stylesheet (a_flag: BOOLEAN) is
			-- Set if HTML stylesheet should be included during conversion
		require
			flag_not_void: a_flag /= Void
		do
			process_html_stylesheet := a_flag
		ensure
			flag_set: process_html_stylesheet = a_flag
		end	
		
	set_include_nav_links (a_flag: BOOLEAN) is
			-- Set if naviaation links should be added to output
		require
			flag_not_void: a_flag /= Void
		do
			include_navigation_links := a_flag
		ensure
			flag_set: include_navigation_links = a_flag
		end	
		
	set_generate_dhtml_filter (a_flag: BOOLEAN) is
			-- Set if DHTML filter should be built for web based outputting
		require
			flag_not_void: a_flag /= Void
		do
			generate_dhtml_filter := a_flag
		ensure
			flag_set: generate_dhtml_filter = a_flag
		end	
	
	set_generate_feature_nodes (a_flag: BOOLEAN) is
			-- Set if feature nodes should be generated into the toc
		require
			flag_not_void: a_flag /= Void
		do
			generate_feature_nodes := a_flag
		ensure
			flag_set: generate_feature_nodes = a_flag
		end	
	
feature {NONE} -- Implementation

	process_element (e: XM_ELEMENT) is
			-- Read element `e'
		require
			e_not_void: e /= Void
		local
			l_elements: DS_LIST [XM_ELEMENT]
			l_value: STRING
		do
			l_value := e.text
			
				-- Name
			if e.name.is_equal (project_name_tag) then
				project.set_name (l_value)
			end
				--Location
			if e.name.is_equal (root_directory_tag) then
				if not (create {DIRECTORY}.make (l_value)).exists then
					old_root := l_value
					l_value := prompt_for_new_location (l_value, "project directory", False)
				end
				project.set_root_directory (l_value)
			end
				--Schema file
			if e.name.is_equal (schema_file_tag) then
				if old_root /= Void and l_value.has_substring (old_root) then
					l_value.replace_substring_all (old_root, project.root_directory)
				end
				if not (create {PLAIN_TEXT_FILE}.make (l_value)).exists then
					l_value := prompt_for_new_location (l_value, "schema file", True)
				end		
				if l_value /= Void and not l_value.is_empty then				
					project.Shared_document_manager.initialize_schema (l_value)
				end
			end			
				-- Stylesheet file
			if e.name.is_equal (html_stylesheet_file_tag) then
				if old_root /= Void and l_value.has_substring (old_root) then
					l_value.replace_substring_all (old_root, project.root_directory)
				end
				if not (create {PLAIN_TEXT_FILE}.make (l_value)).exists then					
					l_value := prompt_for_new_location (l_value, "stylesheet file", True)
				end
				if l_value /= Void and not l_value.is_empty then
					project.Shared_document_manager.initialize_stylesheet (l_value)
				end				
			end
				-- Header
			if e.name.is_equal (header_file_tag) then
				header_name := l_value		
			end
			
			if e.name.is_equal (process_header_tag) then
				process_header := l_value.is_equal ("True")
			end
			
			if e.name.is_equal (header_file_override_tag) then
				override_file_header_declarations := l_value.is_equal ("True")
			end
			
				-- Footer file
			if e.name.is_equal (footer_file_tag) then
				footer_name := l_value
			end
			
			if e.name.is_equal (process_footer_tag) then
				process_footer := l_value.is_equal ("True")
			end
			
			if e.name.is_equal (footer_file_override_tag) then
				override_file_footer_declarations := l_value.is_equal ("True")
			end
			
				-- Includes
			if e.name.is_equal (process_includes_tag) then
				process_includes := l_value.is_equal ("True")
			end
			
			if e.name.is_equal (process_html_stylesheet_tag) then
				process_html_stylesheet := l_value.is_equal ("True")
			end
			
			if e.name.is_equal (include_navigation_links_tag) then
				include_navigation_links := l_value.is_equal ("True")
			end
			
			if e.name.is_equal (generate_dhtml_filter_tag) then
				generate_dhtml_filter := l_value.is_equal ("True")
			end
			
			if e.name.is_equal (use_header_file_tag) then
				use_header_file := l_value.is_equal ("True")
			end
			
			if e.name.is_equal (use_footer_file_tag) then
				use_footer_file := l_value.is_equal ("True")
			end
			
			if e.name.is_equal (generate_feature_nodes_tag) then
				generate_feature_nodes := l_value.is_equal ("True")
			end
			
				-- Process sub_elements
			l_elements := e.elements
			from
				l_elements.start
			until
				l_elements.after
			loop
				process_element (l_elements.item_for_iteration)
				l_elements.forth
			end
		end

	project: DOCUMENT_PROJECT
			-- Project

	document: XM_DOCUMENT
			-- XML structure of `file'

	file_extension: STRING is
			-- File extension
		once
			Result := "dpr"	
		end	

	old_root: STRING
			-- Old root directory

	prompt_for_new_location (a_old_loc, context: STRING; is_file: BOOLEAN): STRING  is
			-- Prompt for new location
		local
			l_file_dialog: EV_FILE_OPEN_DIALOG
			l_directory_dialog: EV_DIRECTORY_DIALOG
			l_warning: EV_WARNING_DIALOG
		do
			create l_warning.make_with_text ("Could not open " + context + " " + a_old_loc + "Please provide a new location.")
			l_warning.show_modal_to_window ((create {SHARED_OBJECTS}).Application_window)
			
			if is_file then
				create l_file_dialog
				l_file_dialog.set_title ("Could not find " + a_old_loc)
				l_file_dialog.show_modal_to_window ((create {SHARED_OBJECTS}).Application_window)
				if l_file_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_open) then
					Result := l_file_dialog.file_name
				end
			else
				create l_directory_dialog
				l_directory_dialog.set_title ("Could not find " + a_old_loc)
				l_directory_dialog.show_modal_to_window ((create {SHARED_OBJECTS}).Application_window)
				if l_directory_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_ok) then
					Result := l_directory_dialog.directory
				end
			end
		end	

invariant
	has_project: project /= Void
		
end -- class DOCUMENT_PROJECT_FILE
