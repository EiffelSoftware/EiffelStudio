indexing
	description	: "Abstract notion of a command associated with a window"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_WINDOW_COMMAND

inherit
	EB_TARGET_COMMAND
		redefine
			target
		end

feature -- Properties

	target: EB_WINDOW
			-- Associated window.

end -- class EB_WINDOW_COMMAND
