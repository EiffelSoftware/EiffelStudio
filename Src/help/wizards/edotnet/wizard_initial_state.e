indexing
	description	: "Initial State"
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WIZARD_INITIAL_STATE

inherit
	BENCH_WIZARD_INITIAL_STATE_WINDOW
		redefine
			proceed_with_current_info,
			make
		end

creation
	make

feature {NONE} -- Implementation

	make (an_info: like wizard_information) is
			-- Set `help_filename' with `h_filename'.
		do
			set_help_filename (h_filename)
			Precursor {BENCH_WIZARD_INITIAL_STATE_WINDOW} (an_info) 
		end
		
feature -- Access

	h_filename: STRING is "reference\01_welcome\index.html"
			-- Path to HTML help file
			
feature -- basic Operations

	proceed_with_current_info is 
		do
			Precursor
			proceed_with_new_state(Create {WIZARD_PROJECT_NAME_AND_LOCATION_STATE}.make(wizard_information))
		end

	display_state_text is
			-- Dispay the text for the current state.
		do
			title.set_text (Interface_names.m_Welcome_title)
			message.set_text (Interface_names.m_Welcome_message)
		end

	pixmap_icon_location: FILE_NAME is
			-- Icon for the Eiffel Dotnet Wizard.
		once
			 create Result.make_from_string ("eiffel_wizard_icon")
			 Result.add_extension (pixmap_extension)
		end
	
end -- class WIZARD_INITIAL_STATE
