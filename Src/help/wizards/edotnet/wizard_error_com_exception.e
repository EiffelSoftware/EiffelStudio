indexing
	description	: "Error: Unable to reach the com component."

class
	WIZARD_ERROR_COM_EXCEPTION

inherit
	BENCH_WIZARD_ERROR_STATE_WINDOW
		redefine
			make,
			build
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
		
	build is
		do
			Precursor {BENCH_WIZARD_ERROR_STATE_WINDOW}
			First_window.disable_back_button
		end
		
		

feature -- Access

	h_filename: STRING is "index.html"
			-- Path to HTML help filename
			
feature -- basic Operations

	display_state_text is
		do
			title.set_text (interface_names.t_Wizard_instalation_error)
			message.set_text (interface_names.m_Wizard_instalation_error)
		end

	final_message: STRING is
		do
		end

feature {WIZARD_STATE_WINDOW}

	pixmap_icon_location: FILE_NAME is
			-- Icon for the Eiffel Wizard
		once
			create Result.make_from_string (Wizard_icon_name)
			Result.add_extension (pixmap_extension)
		end
	
end -- class WIZARD_ERROR_COM_EXCEPTION

