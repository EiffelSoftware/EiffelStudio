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
			Precursor
			first_window.set_final_state ("Abort")
		end

feature -- basic Operations

	proceed_with_current_info is
		do
			cancel
			Precursor
		end

end -- class WIZARD_ERROR_STATE_WINDOW

