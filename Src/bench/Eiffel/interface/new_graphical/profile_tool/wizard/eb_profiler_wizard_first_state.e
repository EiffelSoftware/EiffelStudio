indexing
	description	: "First state of the profiler wizard (Choose compilation mode)"
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_PROFILER_WIZARD_FIRST_STATE

inherit
	EB_WIZARD_INTERMEDIARY_STATE_WINDOW
		redefine
			update_state_information,
			proceed_with_current_info,
			build
		end
		
	EB_PROFILER_WIZARD_SHARED_INFORMATION
		export
			{NONE} all
		end

	PROJECT_CONTEXT
		export
			{NONE} all
		end
		
	EB_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature -- Basic Operation

	build is 
			-- Build entries.
		local
			compilation_mode_radio_box: EV_VERTICAL_BOX
		do 
				-- Radio buttons
			create profile_workbench_system.make_with_text (Interface_names.l_Workbench_mode)
			create profile_finalized_system.make_with_text (Interface_names.l_Finalized_mode)
			create compilation_mode_radio_box
			compilation_mode_radio_box.set_border_width (Default_border_size)
			compilation_mode_radio_box.extend (profile_workbench_system)
			compilation_mode_radio_box.extend (profile_finalized_system)

				-- Link
			choice_box.extend (compilation_mode_radio_box)
			choice_box.disable_item_expand (compilation_mode_radio_box)
			choice_box.extend (create {EV_CELL})

				-- Update controls to reflect `wizard_information'
			if information.workbench_mode then
				profile_workbench_system.enable_select
			else
				profile_finalized_system.enable_select
			end
		end

	proceed_with_current_info is
		local
			next_state: EB_WIZARD_STATE_WINDOW
		do
			if information.existing_profile = Void then
				next_state := create {EB_PROFILER_WIZARD_THIRD_STATE}.make (wizard_information)
			else
				next_state := create {EB_PROFILER_WIZARD_SECOND_STATE}.make (wizard_information)
			end

			proceed_with_new_state (next_state)
		end

	update_state_information is
			-- Check User Entries
		do
			Precursor
			if profile_workbench_system.is_selected then
				information.set_workbench_mode
			else
				information.set_finalized_mode
			end
		end

feature {NONE} -- Implementation

	display_state_text is
		do
			title.set_text (Interface_names.wt_Compilation_mode)
			subtitle.set_text (Interface_names.ws_Compilation_mode)
			message.set_text (Interface_names.ws_Compilation_mode)
		end

feature {NONE} -- Vision2 controls

	profile_workbench_system: EV_RADIO_BUTTON
			-- When checked, analyse the profiling of a system compiled
			-- in workbench mode.
			
	profile_finalized_system: EV_RADIO_BUTTON
			-- When checked, analyse the profiling of a system compiled
			-- in finalized mode.
			
end -- class EB_PROFILER_WIZARD_FIRST_STATE
