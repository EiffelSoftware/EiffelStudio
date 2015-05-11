class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		local
			a: A
		do
			create a.make
			modify (Current)
		end

feature -- Access

	item: TEST assign put
		do
			Result := Current
		end

	at alias "[]" (index: INTEGER): TEST assign put_at
		do
			Result := Current
		end

feature -- Modification

	modify (t: separate TEST)
		local
			e: E
		do
			t.item := Current
			t [5] := Current
		end

	put (t: TEST)
		do
		end

	put_at (t: TEST; i: INTEGER)
		do
		end

end
