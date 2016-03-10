class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		do
			test_object_test
			test_iteration
			test_separate
		end

feature {NONE} -- Access

	t: STRING = "test"

	ts: separate STRING
		do
			Result := t
		end

	z: REAL_64

feature {NONE} -- Inlining

	test_object_test
		do
			inline_object_test
		end

	test_iteration
		do
			inline_iteration
		end

	test_separate
		do
			inline_separate
		end

	inline_object_test
			-- Feature to be inlined.
		local
			x: REAL_64
		do
			x := z
			if attached t as s then
				put_string (s)
			end
			z := x
		end

	inline_iteration
			-- Feature to be inlined.
		local
			x: REAL_64
		do
			x := z
			across
				t as c
			loop
				put_character (c.item)
			end
			put_new_line
			z := x
		end

	inline_separate
			-- Feature to be inlined.
		local
			x: REAL_64
		do
			x := z
			separate ts as s do
				put_string (s)
			end
			z := x
		end

feature {NONE} -- Output

	put_string (s: separate STRING)
		do
			io.put_string (create {STRING}.make_from_separate (s))
			put_new_line
		end

	put_character (c: CHARACTER)
		do
			io.put_character (c)
		end

	put_new_line
		do
			io.put_new_line
		end

end
