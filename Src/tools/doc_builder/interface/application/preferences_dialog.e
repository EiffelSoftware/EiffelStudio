indexing
	description: "Dialog for setting and viewing project preferences."
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
			apply_bt.select_actions.extend (agent apply)
			okay_bt.select_actions.extend (agent okay)
			cancel_bt.select_actions.extend (agent hide)
			browse_schema_bt.select_actions.extend (agent browse_schema)
			browse_xsl_bt.select_actions.extend (agent browse_xslt)
			browse_css_bt.select_actions.extend (agent browse_stylesheet)
			get_settings
		end

feature {NONE} -- Commands

	get_settings is
			-- Retrieve current settings for loaded project
		local
			prefs: DOCUMENT_PROJECT_FILE
		do
			prefs := Shared_project.preferences
			name_text.set_text (prefs.name)
			if prefs.has_schema then
				schema_loc_text.set_text (prefs.schema_file)
			end
			if prefs.has_transform_file then
				xsl_loc_text.set_text (prefs.transform_file)
			end
			if prefs.has_stylesheet_file then
				css_loc_text.set_text (prefs.stylesheet_file)
			end
			if prefs.has_index_file_name then
				index_filename_text.set_text (prefs.index_filename)
			end
			if prefs.is_index_root then
				index_root_check.enable_select
			else
				index_root_check.disable_select
			end
			if prefs.include_empty_directories then
				include_empty_dirs_check.enable_select
			else
				include_empty_dirs_check.disable_select
			end
			if prefs.include_directories_no_index then
				include_no_index_check.enable_select
			else
				include_no_index_check.disable_select
			end
			if prefs.include_skipped_sub_directories then
				include_skipped_sub_dirs_check.enable_select
			else
				include_skipped_sub_dirs_check.disable_select
			end			
		end

	set_settings is
			-- Set chosen preferences
		require
			settings_valid: is_valid
		local
			prefs: DOCUMENT_PROJECT_FILE
		do
			prefs := Shared_project.preferences
			prefs.set_name (name_text.text)
			if schema_loc_text.text.is_empty then
				prefs.remove_schema_file
			else
				prefs.set_schema_file (schema_loc_text.text)			
			end
			if xsl_loc_text.text.is_empty then
				prefs.remove_xsl_file
			else
				prefs.set_xsl_file (xsl_loc_text.text)
			end
			if css_loc_text.text.is_empty then
				prefs.remove_css_file
			else
				prefs.set_css_file (css_loc_text.text)
			end
			if index_filename_text.text.is_empty then
				prefs.remove_index_file_name
			else
				prefs.set_index_file_name (index_filename_text.text)
				Shared_constants.Application_constants.set_index_file_name (index_filename_text.text)
			end
			prefs.set_index_root (index_root_check.is_selected)
			Shared_constants.Application_constants.set_make_index_root (index_root_check.is_selected)
			prefs.set_include_empty_directories (include_empty_dirs_check.is_selected)
			Shared_constants.Application_constants.set_include_empty_directories (include_empty_dirs_check.is_selected)
			prefs.set_include_directories_no_index (include_no_index_check.is_selected)
			Shared_constants.Application_constants.set_include_directories_no_index (include_no_index_check.is_selected)
			prefs.set_include_skipped_sub_directories (include_skipped_sub_dirs_check.is_selected)
			Shared_constants.Application_constants.set_include_skipped_sub_directories (include_skipped_sub_dirs_check.is_selected)
			prefs.write
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

	browse_schema is
			-- Attempt to load a new schema file for validation
		local
			l_open_dialog: EV_FILE_OPEN_DIALOG
		do
			create l_open_dialog
			--open_dialog.set_filter (".xsd")
			l_open_dialog.show_modal_to_window (Current)
			if l_open_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_open) then
				initialize_schema (l_open_dialog.file_name)
			end
		end
	
	browse_xslt is
			-- Attempt to load a new xslt file for transform
		local
			l_open_dialog: EV_FILE_OPEN_DIALOG
		do
			create l_open_dialog
			--open_dialog.set_filter (".xsl")
			l_open_dialog.show_modal_to_window (Current)
			if l_open_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_open) then
				initialize_xslt (l_open_dialog.file_name)
			end
		end
		
	browse_stylesheet is
			-- Attempt to load a stylesheet for the `xslt' to apply formatting against.
		require else
			has_xslt: Shared_document_manager.xsl /= Void
		local
			l_open_dialog: EV_FILE_OPEN_DIALOG
		do
			create l_open_dialog
			--open_dialog.set_filter (".css")
			l_open_dialog.show_modal_to_window (Current)
			if l_open_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_open) then
				initialize_stylesheet (l_open_dialog.file_name)
			end
		end	
	
feature {NONE} -- Initialization

	initialize_schema (a_filename: STRING) is
			-- Initialize Schema from `a_filename'
		do
			Shared_document_manager.initialize_schema (a_filename)
			if Shared_document_manager.has_schema then
				Shared_project.preferences.set_schema_file (a_filename)
				Shared_project.preferences.write
				Shared_project.update
				schema_loc_text.set_text (Shared_project.preferences.schema_file)
			end
		end

	initialize_xslt (a_filename: STRING) is
			-- Initialize XSL from `a_filename'
		do
			Shared_document_manager.initialize_xslt (a_filename)
			if Shared_document_manager.has_xsl then
				Shared_project.preferences.set_xsl_file (a_filename)
				Shared_project.preferences.write
				xsl_loc_text.set_text (Shared_project.preferences.transform_file)
				css_loc_text.enable_sensitive
				browse_css_bt.enable_sensitive
			end
		end
		
	initialize_stylesheet (a_filename: STRING) is
			-- Initialize Stylesheet from `a_filename'
		require
			xsl_loaded: Shared_document_manager.has_xsl
		do
			Shared_document_manager.xsl.set_stylesheet (a_filename)
			if Shared_document_manager.xsl.has_stylesheet then
				Shared_project.preferences.set_css_file (a_filename)
				Shared_project.preferences.write
				css_loc_text.set_text (Shared_project.preferences.stylesheet_file)
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
			
			if not index_filename_text.text.is_empty and then not is_alpha_numeric_string (index_filename_text.text) then
				show_error ("Index filename can contain only alpha or numeric characters.")
				Result := False
			end
			
			if Result = True and then not schema_loc_text.text.is_empty then
				create l_file.make (schema_loc_text.text)
				if not l_file.exists then				
					show_error ("Schema file does not exist.")
					Result := False
				end
			end
			
			if Result = True and then not xsl_loc_text.text.is_empty then
				create l_file.make (xsl_loc_text.text)
				if not l_file.exists then
					show_error ("Transform file does not exist.")
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
		end
		
end -- class PREFERENCES_DIALOG

