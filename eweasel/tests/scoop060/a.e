class A

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		do
			modify (Current)
		end

feature -- Access

	value: E assign set

	value_at alias "[]" (index: INTEGER): E assign set_at
		do
		end

feature -- Modification

	modify (a: separate A)
		local
			e: E
		do
			a.value := e
			a [5] := e
		end

	set (e: E)
		do
		end

	set_at (e: E; index: INTEGER)
		do
		end

end
