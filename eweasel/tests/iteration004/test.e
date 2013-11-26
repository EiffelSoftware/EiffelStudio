class TEST

inherit
	ITERABLE [STRING]
		rename
			new_cursor as cursor
		end

	ITERATION_CURSOR [STRING]
		rename
			after as done,
			forth as advance,
			item as value
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Run test.
		do
			across
				Current as c
			loop
				io.put_string (c.value)
				io.put_new_line
			end
		end

feature -- Iteration

	cursor: TEST
			-- <Precursor>
		do
			Result := Current
		end

	done: BOOLEAN
			-- <Precursor>

	begin
			-- <Precursor>
		do
			done := False
		end

	advance
			-- <Precursor>
		do
			done := True
		end

	value: STRING
			-- <Precursor>
		do
			Result := "OK"
		end

end
