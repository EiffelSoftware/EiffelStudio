indexing
	description: "Click on a breakable point highlights the all line."
	date: "$Date$";
	revision: "$Revision$"

class
	CLICK_BREAKABLE

inherit
	CLICK_STONE
		rename
			node as breakable
		redefine
			breakable
		end

creation
	make

feature -- Access

	breakable: BREAKABLE_STONE

feature -- Status setting

	set_end_position (e: INTEGER) is
			-- Assign `e' to `end_position'.
		do
			end_position := e
		end;

end -- class CLICK_BREAKABLE
