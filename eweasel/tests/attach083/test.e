class TEST

create
        make,
        make_empty,
        make_uninitialized

feature

        make
        		-- Run test.
		local
			i: INTEGER
			t: TEST
                do
                	make_empty
                	from
                		i := 1_000
			until
				i <= 0
			loop
				create t.make_empty
				i := i - 1
			end
			create t.make_uninitialized
			io.put_string (t.s)
			io.put_new_line
			io.put_string (t.s)
			io.put_new_line
                end

        make_empty
        		-- Initialize `s' to an empty string.
                do
                	s := ""
                end

	make_uninitialized
			-- Do not initialize `s'.
		do
		end

	s: STRING
		local
			i: INTEGER
			t: TEST
		attribute
			state := state + 1
                	from
                		i := 1_000
			until
				i <= 0
			loop
				create t.make_empty
				i := i - 1
			end
			if state = 1 then
					-- This is the first execution, this is OK.
				Result := "OK"
			else
					-- This is not the first execution, this is not OK.
				Result := "FAIL"
			end
			(create {MEMORY}).full_collect
		end

	state: INTEGER	
			-- Current state of the execution.

end

