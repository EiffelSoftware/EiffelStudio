indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DB_ERROR_LOCATION

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


feature -- basic Operations

	display_state_text is
		do
			title.set_text ("LOCATION ERROR")
			message.set_text ("%TThe Directory provided doesn't exist.%
								%%N%NChoose another folder or use the Browse button")
		end

	final_message: STRING is
		do
		end

feature {WIZARD_STATE_WINDOW}

	pixmap_icon_location: FILE_NAME is
			--
		do	
			create Result.make_from_string ("eiffel_wizard_icon")
			Result.add_extension (pixmap_extension)
		end

end -- class DB_ERROR_LOCATION
