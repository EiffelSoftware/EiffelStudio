indexing
	description	: "Error: selected creation routine name is not a valid Eiffel identifier."

class
	WIZARD_ERROR_VALID_CREATION_ROUTINE_NAME

inherit
	BENCH_WIZARD_ERROR_STATE_WINDOW

creation
	make

feature -- basic Operations

	display_state_text is
		do
			title.set_text ("Creation Routine Name Error")
			message.set_text (
				"The creation routine name that you have specified does not conform%N%
				%the lace specification.%N%
				%%N%
				%A valid creation routine name is not empty and only contains letters,%N%
				%figures, and underscores. Moreover the first character must%N%
				%be a letter.%N%
				%%N%
				%Click Back and choose a valid creation routine name.")
		end

	final_message: STRING is
		do
		end

feature {WIZARD_STATE_WINDOW}

	pixmap_icon_location: FILE_NAME is
			-- Icon for the Eiffel Wizard
		once
			create Result.make_from_string ("eiffel_wizard_icon")
			Result.add_extension (pixmap_extension)
		end
	
end -- class WIZARD_ERROR_VALID_CREATION_ROUTINE_NAME

