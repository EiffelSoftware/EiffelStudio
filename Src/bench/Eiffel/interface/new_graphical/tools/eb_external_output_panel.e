indexing
	description: "Object used to display external command output and error"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXTERNAL_OUTPUT_PANEL

inherit
	EV_TEXT

feature
	clear is
			-- Clear `text'
		do
			set_text ("")
		end
		
	text_fully_loaded: BOOLEAN is
			-- Has `text' been fully loaded?
		do
			Result := True
		end
end
