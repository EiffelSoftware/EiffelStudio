indexing
	description: "Dialog used for final wizard interaction.  Shows summary%
		%of previous steps taken from WIZARD_INFORMATION, and must call%
		%appropriate wizard generation procedure(s) using `finish_wizard'."
	date: "$Date$"
	revision: "$Revision$"

class
	FINAL_DIALOG

inherit
	FINAL_DIALOG_IMP
		undefine
			show
		end

	WIZARD_DIALOG
		rename
			user_initialization as wizard_user_initialization,
			move_next as finish
		undefine
			initialize,
			is_in_default_state
		end
		
	SHARED_OBJECTS
		undefine
			copy,
			default_create
		end

create
	make_with_previous	

feature {NONE} -- Initialization

	user_initialization is
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			finish_bt.select_actions.extend (agent finish_wizard)
			back_bt2.select_actions.extend (agent move_previous)
			cancel_bt1.select_actions.extend (agent cancel)
			show_actions.extend (agent show_summary)
		end

feature {NONE} -- Implementation

	show_summary is
			-- Show summary of Wizard option
		local
			l_summary: EV_FRAME
		do
			from
				summary_box.wipe_out
				Summary_list.start
			until
				Summary_list.after
			loop
				l_summary := Summary_list.item.frame
				summary_box.extend (l_summary)
				summary_box.disable_item_expand (l_summary)
				Summary_list.forth
			end
		end

	finish_wizard is
			-- Finish wizard, perform necessary tasks.
		do
			hide
			if Wizard_data.is_html_convert then
				generate_html				
			elseif Wizard_data.is_help_convert then
				generate_help
			elseif Wizard_data.is_html_to_help_convert then
				generate_html
				generate_help
			end
			destroy
		end

	set_summary is
			-- Set summary data
		do		
		end
		
	summary: SUMMARY_BOX is 
			-- Summary widget
		once
			create Result.make (Current, "Summary")	
		end
		
feature {NONE} -- Implmentation

	generate_html is
			-- Generate HTML
		local
			html: HTML_GENERATOR
		do
			create html.make (Shared_project, create {DIRECTORY_NAME}.make_from_string (Shared_constants.Application_constants.html_location))
			html.generate
		end
	
	generate_help is
			-- Generate help	
		local			
			help: HELP_GENERATOR
			l_loc, l_toc: DIRECTORY
			l_help_settings: HELP_SETTING_CONSTANTS
		do			
			l_help_settings := Shared_constants.Help_constants
			create l_loc.make (l_help_settings.help_directory)
			create l_toc.make (l_help_settings.help_toc_location)
			if l_help_settings.is_html_help then
				if l_help_settings.toc_is_physical then
					create help.make (create {HTML_HELP_PROJECT}.make_from_directory (l_loc, l_toc, l_help_settings.help_project_name))
					help.generate
				else
					create help.make (create {HTML_HELP_PROJECT}.make_from_toc (l_loc, l_help_settings.help_project_name, Application_window.internal_studio_toc))
					help.generate
				end				
			elseif l_help_settings.is_vsip_help then
				if l_help_settings.toc_is_physical then
					create help.make (create {MSHELP_PROJECT}.make_from_directory (l_loc, l_toc, l_help_settings.help_project_name))
					help.generate
				else
					create help.make (create {MSHELP_PROJECT}.make_from_toc (l_loc, l_help_settings.help_project_name, Application_window.internal_envision_toc))
					help.generate
				end
			elseif l_help_settings.is_web_help then
				-- TO DO: Web generation
				--create {WEB_HELP_PROJECT} help.create_with_filename (Wizard_data.help_generated_file_location, Wizard_data.help_project_name)
			end
		end

invariant
	has_previous: previous_dialog /= Void
	not_has_next: next_dialog = Void

end -- class FINAL_DIALOG

