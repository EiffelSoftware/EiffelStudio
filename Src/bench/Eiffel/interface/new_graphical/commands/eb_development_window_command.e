indexing
	description	: "Abstract notion of a command associated with a development window"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_DEVELOPMENT_WINDOW_COMMAND

inherit
	EB_WINDOW_COMMAND
		redefine
			target
		end

feature -- Properties

	target: EB_DEVELOPMENT_WINDOW
			-- Associated target.

end -- class EB_DEVELOPMENT_WINDOW_COMMAND
