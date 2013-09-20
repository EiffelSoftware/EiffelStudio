note
	description: "Summary description for {CHAIN_HEAD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CHAIN_HEAD

create
	make

feature {NONE} -- Initialization

	make (t: CHAIN_TAIL)
			-- Initialization for `Current'.
		do
			tail := t
		end

feature

	level: INTEGER = 0

	tail: CHAIN_TAIL

end
