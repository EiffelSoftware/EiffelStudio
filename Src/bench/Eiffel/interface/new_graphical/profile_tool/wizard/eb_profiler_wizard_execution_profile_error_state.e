indexing
	description	: "Wizard state: Error in the supplied execution profile."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_PROFILER_WIZARD_EXECUTION_PROFILE_ERROR_STATE

inherit
	EB_WIZARD_ERROR_STATE_WINDOW
	
	EB_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature -- basic Operations

	display_state_text is
		do
			title.set_text (Interface_names.wt_Execution_profile_error)
			message.set_text (Interface_names.wb_Execution_profile_error)
		end

end -- class EB_PROFILER_WIZARD_EXECUTION_PROFILE_ERROR_STATE
