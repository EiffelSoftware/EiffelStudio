indexing
	description: "Objects that represent an Error in the supplied names."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_BUILD_CLASS_NAMES_ERROR_STATE

inherit
	WIZARD_ERROR_STATE_WINDOW
	
create
	make 
	
feature -- basic Operations

	display_state_text is
			-- Display relevent information to state represented by `Current'.
		do
			title.set_text ("System information error")
			message.set_text ("There are one or more errors in the names you selected.%NPlease check the class%
			% and project names are valid Eiffel class names.%N%NClass names should only include alphanumeric%
			% characters or underscores and%Nstart with an alphabetic character.%N%NThe selected names must also%
			% be unique.")
		end
		
	pixmap_icon_location: FILE_NAME is
			-- Location of pixmap displayed.
		once
			create Result.make_from_string ("eiffel_wizard_icon.png")
		end
		
	final_message: STRING is
			--
		do
			
		end
		

end -- class GB_BUILD_CLASS_NAMES_ERROR_STATE
