indexing
	description: "Dialog for choosing help generation options."
	date: "$Date$"
	revision: "$Revision$"

class
	HELP_DIALOG

inherit
	HELP_DIALOG_IMP
		undefine
			show
		end

	WIZARD_DIALOG
		rename
			user_initialization as wizard_user_initialization
		undefine
			initialize,
			is_in_default_state
		redefine
			is_valid,
			show
		end

	SHARED_OBJECTS	
		undefine
			copy,
			default_create
		end

	SHARED_CONSTANTS
		undefine
			copy,
			default_create
		end

create
	make,
	make_with_previous,
	make_with_next

feature {NONE} -- Initialization

	user_initialization is
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			next.select_actions.extend (agent move_next)
			cancel_but.select_actions.extend (agent cancel)
			back_but.select_actions.extend (agent move_previous)
			browse_proj1.select_actions.extend (agent browse_directories (location_text))
			title_text1.set_text (Shared_project.preferences.name + "_help")
		end

feature -- Commands
	
	show is
			-- Show dialog
		local
			l_dir_name: DIRECTORY_NAME
		do
			if Wizard_data.is_html_to_help_convert then
				toc_view_check.enable_select
			elseif Wizard_data.is_help_convert then
				toc_view_check.disable_select
			end
				
			if Shared_project.document_toc = Void then
				toc_view_check.hide
			end			
			Precursor
		end		
	
feature -- Query		
		
	is_valid: BOOLEAN is
			-- Are choices valid?
		local
			proj_dir, toc_dir: DIRECTORY
			l_constants: APPLICATION_CONSTANTS
		do
			l_constants := Shared_constants.Application_constants
			if title_text1.text.is_empty then
				set_validation_error ("No name specified for the help project.")
			elseif location_text.text.is_empty then
				set_validation_error ("No location for the help project specified.")
			else
				create proj_dir.make (location_text.text)
				if toc_view_check.is_selected then
					create toc_dir.make (l_constants.temporary_help_directory)
					if not toc_dir.exists then
						toc_dir.create_dir
					end
				else
					if Wizard_data.is_html_to_help_convert then
							-- For XML -> HTML -> Help use intermediate directory
						create toc_dir.make (l_constants.Temporary_html_directory)
					else
							-- For HTML -> Help it will be generated from the project
						create toc_dir.make (Shared_project.preferences.root_directory)
					end
				end
				Help_constants.set_toc_is_physical (toc_view_check.is_selected)
				if proj_dir.exists and toc_dir.exists then
					Result := True
					Help_constants.set_help_project_name (title_text1.text)
					Help_constants.set_help_toc_location (toc_dir.name)
					Help_constants.set_help_directory (create {DIRECTORY_NAME}.make_from_string (proj_dir.name))
					if html_radio.is_selected then
						Help_constants.set_help_type (Help_constants.Html_help)
					elseif vs_radio.is_selected then
						Help_constants.set_help_type (Help_constants.Vsip_help)
					elseif web_radio.is_selected then
						Help_constants.set_help_type (Help_constants.Web_help)
					end
				else
					set_validation_error ("Invalid Project and/or Table%Nof Contents directory specified.")		
				end
			end
		end

feature {NONE} -- Implementation
		
	browse_directories (target: EV_TEXT_FIELD) is
			-- Browse disk directory structure.  Write chosen location to
			-- `target'.
		require
			target_not_void: target /= Void
		local
			l_directory_dialog: EV_DIRECTORY_DIALOG
		do
			create l_directory_dialog
			--open_dialog.set_filter (".xsd")
			l_directory_dialog.show_modal_to_window (Current)
			if l_directory_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_ok) then
				set_location (target, l_directory_dialog.directory)
			end
		end	
		
	set_location (target: EV_TEXT_FIELD; a_location: STRING) is
			-- Set the `text' of `target'
		require
			target_not_void: target /= Void
		do
			target.set_text (a_location)
		end	
		
	set_summary is
			-- Set summary data
		do
			Summary.wipe_out
			remove_summary
			if html_radio.is_selected then
				add_option ("Generate HTML 1.x project (.chm).%N")
			elseif vs_radio.is_selected then
				add_option ("Generate help for Visual Studio Integration.%N")
			elseif web_radio.is_selected then
				add_option ("Generate Help as web content.%N")
			end
			add_option ("Name for Help Project: " + title_text1.text)
			add_option ("Files will be generated in: " + location_text.text + "%N")
			Summary_list.extend (Summary)
		end

	summary: SUMMARY_BOX is 
		once
			create Result.make (Current, "Help Project Options")
		end

end -- class HELP_DIALOG

