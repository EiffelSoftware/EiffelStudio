indexing
	description	: "Template for the last state of a wizard"
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_WIZARD_FINAL_STATE_WINDOW

inherit
	EB_WIZARD_INITIAL_STATE_WINDOW
		export
			{NONE} all
		redefine
			display,
			proceed_with_current_info,
			is_final_state
		end

feature -- Basic Operations

	display is
			-- Display Current State
		do
			first_window.set_final_state ("Finish")
			build
		end

	proceed_with_current_info is
			-- destroy the window.
			-- Descendants have to redefine this routine
			-- if they want to add generation, warnings, ...
		do
			first_window.destroy
		ensure then
			application_dead: first_window.is_destroyed
		end

feature -- Access

	is_final_state: BOOLEAN is TRUE
			-- This state is a final state.

end -- class EB_WIZARD_FINAL_STATE_WINDOW
