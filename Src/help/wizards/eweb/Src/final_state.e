indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FINAL_STATE

inherit
	WIZARD_FINAL_STATE_WINDOW

creation
	make

feature -- Basic Operations

	display is 
		do
			build
		end

feature -- Access

	title: STRING is "Final Step"

	message: STRING is "blablabal"

	pixmap_location: STRING is "small_essai.bmp"

end -- class FINAL_STATE
