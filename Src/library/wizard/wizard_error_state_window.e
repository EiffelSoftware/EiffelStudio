indexing
	description	: "Wizard state: Error "
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	WIZARD_ERROR_STATE_WINDOW

inherit
	WIZARD_FINAL_STATE_WINDOW
		redefine
			build,
			proceed_with_current_info
		end
			
feature -- Initialization

	build is
		do
			Precursor {WIZARD_FINAL_STATE_WINDOW}
			first_window.set_final_state ("Abort")
		end

feature -- basic Operations

	proceed_with_current_info is
		do
			cancel
			Precursor
		end

end -- class WIZARD_ERROR_STATE_WINDOW



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

