indexing
	description	: "Wizard state: Error in the project name"
	author		: "David Solal"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WIZARD_ERROR_PROJECT_NAME

inherit
	BENCH_WIZARD_ERROR_STATE_WINDOW

creation
	make

feature -- basic Operations

	display_state_text is
		do
			title.set_text ("Project Name Error")
			message.set_text (
				"The project name that you have specified does not conform%N%
				%the lace specification.%N%
				%%N%
				%A valid project name is not empty and only contains letters,%N%
				%figures, and underscores. Moreover the first character must%N%
				%be a letter.%N%
				%%N%
				%Click Back and choose a valid project name.")
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
	
end -- class WIZARD_ERROR_PROJECT_NAME

