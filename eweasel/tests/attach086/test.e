class TEST

create
	make,
	make_empty

feature

	make
			-- Run test.
		local
			i: INTEGER
			m: MEMORY
		do
			create m
			create t.make_empty
				-- Make `t' an old object
			from
				i := 1
			until
				i = 1000
			loop
				m.collect
				i := i + 1
			end

				-- We create the new string object
			io.put_string (t.s)
			io.put_new_line

				-- We trigger the GC cycle
			m.collect

				-- Now `t.s' should point to the new location
				-- but it is not. Let's create some dummy object
			from
				i := 1
			until
				i = 10
			loop
				(create {TEST}.make_empty).do_nothing
				i := i + 1
			end

				-- Let's print `t.s' again
			io.put_string (t.s)
			io.put_new_line
		end

	make_empty
		do
		end

	s: STRING
		attribute
			Result := "OK"
		end

	t: detachable TEST
		note
			option: stable
		attribute
		end


end

