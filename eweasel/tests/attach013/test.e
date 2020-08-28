class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run tests.
		local
			i: INTEGER
		do
			create a.make_filled (Void, 1, 1)
			i := 1
			a [1] := create {CELL [STRING]}.put (Void)
			(a [1]).put ("Test OK")
			if attached {attached STRING} a.item (i).item as s then
				io.put_string (s)
			else
				io.put_string ("Test FAILED")
			end
			io.put_new_line
		end

feature {NONE} -- Data

	a: ARRAY [CELL [STRING]]
	
end
