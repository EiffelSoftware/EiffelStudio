indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_NOT_CONNECTED_STATE

inherit
	WIZARD_FINAL_STATE_WINDOW
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


	display_state_text is
		do
			title.set_text ("CONNECTION ERROR")
			message.set_text ("Unable to connect to database%N%NCheck the Username and Password%Nor the setup of your connection")
		end

	final_message: STRING is
		do
		end

feature {WIZARD_STATE_WINDOW}

	pixmap_icon_location: FILE_NAME is
			--
		do
			create Result.make_from_string ("eiffel_wizard_icon.png")
		end



end -- class WIZARD_NOT_CONNECTED_STATE
