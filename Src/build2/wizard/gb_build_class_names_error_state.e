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
			--
		do
			title.set_text ("Error")
			message.set_text ("Wrong names")
		end
		
	pixmap_icon_location: FILE_NAME is
			--
		once
			create Result.make_from_string ("eiffel_wizard_icon.png")
		end
		
	final_message: STRING is
			--
		do
			
		end
		

end -- class GB_BUILD_CLASS_NAMES_ERROR_STATE
