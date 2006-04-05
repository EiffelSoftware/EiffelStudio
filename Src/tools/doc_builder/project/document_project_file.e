indexing
	description: "Project preferences."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_PROJECT_PREFERENCES
	
inherit	
	DOCUMENT_PROJECT_XML_TAGS
	
	XML_ROUTINES

	UTILITY_FUNCTIONS
	
	SHARED_OBJECTS

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
			toc_folders.wipe_out
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
		do
			document := deserialize_document (create {FILE_NAME}.make_from_string (project.file.name))
			if document /= Void then
				process_element (document.root_element)				
			end
				
			if not is_valid then
				shared_error_reporter.set_error (create {ERROR}.make ("The project file is invalid."))
				shared_error_reporter.show
			end			
		end
		
	write is
			-- Write preferences to disk
		local
			l_root, l_element: XM_ELEMENT
			l_ns: XM_NAMESPACE
			l_text: STRING
			l_file: PLAIN_TEXT_FILE
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
			
			write_filters (l_root)
			write_shortcuts (l_root)
			write_toc_folders (l_root)
				
			l_text := pretty_xml (document_text (document))
			create l_file.make_open_write (project.file.name)
			if not l_file.exists then
				create l_file.make_create_read_write (project.file.name)
			end
			l_file.put_string (l_text)
			l_file.close
		end
		
	write_filters (root: XM_ELEMENT) is
			-- Write filter preferences to disk
		local
			l_element,
			l_child: XM_ELEMENT
			l_ns: XM_NAMESPACE
			l_filters: HASH_TABLE [DOCUMENT_FILTER, STRING]
			l_filter: OUTPUT_FILTER
		do			
			create l_ns.make_default
			l_filters := project.filter_manager.filters
			from
				l_filters.start
			until
				l_filters.after
			loop
				l_filter ?= l_filters.item_for_iteration
				if l_filter /= Void and not l_filter.description.is_equal (project.filter_manager.unfiltered) then
					
						-- Write '<filter>'
					create l_element.make (root, output_filter_tag, l_ns)
					root.put_last (l_element)
					
						-- Write '<filter_description>'
					create l_child.make (l_element, output_filter_description_tag, l_ns)
					l_child.put_first (create {XM_CHARACTER_DATA}.make (l_child, l_filter.description))
					l_element.put_last (l_child)
					
						-- Write '<filter_highlight_xxx_color>'					
					create l_child.make (l_element, output_filter_highlight_red_tag, l_ns)
					l_child.put_first (create {XM_CHARACTER_DATA}.make (l_child, l_filter.color.red.out))
					l_element.put_last (l_child)
					create l_child.make (l_element, output_filter_highlight_green_tag, l_ns)
					l_child.put_first (create {XM_CHARACTER_DATA}.make (l_child, l_filter.color.green.out))
					l_element.put_last (l_child)
					create l_child.make (l_element, output_filter_highlight_blue_tag, l_ns)
					l_child.put_first (create {XM_CHARACTER_DATA}.make (l_child, l_filter.color.blue.out))
					l_element.put_last (l_child)

					
						-- Write '<filter_highlight_on>'
					create l_child.make (l_element, output_filter_highlight_enabled_tag, l_ns)
					l_child.put_first (create {XM_CHARACTER_DATA}.make (l_child, l_filter.highlighting_enabled.out))
					l_element.put_last (l_child)
					
					if l_filter.primary_output_flag /= Void then
							-- Write '<filter_primary_flag>'
						create l_child.make (l_element, output_filter_primary_flag_tag, l_ns)
						l_child.put_first (create {XM_CHARACTER_DATA}.make (l_child, l_filter.primary_output_flag))
						l_element.put_last (l_child)
					end
					
					from
						l_filter.output_flags.start
					until
						l_filter.output_flags.after
					loop
							-- Write '<tag>'
						create l_child.make (l_element, output_filter_tag_tag, l_ns)
						l_child.put_first (create {XM_CHARACTER_DATA}.make (l_child, l_filter.output_flags.item))
						l_element.put_last (l_child)
						l_filter.output_flags.forth
					end
				end
				l_filters.forth
			end
		end
		
	write_toc_folders (root: XM_ELEMENT) is
			-- Write toc folder preferences to disk
		local
			l_element,
			l_child: XM_ELEMENT
			l_ns: XM_NAMESPACE
		do			
			create l_ns.make_default			
			if not toc_folders.is_empty then
					
					-- Write '<toc_folders>'
				create l_element.make (root, "toc_folders", l_ns)
				root.put_last (l_element)
				
				from
					toc_folders.start
				until
					toc_folders.after
				loop					
					if toc_folders.item /= Void then
							-- Write '<folders>'
						create l_child.make (l_element, toc_folder_tag, l_ns)
						l_child.put_first (create {XM_CHARACTER_DATA}.make (l_child, toc_folders.item))
						l_element.put_last (l_child)						
					end
					toc_folders.forth
				end				
			end
		end	
	
	write_shortcuts (root: XM_ELEMENT) is
			-- Write shortcut preferences to disk
		local
			l_element,
			l_child: XM_ELEMENT
			l_ns: XM_NAMESPACE
			l_accelerators: HASH_TABLE [STRING, INTEGER]
		do
			create l_ns.make_default
			l_accelerators := project.application_window.tag_accelerators
			from
				l_accelerators.start
			until
				l_accelerators.after
			loop
				if not l_accelerators.item_for_iteration.is_empty then
						-- Write '<shortcut>'
					create l_element.make (root, shortcut_tag, l_ns)
					root.put_last (l_element)
						-- Write '<shortcut_key>'
					create l_child.make (l_element, shortcut_key_tag, l_ns)
					l_child.put_first (create {XM_CHARACTER_DATA}.make (l_child, l_accelerators.key_for_iteration.out))
					l_element.put_last (l_child)
						-- Write '<shortcut_value>'
					create l_child.make (l_element, shortcut_value_tag, l_ns)
					l_child.put_first (create {XM_CHARACTER_DATA}.make (l_child, l_accelerators.item_for_iteration.out))
					l_element.put_last (l_child)
				end
				l_accelerators.forth
			end
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
	
	toc_folders: ARRAYED_LIST [STRING] is
			-- Toc folders
		once
			create Result.make (1)
			Result.comparE_objects
		end
	
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
		do
			use_header_file := a_flag
		ensure
			flag_set: use_header_file = a_flag
		end	
		
	set_use_footer_file (a_flag: BOOLEAN) is
			-- Set `use_footer_file'
		do
			use_footer_file := a_flag
		ensure
			flag_set: use_footer_file = a_flag
		end	
	
	set_override_file_header_declarations (a_flag: BOOLEAN) is
			-- Set `override_file_header_declarations'
		do
			override_file_header_declarations := a_flag
		ensure
			flag_set: override_file_header_declarations = a_flag
		end	
		
	set_override_file_footer_declarations (a_flag: BOOLEAN) is
			-- Set `override_file_footer_declarations'
		do
			override_file_footer_declarations := a_flag
		ensure
			flag_set: override_file_footer_declarations = a_flag
		end		
	
	set_process_includes (a_flag: BOOLEAN) is
			-- Set if includes should be processed when converting documents
		do
			process_includes := a_flag
		ensure
			flag_set: process_includes = a_flag
		end	
	
	set_include_header (a_flag: BOOLEAN) is
			-- Set if header should be including during conversion
		do
			process_header := a_flag
		ensure
			flag_set: process_header = a_flag
		end	
		
	set_include_footer (a_flag: BOOLEAN) is
			-- Set if footer should be included during conversion
		do
			process_footer := a_flag
		ensure
			flag_set: process_footer = a_flag
		end	
	
	set_include_html_stylesheet (a_flag: BOOLEAN) is
			-- Set if HTML stylesheet should be included during conversion
		do
			process_html_stylesheet := a_flag
		ensure
			flag_set: process_html_stylesheet = a_flag
		end	
		
	set_include_nav_links (a_flag: BOOLEAN) is
			-- Set if naviaation links should be added to output
		do
			include_navigation_links := a_flag
		ensure
			flag_set: include_navigation_links = a_flag
		end	
		
	set_generate_dhtml_filter (a_flag: BOOLEAN) is
			-- Set if DHTML filter should be built for web based outputting
		do
			generate_dhtml_filter := a_flag
		ensure
			flag_set: generate_dhtml_filter = a_flag
		end	
	
	set_generate_feature_nodes (a_flag: BOOLEAN) is
			-- Set if feature nodes should be generated into the toc
		do
			generate_feature_nodes := a_flag
		ensure
			flag_set: generate_feature_nodes = a_flag
		end	
	
	set_toc_folders (a_folder_list: ARRAYED_LIST [STRING]) is
			-- Add a toc folder
		require
			folder_not_void: a_folder_list /= Void
		do
			toc_folders.wipe_out
			toc_folders.append (a_folder_list)
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
			if e.text /= Void then
--				l_value :=  unescaped_string (e.text)	
				l_value := e.text.twin
			end
			
				-- Name
			if e.name.is_equal (project_name_tag) then
				project.set_name (l_value)
			end
				--Location
			if e.name.is_equal (root_directory_tag) then								
				if not (create {DIRECTORY}.make (l_value)).exists then
					l_value := interpreted_path_data (l_value)
					old_root := l_value.twin
					if not (create {DIRECTORY}.make (l_value)).exists then						
						l_value := prompt_for_new_location (l_value, "project directory", False)
					end
				end
				project.set_root_directory (l_value)
			end
				--Schema file
			if e.name.is_equal (schema_file_tag) then
				l_value := interpreted_path_data (l_value)
				if old_root /= Void and l_value.has_substring (old_root) then
					l_value.replace_substring_all (old_root, project.root_directory)
				end
				if not (create {PLAIN_TEXT_FILE}.make (l_value)).exists then
					l_value := interpreted_path_data (l_value)
					if not (create {PLAIN_TEXT_FILE}.make (l_value)).exists then
						l_value := prompt_for_new_location (l_value, "schema file", True)
					end
				end		
				if l_value /= Void and not l_value.is_empty then				
					project.Shared_document_manager.initialize_schema (l_value)
				end
			end			
				-- Stylesheet file
			if e.name.is_equal (html_stylesheet_file_tag) then
				l_value := interpreted_path_data (l_value)
				if old_root /= Void and l_value.has_substring (old_root) then
					l_value.replace_substring_all (old_root, project.root_directory)
				end
				if not (create {PLAIN_TEXT_FILE}.make (l_value)).exists then	
					l_value := interpreted_path_data (l_value)
					if not (create {PLAIN_TEXT_FILE}.make (l_value)).exists then
						l_value := prompt_for_new_location (l_value, "stylesheet file", True)
					end
				end
				if l_value /= Void and not l_value.is_empty then
					project.Shared_document_manager.initialize_stylesheet (l_value)
				end				
			end
			
				-- Header
			if e.name.is_equal (header_file_tag) then
				if not (create {PLAIN_TEXT_FILE}.make (l_value)).exists then
					l_value := interpreted_path_data (l_value)
					if not (create {DIRECTORY}.make (l_value)).exists then
						l_value := prompt_for_new_location (l_value, "header file", True)
					end
				end
				if l_value /= Void and not l_value.is_empty then
					header_name := l_value
				end							
			end
			
			if e.name.is_equal (process_header_tag) then
				process_header := l_value.is_equal ("True")
			end
			
			if e.name.is_equal (header_file_override_tag) then
				override_file_header_declarations := l_value.is_equal ("True")
			end
			
				-- Footer file
			if e.name.is_equal (footer_file_tag) then
				if not (create {PLAIN_TEXT_FILE}.make (l_value)).exists then					
					l_value := interpreted_path_data (l_value)
					if not (create {DIRECTORY}.make (l_value)).exists then
						l_value := prompt_for_new_location (l_value, "footer file", True)
					end
				end
				if l_value /= Void and not l_value.is_empty then
					footer_name := l_value
				end						
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
				
				-- Filters		
			if e.name.is_equal (output_filter_description_tag) then
				create filter.make (l_value)
				create filter_color
				filter.set_color (filter_color)
				project.filter_manager.add_filter (filter)
			end
			
			if e.name.is_equal (output_filter_primary_flag_tag) then
				filter.set_primary_output_flag (l_value)
			end
			
			if e.name.is_equal (output_filter_tag_tag) then
				filter.add_output_flag (l_value)
			end
			
			if e.name.is_equal (output_filter_highlight_enabled_tag) then
				filter.enable_highlighting (l_value.is_equal ("True"))
			end
			
			if e.name.is_equal (output_filter_highlight_red_tag) then
				filter_color.set_red (l_value.to_real)
			end
			
			if e.name.is_equal (output_filter_highlight_green_tag) then
				filter_color.set_green (l_value.to_real)
			end
			
			if e.name.is_equal (output_filter_highlight_blue_tag) then
				filter_color.set_blue (l_value.to_real)
			end
			
				-- Shortcuts
			if project.shared_constants.application_constants.is_gui_mode then			
				if e.name.is_equal (shortcut_tag) then
					create tag_shortcut.make_with_key_combination ((create {EV_KEY}), True, False, False)
				end
				
				if e.name.is_equal (shortcut_key_tag) then
					tag_shortcut.set_key (create {EV_KEY}.make_with_code (l_value.to_integer))
				end	
				
				if e.name.is_equal (shortcut_value_tag) then
					project.application_window.add_tag_accelerator (tag_shortcut, l_value)
				end				
			end
			
			if e.name.is_equal (toc_folder_tag) then
				toc_folders.extend (l_value)
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
			
	tag_shortcut: EV_ACCELERATOR
			-- Tag shortcut
			
	filter: OUTPUT_FILTER
			-- Filter
			
	filter_name: STRING
			-- Name of last read filter from file
	
	filter_flag: STRING
			-- Last read flag for filter from file	

	prompt_for_new_location (a_old_loc, context: STRING; is_file: BOOLEAN): STRING  is
			-- Prompt for new location
		local
			l_file_dialog: EV_FILE_OPEN_DIALOG
			l_directory_dialog: EV_DIRECTORY_DIALOG
			l_warning: EV_WARNING_DIALOG
		do
			create l_warning.make_with_text ("Could not open " + context + " " + a_old_loc + ".  Please provide a new location.")
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
			if Result /= Void and then not Result.is_empty then
				Result.replace_substring_all ("\", "/")
			end
		end	

	unescaped_string (a_string: STRING): STRING is
			-- Un-escape string.
		do
			a_string.replace_substring_all ("&lt;", "<")
			a_string.replace_substring_all ("&gt;", ">")
			a_string.replace_substring_all ("&amp", "&")
			a_string.replace_substring_all ("&quot;", "%"")
			Result := a_string
		end

	filter_color: EV_COLOR

	interpreted_path_data (a_path: STRING): STRING is
			-- Process `a_path' data
		local
			l_interpreter: ENV_INTERP
		do
			debug ("console_output")
				io.put_string ("Original was: ")
				io.put_string (a_path)
				io.new_line
			end
			create l_interpreter
			Result := l_interpreter.interpreted_string (a_path)
			Result.replace_substring_all ("\", "/")
			debug ("console_output")
				io.put_string ("Updated path is: ")
				io.put_string (Result)
				io.new_line
			end
		end		

invariant
	has_project: project /= Void
		
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
end -- class DOCUMENT_PROJECT_FILE
