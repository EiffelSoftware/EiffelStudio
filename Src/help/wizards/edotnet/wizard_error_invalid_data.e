indexing
	description	: "Error: selected creation routine name is not a valid Eiffel identifier."

class
	WIZARD_ERROR_INVALID_DATA

inherit
	BENCH_WIZARD_ERROR_STATE_WINDOW
		redefine
			make
		end

creation
	make

feature {NONE} -- Implementation

	make (an_info: like wizard_information) is
			-- Set `help_filename' with `h_filename'.
		do
			set_help_filename (h_filename)
			Precursor {BENCH_WIZARD_ERROR_STATE_WINDOW} (an_info) 
		end

feature -- Access

	h_filename: STRING is "index.html"
			-- Path to HTML help filename
			
feature -- basic Operations

	display_state_text is
		do
			title.set_text ("Invalid Names Error")
			message.set_text (
				"Either the root class name or the creation routine name (or both of them) that you have specified%N%
				%does not conform the lace specification.%N%
				%%N%
				%A valid Eiffel name is not empty and only contains letters,%N%
				%figures, and underscores. Moreover the first character must%N%
				%be a letter.%N%
				%%N%
				%Click Back and choose valid Eiffel names.")
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
	
end -- class WIZARD_ERROR_INVALID_DATA

