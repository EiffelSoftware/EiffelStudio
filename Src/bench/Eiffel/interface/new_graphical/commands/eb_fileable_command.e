indexing
	description	: "Abstract notion of a command for a target containing a file"
	date		: "$Date$"
	revision	: "$Revision$"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"

deferred class
	EB_FILEABLE_COMMAND

inherit
	EB_TARGET_COMMAND
		redefine
			target
		end

feature -- Properties

	target: EB_FILEABLE
			-- Target for the command.

end -- class EB_FILEABLE_COMMAND
