indexing
	description	: "Abstract notion of a command for the editor"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_EDITOR_COMMAND

inherit

	EB_STANDARD_CMD
		redefine
			initialize
		end

	TEXT_OBSERVER
		redefine
			on_text_loaded
		end

creation
	make

feature -- Initialization

	initialize is
		do	
			Precursor
			disable_sensitive
		end

feature -- observer pattern

	on_text_loaded is
			-- make the command sensitive
		do
			enable_sensitive
		end

end -- class EB_EDITOR_COMMAND
