indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_ERROR_RESSOURCE_BENCH


inherit
	WIZARD_FINAL_STATE_WINDOW
		rename
			pixmap_location as last_pixmap_location
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
			title.set_text ("ROOT DIALOG ERROR")
			message.set_text ("%NWhen you create a dialog application, you must choose a main dialog.%
								%%N%NTo specify it, you must have one and only one dialog that inherit from%
								% the class WEL_MAIN_DIALOG.%
								%%N%NYou should go back to the previous step and make sure that one of your %
								%dialog inherit from this class.")
		end

	final_message: STRING is
		do
		end

feature {WIZARD_STATE_WINDOW}

	pixmap_location: STRING is "f_state_red.bmp"

end -- class WIZARD_ERROR_RESSOURCE_BENCH
