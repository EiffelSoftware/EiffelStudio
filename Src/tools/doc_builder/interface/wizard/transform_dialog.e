indexing
	description: "Dialog for selecting transformation options for XML documents."
	date: "$Date$"
	revision: "$Revision$"

class
	TRANSFORM_DIALOG

inherit
	TRANSFORM_DIALOG_IMP
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
			is_valid
		end

	SHARED_OBJECTS
		undefine
			copy,
			default_create
		end

create
	make,
	make_with_next,
	make_with_previous

feature {NONE} -- Initialization

	user_initialization is
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		local
			l_dir: DIRECTORY
		do
			next_bt.select_actions.extend (agent move_next)
			cancel_but.select_actions.extend (agent cancel)
			back_bt.select_actions.extend (agent move_previous)
			browse_but.select_actions.extend (agent browse_directories)
			create l_dir.make (Shared_constants.Application_constants.Temporary_html_directory)
			if l_dir.exists then
				l_dir.recursive_delete
			end
			l_dir.create_dir
			loc_text.set_text (l_dir.name)
			studio_radio.enable_select
			if Wizard_data.is_html_to_help_convert then
				location_title_separator.hide
				location_box.hide
			end
		end
	
feature {NONE} -- Implementation

	is_valid: BOOLEAN is
			-- Is Current content valid?  If not put error into
			-- `validation_error'
		local
			l_dir: DIRECTORY
			l_constants: APPLICATION_CONSTANTS
		do
			l_constants := Shared_constants.Application_constants
			if not Wizard_data.is_html_to_help_convert then
				if loc_text.text.is_empty then
					set_validation_error ((create {MESSAGE_CONSTANTS}).empty_location)
				else
					create l_dir.make (loc_text.text)
				end
			else
					-- For XML -> HTML -> Help always put HTML into intermediate directory
				create l_dir.make (l_constants.Temporary_html_directory)
				if l_dir.exists then
					l_dir.recursive_delete
				end
				l_dir.create_dir
			end
			if l_dir.exists then
					-- TO DO: Inform if not empty
				Result := True
				l_constants.set_html_location (l_dir.name)
				if studio_radio.is_selected then
					l_constants.set_output_filter (feature {APPLICATION_CONSTANTS}.studio_filter)
				elseif envision_radio.is_selected then
					l_constants.set_output_filter (feature {APPLICATION_CONSTANTS}.envision_filter)
				elseif all_radio.is_selected then
					l_constants.set_output_filter (feature {APPLICATION_CONSTANTS}.all_filter)
				end
			else
				set_validation_error ((create {MESSAGE_CONSTANTS}).directory_not_exist)
			end			
		ensure then
			error_set_if_invalid: Result = False implies (validation_error /= Void
				and not validation_error.is_empty)
		end
	
	browse_directories is
			-- Browse disk directory structure
		local
			l_directory_dialog: EV_DIRECTORY_DIALOG
		do
			create l_directory_dialog
			--open_dialog.set_filter (".xsd")
			l_directory_dialog.show_modal_to_window (Current)
			if l_directory_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_ok) then
				set_location (l_directory_dialog.directory)
			end
		end
	
	set_location (a_path: STRING) is
			-- Set transform location to `a_path'.
		do
			loc_text.set_text (a_path)
		end
	
	set_summary is
			-- Set summary data
		do
			Summary.wipe_out
			remove_summary
			if envision_radio.is_selected then
				add_option ("Filtered for ENViSioN.%N")
			elseif studio_radio.is_selected then
				add_option ("Filtered for EiffelStudio.%N")
			elseif all_radio.is_selected then
				add_option ("Not filtered (full content).%N")
			end
			add_option ("Location of files to transform:" + loc_text.text + "%N")
			Summary_list.extend (Summary)
		end

	summary: SUMMARY_BOX is 
		once
			create Result.make (Current, "Transformation Options")
		end
	
invariant
	has_next_or_previous: next_dialog /= Void or previous_dialog /= Void
	
end -- class TRANSFORM_DIALOG

