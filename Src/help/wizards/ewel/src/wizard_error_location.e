indexing
	description	: "Wizard state: Error in the choosen directory"
	author		: "David Solal"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WIZARD_ERROR_LOCATION

inherit
	BENCH_WIZARD_ERROR_STATE_WINDOW

creation
	make

feature -- basic Operations

	display_state_text is
		do
			title.set_text ("Location Error")
			message.set_text (
				"The directory you have choosen doesn't exist and the Wizard cannot create it.%N%
				%%N%
				%Click Back and choose another directory.")
		end

	final_message: STRING is
		do
		end

feature {WIZARD_STATE_WINDOW}

	pixmap_icon_location: FILE_NAME is
			-- Icon for the Eiffel Wel Wizard
		once
			create Result.make_from_string ("eiffel_wizard_icon")
			Result.add_extension (pixmap_extension)
		end
	
end -- class WIZARD_ERROR_LOCATION

