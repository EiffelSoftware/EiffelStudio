-- Click on a breakable point highlights the all line.

class

	CLICK_BREAKABLE

inherit

	CLICK_STONE
		rename
			make as cs_make,
			node as breakable
		redefine
			end_focus, breakable
		end

creation

	make

feature -- Initialization
	
	make (a_stone: like breakable; s, e: INTEGER) is
			-- Initialize all attributes with arguments.
		do
			cs_make (a_stone, s, e);
			end_focus := e
		end;

feature -- Access

	end_focus: INTEGER;

	breakable: BREAKABLE_STONE

feature -- Status setting

	set_end_focus (e: INTEGER) is
			-- Assign `e' to `end_focus'.
		do
			end_focus := e
		end;

end -- class CLICK_BREAKABLE
