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
				"The directory you have choosen doesn't exist%N%
				%and the Wizard cannot create it.%N%
				%%N%
				%Click Back and choose another directory.")
		end

	final_message: STRING is
		do
		end

feature {WIZARD_STATE_WINDOW}

	pixmap_icon_location: STRING is "eiffel_wizard_icon.bmp"

end -- class WIZARD_ERROR_LOCATION