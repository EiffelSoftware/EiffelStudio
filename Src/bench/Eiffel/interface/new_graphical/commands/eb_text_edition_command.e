indexing
	description	: "Command to perform basic text operations"
	date		: "$Date$"
	revision	: "$Revision $"

class
	EB_TEXT_EDITION_COMMAND

inherit
	EB_TEXTABLE_COMMAND

	SYSTEM_CONSTANTS

creation
	make

feature -- Execution

	cut_selection is
			-- Cut selection into clipboard
		do
			tool.text_area.cut_selection
		end

	copy_selection is
			-- Copy selection into clipboard
		do
			tool.text_area.copy_selection
		end

	paste is
			-- Paste text in clipboard
		do
			tool.text_area.paste (tool.text_area.position)
		end

end -- class EB_TEXT_EDITION_COMMAND
