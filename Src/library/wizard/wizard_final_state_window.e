indexing
	description	: "Template for the last state of a wizard"
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	WIZARD_FINAL_STATE_WINDOW

inherit
	WIZARD_INITIAL_STATE_WINDOW
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
			precursor
			first_window.destroy
		ensure then
			application_dead: first_window.is_destroyed
		end

	notify_user (s: STRING) is
			-- Output
		require
			not_void: s /= Void
		do
			progress_text.set_text(s)
			iteration := iteration + 1
			progress.set_proportion(iteration/total)
		end

	total, iteration: INTEGER

	ebench_launcher: EBENCH_LAUNCHER
		-- Class to launch ebench after the generation

feature -- Access

	is_final_state: BOOLEAN is TRUE

	final_message: STRING is 
		deferred
		end

	progress_text: EV_LABEL

	progress: EV_HORIZONTAL_PROGRESS_BAR

end -- class WIZARD_FINAL_STATE_WINDOW


--|----------------------------------------------------------------
--| EiffelWizard: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

