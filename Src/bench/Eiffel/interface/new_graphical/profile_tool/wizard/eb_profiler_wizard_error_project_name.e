indexing
	description	: "Wizard state: Error in the project name"
	author		: "David Solal"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_PROFILER_WIZARD_ERROR_PROJECT_NAME

inherit
	WIZARD_ERROR_STATE_WINDOW

creation
	make

feature -- basic Operations

	display_state_text is
		do
			title.set_text ("Project Name Error")
			message.set_text (
				"The project name that you have specify doesn't conform the ace file.%N%N%
				%Click Back and choose another directory.")
		end

	final_message: STRING is
		do
		end

feature {WIZARD_STATE_WINDOW}

	pixmap_icon_location: STRING is "eiffel_wizard_icon.bmp"

end -- class WIZARD_ERROR_PROJECT_NAME

