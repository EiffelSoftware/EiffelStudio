indexing
	description	: "Error: selected .NET assembly filename is not valid."

class
	WIZARD_ERROR_FILE_NAME

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
			title.set_text (".NET Assembly Filename Error")
			message.set_text (
				"The .NET Assembly filename that you have chosen is not valid.%N%
				%%N%
				%Please click Back and choose another filename.")
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
	
end -- class WIZARD_ERROR_FILE_NAME

