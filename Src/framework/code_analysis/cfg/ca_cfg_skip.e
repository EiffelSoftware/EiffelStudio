note
	description: "Represents a skip block in the CFG. This block contains no other information than incoming and outgoing edges."
	author: "Stefan Zurfluh"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_CFG_SKIP

inherit
	CA_CFG_BASIC_BLOCK

create
	make

feature {NONE} -- Initialization

	make (a_label: INTEGER)
			-- Initializes `Current' and sets its label to `a_label'.
		do
			initialize
			label := a_label
		end

end
