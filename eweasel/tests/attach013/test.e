class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run tests.
		local
			i: INTEGER
		do
			create a.make (1, 1)
			i := 1
			a [1] := create {CELL [STRING]}
			(a [1]).put ("Test OK")
			if {s: !STRING} a.item (i).item then
				io.put_string (s)
			else
				io.put_string ("Test FAILED")
			end
			io.put_new_line
		end

feature {NONE} -- Data

	a: ARRAY [CELL [STRING]]
	
end