indexing
	description	: "Abstract notion of a command for a textable target"
	author		: "Christophe Bonnard"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_TEXTABLE_COMMAND

inherit
	EB_TARGET_COMMAND
		redefine
			target
		end

feature -- Properties

	target: EB_TEXTABLE
			-- The tool

end -- class EB_TEXTABLE_COMMAND
