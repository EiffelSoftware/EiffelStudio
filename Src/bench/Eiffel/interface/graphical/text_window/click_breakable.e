-- Click on a breakable point highlights the all line.

class

	CLICK_BREAKABLE

inherit

	CLICK_STONE
		rename
			make as cs_make
		redefine
			end_focus
		end

creation

	make

feature
	
	make (a_node: like node; s, e: INTEGER) is
			-- Initialize all attributes with arguments.
		do
			cs_make (a_node, s, e);
			end_focus := e
		end;

	end_focus: INTEGER;

	set_end_focus (e: INTEGER) is
			-- Assign `e' to `end_focus'.
		do
			end_focus := e
		end;

end -- class CLICK_BREAKABLE
