indexing
	description: "Dialog for setting and viewing project preferences."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PREFERENCES_DIALOG

inherit
	PREFERENCES_DIALOG_IMP
	
	SHARED_OBJECTS
		undefine
			copy,
			is_equal,
			default_create
		end
		
	UTILITY_FUNCTIONS
		undefine
			copy,
			is_equal,
			default_create
		end

feature {NONE} -- Initialization

	user_initialization is
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do			
				-- Buttons
			apply_bt.select_actions.extend (agent apply)
			okay_bt.select_actions.extend (agent okay)
			cancel_bt.select_actions.extend (agent hide)
			
				-- Files
			browse_schema_bt.select_actions.extend (agent initialize_schema)
			browse_css_bt.select_actions.extend (agent initialize_stylesheet)
			browse_header_button.select_actions.extend (agent initialize_header)
			browse_footer_button.select_actions.extend (agent initialize_footer)
			
				-- Filters
			filters_list.select_actions.extend (agent filter_selected)
			add_description_button.select_actions.extend (agent add_filter)
			add_tag_button.select_actions.extend (agent add_filter_tag)
			color_button.select_actions.extend (agent change_filter_color)			
			
			get_settings
		end

feature {NONE} -- Commands

	get_settings is
			-- Retrieve current settings for loaded project
		do
			name_text.set_text (Shared_project.name)
			if Shared_document_manager.has_schema then
				schema_loc_text.set_text (Shared_document_manager.schema.name)
			end
			if Shared_document_manager.has_stylesheet then
				css_loc_text.set_text (shared_document_manager.stylesheet.name)
			end
			if project_preferences.header_name /= Void then
				header_loc_text.set_text (project_preferences.header_name)
			end
			if project_preferences.footer_name /= Void then
				footer_loc_text.set_text (project_preferences.footer_name)
			end
			
				-- Conversion Options
			set_check_button_value (header_override_check, project_preferences.override_file_header_declarations)
			set_check_button_value (footer_override_check, project_preferences.override_file_footer_declarations)
			set_check_button_value (use_include_tags, project_preferences.process_includes)
			set_check_button_value (header_include_check, project_preferences.process_header)
			set_check_button_value (footer_include_check, project_preferences.process_footer)
			set_check_button_value (html_stylesheet_check, project_preferences.process_html_stylesheet)
			set_check_button_value (nav_links_check, project_preferences.include_navigation_links)
			set_check_button_value (dhtml_filter_check, project_preferences.generate_dhtml_filter)
			set_check_button_value (generate_feature_nodes_check, project_preferences.generate_feature_nodes)
			
			if project_preferences.use_header_file then
				header_file_radio.enable_select
			else	
				header_generate_check.enable_select
			end
			
			if project_preferences.use_footer_file then
				footer_file_radio.enable_select
			else	
				footer_generate_check.enable_select
			end					
			
			populate_filter_list
			
				-- Toc folders
			create check_tree
			tree_container.extend (check_tree)
			create dir_tree.make_with_data (shared_project.root_directory, check_tree, shared_project.preferences.toc_folders)				
		end

	set_settings is
			-- Set chosen preferences
		require
			settings_valid: is_valid
		do		
				-- Schema
			if schema_loc_text.text.is_empty then
				shared_document_manager.remove_schema
			else
				shared_document_manager.initialize_schema (schema_loc_text.text)			
			end		
			
				-- Stylesheet
			if css_loc_text.text.is_empty then
				shared_document_manager.remove_stylesheet
			else
				shared_document_manager.initialize_stylesheet (css_loc_text.text)
			end		
			
				-- Header File		
			if not header_loc_text.text.is_empty then
				project_preferences.set_header (header_loc_text.text)
			end

				-- Footer File	
			if not footer_loc_text.text.is_empty then
				project_preferences.set_footer (footer_loc_text.text)
			end			
			
				-- Conversion Options
			project_preferences.set_override_file_header_declarations (header_override_check.is_selected)
			project_preferences.set_override_file_footer_declarations (footer_override_check.is_selected)
			project_preferences.set_process_includes (use_include_tags.is_selected)
			project_preferences.set_include_header (header_include_check.is_selected)
			project_preferences.set_include_footer (footer_include_check.is_selected)
			project_preferences.set_include_html_stylesheet (html_stylesheet_check.is_selected)
			project_preferences.set_include_nav_links (nav_links_check.is_selected)
			project_preferences.set_generate_dhtml_filter (dhtml_filter_check.is_selected)
			project_preferences.set_use_header_file (header_file_radio.is_selected)
			project_preferences.set_use_footer_file (footer_file_radio.is_selected)
			project_preferences.set_generate_feature_nodes (generate_feature_nodes_check.is_selected)
			
			project_preferences.set_toc_folders (selected_tree_directories)
							
			project_preferences.write
			
			if shared_project.is_valid then			
				shared_project.update		
			end
		end		

	show_error (error: STRING) is
			-- Show validation error
		require
			error_not_void: error /= Void
		local
			error_dlg: EV_INFORMATION_DIALOG
		do
			create error_dlg.make_with_text (error)
			error_dlg.show_modal_to_window (Current)
		end

	apply is
			-- Apply changes
		do
			if is_valid then
				set_settings
			end
		end
		
	okay is
			-- Apply changes
		do
			if is_valid then
				set_settings
				hide		
			end
		end

feature {NONE} -- Implementation
	
	project_preferences: DOCUMENT_PROJECT_PREFERENCES is
			-- Project preferences
		once
			Result := Shared_project.preferences
		end		
	
	browse_file (a_filter: STRING): STRING is
			-- Attempt to load a file, return chosen file name
		local
			l_open_dialog: EV_FILE_OPEN_DIALOG
		do
			create l_open_dialog
			if a_filter /= Void then				
				--open_dialog.set_filter (a_filter)	
			end
			l_open_dialog.show_modal_to_window (Current)
			if l_open_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_open) then
				Result := l_open_dialog.file_name
			end
		end
	
	check_tree: EV_CHECKABLE_TREE	

	dir_tree: CHECKABLE_DIRECTORY_SELECTOR
	
feature {NONE} -- Initialization

	initialize_schema is
			-- Initialize Schema from `a_filename'
		local
			l_schema_file: STRING
		do
			l_schema_file := browse_file (Void)
			if l_schema_file /= Void then				
				Shared_document_manager.initialize_schema (l_schema_file)
				if Shared_document_manager.has_schema then
					schema_loc_text.set_text (l_schema_file)
							-- Update project
					--Shared_project.preferences.write			
				end	
			end
		end
		
	initialize_stylesheet is
			-- Initialize Stylesheet from `a_filename'
		local
			l_stylesheet_file: STRING
		do
			l_stylesheet_file := browse_file (Void)
			if l_stylesheet_file /= Void then			
				Shared_document_manager.initialize_stylesheet (l_stylesheet_file)
				css_loc_text.set_text (l_stylesheet_file)
				--Shared_project.preferences.write
				copy_stylesheet (Shared_constants.Application_constants.Temporary_html_directory)
			end
		end
		
	initialize_header is
			-- Initialize header
		local
			l_header_file: STRING
		do
			l_header_file := browse_file (Void)
			if l_header_file /= Void then
				header_loc_text.set_text (l_header_file)	
				project_preferences.set_header (l_header_file)
			end
		end
		
	initialize_footer is
			-- Initialize footer
		local
			l_footer_file: STRING
		do
			l_footer_file := browse_file (Void)
			if l_footer_file /= Void then
				footer_loc_text.set_text (l_footer_file)	
				project_preferences.set_footer (l_footer_file)
			end
		end
	
feature {NONE} -- Query
	
	is_valid: BOOLEAN is
			-- Are details in Current Valid
		local
			l_file: PLAIN_TEXT_FILE
		do
			Result := True
			
			if name_text.text.is_empty then
				show_error ("Name field empty.  You must%Nchoose a name for the project.")
				Result := False
			end		
			
			if Result = True and then not schema_loc_text.text.is_empty then
				create l_file.make (schema_loc_text.text)
				if not l_file.exists then				
					show_error ("Schema file does not exist.")
					Result := False
				end
			end
			
			if Result = True and then not css_loc_text.text.is_empty then
				create l_file.make (css_loc_text.text)
				if not l_file.exists then
					show_error ("Stylesheet file does not exist.")
					Result := False
				end
			end
			
			if Result = True and then not header_loc_text.text.is_empty then
				create l_file.make (header_loc_text.text)
				if not l_file.exists then
					show_error ("Header file does not exist.")
					Result := False
				end
			end
			
			if Result = True and then not footer_loc_text.text.is_empty then
				create l_file.make (footer_loc_text.text)
				if not l_file.exists then
					show_error ("Footer file does not exist.")
					Result := False
				end
			end
		end
		
	populate_filter_list is
			-- Retrieve filters
		local
			l_filters: HASH_TABLE [DOCUMENT_FILTER, STRING]
			l_list_item: EV_LIST_ITEM
		do
			l_filters := shared_project.filter_manager.filters
			from
				l_filters.start
			until
				l_filters.after
			loop
				create l_list_item.make_with_text (l_filters.key_for_iteration)
				filters_list.extend (l_list_item)
				l_filters.forth
			end
		end

	filter_selected is
			-- A filter was selected
		local
			l_list_item: EV_LIST_ITEM
			l_filter_description: STRING
			l_filter: OUTPUT_FILTER
			l_flags: ARRAYED_LIST [STRING]
		do
			tags_list.wipe_out
			l_list_item := filters_list.selected_item
			if l_list_item /= Void then
				l_filter_description := l_list_item.text
				l_filter ?= shared_project.filter_manager.filter_by_description (l_filter_description)
				if l_filter.color /= Void then
					color_label.set_background_color (l_filter.color)
				end
				from
					l_flags := l_filter.output_flags
					l_flags.start
				until
					l_flags.after
				loop
					create l_list_item.make_with_text (l_flags.item)
					tags_list.extend (l_list_item)
					l_flags.forth
				end
			end
		end		

	add_filter is
			-- Add new output filter
		local
			l_description: STRING
			l_filter: OUTPUT_FILTER
		do
			l_description := filter_description_text.text
			if not l_description.is_empty then
				create l_filter.make (l_description)
				shared_project.filter_manager.add_filter (l_filter)
				filters_list.extend (create {EV_LIST_ITEM}.make_with_text (l_description))
				application_window.update_output_combo
			end
		end
		
	add_filter_tag is
			-- Add new tag to output filter
		local
			l_tag: STRING
			l_filter: OUTPUT_FILTER
		do
			l_tag := filter_tag_name_text.text
			if not l_tag.is_empty and filters_list.selected_item /= Void then
				l_filter ?= shared_project.filter_manager.filter_by_description (filters_list.selected_item.text)
				l_filter.add_output_flag (l_tag)
				tags_list.extend (create {EV_LIST_ITEM}.make_with_text (l_tag))
			end			
		end
	
	change_filter_color is
			-- Change the color of the selected filter
		local
			l_list_item: EV_LIST_ITEM
			l_filter: OUTPUT_FILTER			
			l_color_dialog: EV_COLOR_DIALOG
		do			
			l_list_item := filters_list.selected_item
			if l_list_item /= Void then
				create l_color_dialog
				l_color_dialog.set_color (color_label.background_color)
				l_color_dialog.show_modal_to_window (Current)
				if l_color_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_ok) then					
					l_filter ?= shared_project.filter_manager.filter_by_description (l_list_item.text)
					if l_filter /= Void then
						l_filter.set_color (l_color_dialog.color)
						color_label.set_background_color (l_color_dialog.color)
					end
				end
			end
		end
		
	set_check_button_value (a_button: EV_CHECK_BUTTON; a_flag: BOOLEAN) is
			-- Set `a_button' to `a_flag'
		do
			if a_flag then
				a_button.enable_select
			else				
				a_button.disable_select
			end
		end		

	selected_tree_directories: ARRAYED_LIST [STRING] is
			-- 
		require
			item_checked: not check_tree.checked_items.is_empty
		local
			l_dir_name: STRING
			l_checked_items: DYNAMIC_LIST [EV_TREE_NODE]
		do
			create Result.make (check_tree.checked_items.count)
			l_checked_items := check_tree.checked_items
			from
				l_checked_items.start
			until
				l_checked_items.after
			loop
				l_dir_name ?= l_checked_items.item.data
				if l_dir_name /= Void then
					Result.extend (l_dir_name)
				end
				l_checked_items.forth
			end
		end		

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
end -- class PREFERENCES_DIALOG

