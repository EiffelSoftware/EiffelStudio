class TEST

create
	make,
	make_initialized

feature {NONE} -- Creation

	make
			-- Run the test.
		local
			t: separate TEST
			ao, po: separate like io
		do
			create t.make_initialized
				-- 1
			separate t as s do
					-- 2
				ao := s.io
					-- 3
			end
			test (t, ao, ao, "Active:")

			create <NONE> t.make_initialized
				-- 1
			separate t as s do
					-- 2
				po := s.io
					-- 3
			end
			test (t, ao, po, "Passive:")
		end

	make_initialized
			-- Initialize object.
		do
		end

feature {NONE} -- Testing

	test (s: separate TEST; y, w: separate STD_FILES; name: STRING)
			-- Run test `name` on object `s` using `w` for output and synchronizing on `y` before doing it.
		do
			y.last_character.do_nothing
			across name as c loop
				w.put_character (c.item)
			end
			w.put_new_line

			w.put_integer (1)
			w.put_character (':')
				-- 4
			s.enable_output
				-- #5
			w.put_new_line

			w.put_integer (2)
			w.put_character (':')
				-- #6
			s.enable_output
				-- #7
			w.put_new_line

			w.put_integer (3)
			w.put_character (':')
				-- #8
			s.enable_output
				-- #9
			w.put_new_line

			w.put_integer (4)
			w.put_character (':')
				-- #10
			s.enable_qualified
				-- #11
			w.put_new_line

			w.put_integer (5)
			w.put_character (':')
				-- #12
				-- (12)
			s.report
				-- #13
			w.put_new_line

			check
				(agent (z: separate TEST; v: separate like io): BOOLEAN
					do
						v.put_integer (6)
						v.put_character (':')
							-- The class invariant check is suppressed by the outer check instruction.
							-- (13)
						z.report
							-- The class invariant check is suppressed by the outer check instruction.
						v.put_new_line
						Result := True
					end
				(s, w)).item
			end

			w.put_integer (7)
			w.put_character (':')
				-- #14
				-- (14)
			s.report
				-- #15
			w.put_new_line

			w.put_integer (8)
			w.put_character (':')
				-- #16
			s.is_talking.do_nothing
				-- #17
			w.put_new_line

			check
				(agent (z: separate TEST; v: separate like io): BOOLEAN
					do
						v.put_integer (9)
						v.put_character (':')
							-- The class invariant check is suppressed by the outer check instruction.
						z.is_talking.do_nothing
							-- The class invariant check is suppressed by the outer check instruction.
						v.put_new_line
						Result := True
					end
				(s, w)).item
			end

			w.put_integer (10)
			w.put_character (':')
				-- #18
			s.is_talking.do_nothing
				-- #19
			w.put_new_line

		end

feature -- Status report

	is_verbose: BOOLEAN
			-- Is output verbose?

	is_qualified: BOOLEAN
			-- Are qualified calls enabled at end of an invariant function?

	is_called: BOOLEAN
			-- Is this feature called?
			-- Increment `count` by `1` and print it if `is_verbose`.
		do
			Result := True
			count := count + 1
			if is_verbose then
				io.put_string (" #")
				io.put_integer (count)
			end
			if is_qualified then
				io.out.do_nothing
			else
				noop
			end
		end

	is_talking: BOOLEAN
			-- Same as `is_verbose`.
		do
			Result := is_verbose
		end

feature -- Measurement

	count: INTEGER
			-- Number of times `is_called` is called.

feature -- Modification

	enable_output
			-- Enable verbose output of `is_called`.
		do
			is_verbose := True
		end

	enable_qualified
			-- Enable qualified calls.
		do
			is_qualified := True
		end

feature -- Basic operation

	noop
			-- Do not do anything.
		do
		end

	report
			-- Report current value of `count`.
		do
			io.put_string (" (")
			io.put_integer (count)
			io.put_string (")")
			noop
		end

invariant

	is_called

end