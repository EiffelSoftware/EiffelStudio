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
			move_next
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
			set_options
		end

feature -- Status Setting

	move_next is
			-- Move to `next_dialog'
		local
			l_next: WIZARD_DIALOG
			l_dir: DIRECTORY
		do
			if transform_radio.is_selected then
				Wizard_data.set_conversion_type (To_html)
				create {FINAL_DIALOG} l_next.make_with_previous (Current)
				create {TRANSFORM_DIALOG} next_dialog.make (l_next, Current)
				l_next.set_previous (next_dialog)
			elseif help_radio.is_selected or transform_help_radio.is_selected then
			
				if help_radio.is_selected then
					Wizard_data.set_conversion_type (To_help)
				elseif transform_help_radio.is_selected then					
					Wizard_data.set_conversion_type (To_html_to_help)
							-- For [XML -> HTML -> Help] always put HTML into intermediate directory
					create l_dir.make (Shared_constants.Application_constants.Temporary_html_directory)
					if l_dir.exists then
						l_dir.recursive_delete
					end
					l_dir.create_dir
					Shared_constants.Application_constants.set_html_location (l_dir.name)
				end
				
				create {FINAL_DIALOG} l_next.make_with_previous (Current)
				create {HELP_DIALOG} next_dialog.make (l_next, Current)
				l_next.set_previous (next_dialog)				
--			elseif transform_help_radio.is_selected then				
--				Wizard_data.set_conversion_type (To_html_to_help)
--				create {HELP_DIALOG} l_next.make_with_previous (next_dialog)
--				next_dialog.set_next (l_next)	
--				l_next.set_next (create {FINAL_DIALOG}.make_with_previous (l_next))
			end
			Precursor
		end
	
feature {NONE} -- Implementation

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
			-- Summary widget
		once
			create Result.make (Current, "Generation Type")
		end

	set_options is
			-- Set available options
		local
			l_has_schema,
			l_has_toc: BOOLEAN
		do
			l_has_schema := Shared_document_manager.has_schema
			l_has_toc := not Shared_toc_manager.is_empty
			if l_has_schema and then l_has_toc then
				transform_box.enable_sensitive
				help_box.enable_sensitive
				transform_help_box.enable_sensitive
			elseif l_has_schema then
				transform_box.enable_sensitive
				help_box.disable_sensitive
				transform_help_box.disable_sensitive
			elseif l_has_toc then
				transform_box.disable_sensitive
				help_box.enable_sensitive
				transform_help_box.disable_sensitive
			end
		end	

end -- class GENERATION_DIALOG

