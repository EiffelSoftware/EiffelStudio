indexing
	description	: "Final state of the wizard."
	author		: "David Solal"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_PROFILER_WIZARD_FINAL_STATE

inherit
	EB_WIZARD_FINAL_STATE_WINDOW

create
	make

feature -- Access

	display_state_text is
		do
			title.set_text ("Completing the Profiler Wizard")
			message.set_text ("You have specified the following settings:..")
		end

end -- class EB_PROFILER_WIZARD_FINAL_STATE
