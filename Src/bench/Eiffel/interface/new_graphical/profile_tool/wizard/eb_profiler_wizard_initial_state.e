indexing
	description	: "Initial State for the profiler wizard"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_PROFILER_WIZARD_INITIAL_STATE

inherit
	EB_WIZARD_INITIAL_STATE_WINDOW
		redefine
			proceed_with_current_info
		end
		
	EB_CONSTANTS
		export
			{NONE} all
		end

creation
	make

feature -- basic Operations

	proceed_with_current_info is 
		do
			proceed_with_new_state(create {EB_PROFILER_WIZARD_FIRST_STATE}.make (wizard_information))
		end

	display_state_text is
			-- Dispay the text for the current state.
		do
			title.set_text (Interface_names.wt_Profiler_welcome)
			message.set_text (Interface_names.wb_Profiler_welcome)
		end

end -- class EB_PROFILER_WIZARD_INITIAL_STATE
