indexing
	description: "Dialog for start of generation wizard."
	date: "$Date$"
	revision: "$Revision$"

class
	GENERATION_DIALOG

inherit
	GENERATION_DIALOG_IMP
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
			move_next,
			is_valid
		end

	SHARED_OBJECTS
		undefine
			copy,
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
			next1.select_actions.extend (agent move_next)
			cancel1.select_actions.extend (agent cancel)
			transform_radio.enable_select
		end

feature -- Status Setting

	move_next is
			-- Move to `next_dialog'
		local
			l_next: WIZARD_DIALOG
		do
			if transform_radio.is_selected then
				Wizard_data.set_conversion_type (To_html)
				create {FINAL_DIALOG} l_next.make_with_previous (Current)
				create {TRANSFORM_DIALOG} next_dialog.make (l_next, Current)
				l_next.set_previous (next_dialog)
			elseif help_radio.is_selected then
				Wizard_data.set_conversion_type (To_help)
				create {FINAL_DIALOG} l_next.make_with_previous (Current)
				create {HELP_DIALOG} next_dialog.make (l_next, Current)
				l_next.set_previous (next_dialog)				
			elseif transform_help_radio.is_selected then				
				Wizard_data.set_conversion_type (To_html_to_help)
				create {TRANSFORM_DIALOG} next_dialog.make_with_previous (Current)
				create {HELP_DIALOG} l_next.make_with_previous (next_dialog)
				next_dialog.set_next (l_next)	
				l_next.set_next (create {FINAL_DIALOG}.make_with_previous (l_next))
			end
			Precursor
		end
	
	set_summary is
			-- Set summary data
		do
			Summary.wipe_out
			remove_summary
			if transform_radio.is_selected then
				add_option ("Transforming XML to HTML.%N")
			elseif help_radio.is_selected then
				add_option ("Transforming HTML to Help Project.%N")
			elseif transform_help_radio.is_selected then	
				add_option ("Transforming XML to Help Project.%N")
			end
			Summary_list.extend (Summary)
		end
		
	summary: SUMMARY_BOX is 
		once
			create Result.make (Current, "Generation Type")
		end
	
feature {NONE} -- Implementation

	is_valid: BOOLEAN is
			-- Is content/selection choices valid to move on?
		do
			if transform_radio.is_selected or transform_help_radio.is_selected then			
				Result := Shared_project.preferences.has_schema and Shared_project.preferences.has_transform_file
				set_validation_error ("Missing Schema or XSL file required to perform document transformation.")
			else
				Result := True
			end
		end	

end -- class GENERATION_DIALOG

