note
	description: "Very simple class meant to test schema evolution scenarios."
	author: "Marco Piccioni"
	date: "$Date$"
	revision: "$Revision$"
	version: "1"

class
	FLAT_CLASS

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			att_1 := "One"
			att_2 := "Two"
			att_3 := 3
			att_4 := 4
			att_5 := True
		end

feature -- Access

	att_1: STRING

	att_2: STRING

	att_3: INTEGER

	att_4: INTEGER

	att_5: BOOLEAN


feature -- Status setting


invariant
	invariant_clause: att_3 + att_4 = 7

end
