class TEST

create
	make

feature {NONE} -- Creation
	
	make is 
			-- Run test.
		local
			h: HASH_TABLE [INTEGER, INTEGER]
			p: PROCEDURE [ANY, TUPLE]
			f: FUNCTION [ANY, TUPLE, INTEGER]
			i: PROCEDURE [ANY, TUPLE [INTEGER]]
		do
			$REGISTER_TYPES
			create h.make (1)
			p := agent h.put (1, 2)
			p.call (Void)
			io.put_integer (h.item (2))
			io.put_new_line
			p := agent h.put (2, 3)
			p := agent p.call (Void)
			p.call (Void)
			io.put_integer (h.item (3))
			io.put_new_line
			h.put (3, 4)
			f := agent h.item (4)
			io.put_integer (f.item (Void))
			io.put_new_line
			h.put (4, 5)
			f := agent h.item (5)
			f := agent f.item (Void)
			io.put_integer (f.item (Void))
			io.put_new_line
			i := agent h.put (?, 6)
			i.call ([5])
			io.put_integer (h.item (6))
			io.put_new_line
			f := agent {HASH_TABLE [INTEGER, INTEGER]}.item (7)
			h.put (6, 7)
			io.put_integer (f.item ([h]))
			io.put_new_line
		end

end
