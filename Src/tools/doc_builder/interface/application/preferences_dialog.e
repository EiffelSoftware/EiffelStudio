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
			name_text.set_text (Shared_project.name)
			if Shared_document_manager.has_schema then
				schema_loc_text.set_text (Shared_document_manager.schema.name)
			end
			if Shared_document_manager.has_stylesheet then
				css_loc_text.set_text (shared_document_manager.stylesheet.name)
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
			Shared_project.set_name (name_text.text)
			if schema_loc_text.text.is_empty then
				Shared_document_manager.remove_schema
			else
				Shared_document_manager.initialize_schema (schema_loc_text.text)			
			end			
			if css_loc_text.text.is_empty then
				Shared_document_manager.remove_stylesheet
			else
				Shared_document_manager.initialize_stylesheet (css_loc_text.text)
			end		
			
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
		
	browse_stylesheet is
			-- Attempt to load a stylesheet for the `xslt' to apply formatting against.		
		local
			l_open_dialog: EV_FILE_OPEN_DIALOG
		do
			create l_open_dialog
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
				schema_loc_text.set_text (a_filename)
						-- Update project
				Shared_project.preferences.write
				Shared_project.update				
			end
		end
		
	initialize_stylesheet (a_filename: STRING) is
			-- Initialize Stylesheet from `a_filename'
		do
			Shared_document_manager.initialize_stylesheet (a_filename)
			css_loc_text.set_text (Shared_document_manager.stylesheet.name)		
			Shared_project.preferences.write
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
		end
		
end -- class PREFERENCES_DIALOG

