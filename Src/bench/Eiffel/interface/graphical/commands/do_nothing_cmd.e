indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DO_NOTHING_CMD

inherit
	COMMAND

feature --execute

	execute (arg: ANY) is
		-- just to redirect some actions
		-- that made ebench crash
		do
		end

end -- class DO_NOTHING_CMD
