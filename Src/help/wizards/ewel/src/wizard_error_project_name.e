indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_ERROR_PROJECT_NAME

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
			title.set_text ("PROJECT NAME ERROR")
			message.set_text ("%NThe project name that you have specify doesn't conform the ace file.%N%
								%%NChoose an other one by pushing the back button.")
		end

	final_message: STRING is
		do
		end

feature {WIZARD_STATE_WINDOW}

	pixmap_location: STRING is "f_state_red.bmp"

end -- class WIZARD_ERROR_PROJECT_NAME

