indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_ERROR_RESSOURCE_BENCH


inherit
	WIZARD_FINAL_STATE_WINDOW
--		rename
--			pixmap_location as last_pixmap_location
		redefine
			build
		end

creation
	make


feature -- Initialization

	build is
		do
			Precursor
			first_window.set_final_state ("Abort")
		end


feature -- basic Operations

	display_state_text is
		do
			title.set_text ("PLEASE CORRECT SELECTION")
			message.set_text ("%NA Dialog-Based Application must have a main dialog.%
								%%N%NPlease make sure that exactly one of the dialogs inherit from WEL_MAIN_DIALOG%
								%%NThis will be your main dialog.%
								%%N%N%NUse the Back button to correct your selection.%
								%")
		end

	final_message: STRING is
		do
		end

feature {WIZARD_STATE_WINDOW}

--	pixmap_location: STRING is "f_state_red.bmp"

	pixmap_icon_location: STRING is "eiffel_wizard_icon.bmp"

end -- class WIZARD_ERROR_RESSOURCE_BENCH
