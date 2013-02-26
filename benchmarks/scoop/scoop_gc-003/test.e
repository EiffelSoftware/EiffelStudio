note
	description: "[
		Create processors without using them
		in a tree-like way, so that the first processor
		starts n "second-level" processors, they start
		a new level, etc.
	]"

class TEST

inherit
	ANY

create
	default_create,
	make

feature {NONE} -- Creation

	make
			-- Run test.
		local
			a: ARGUMENTS_32
			c: like {ARGUMENTS_32}.argument_count
			i: NATURAL_64
			n: NATURAL_64
			s: like {DATE_TIME_DURATION}.seconds_count
		do
			create a
			c := a.argument_count
			if
				(c /= 1 and then c /= 2) or else
				not a.argument (1).is_natural_64 or else
				(c = 2 and then not a.argument (2).is_natural_64)
			then
				io.error.put_string ("Usage: test number_of_iterations [arity]")
				(create {EXCEPTIONS}).die (-1)
			end
			i := a.argument (1).to_natural_64
			if c > 1 then
					-- Retrieve arity of the tree nodes.
				n := a.argument (2).to_natural_64
			else
					-- Default to the binary tree.
				n := 2
			end
			s := (create {DATE_TIME}.make_now_utc).relative_duration (create {DATE_TIME}.make_from_epoch (0)).seconds_count
			execute (i - 1, i, n, s)
		end

feature {TEST} -- Run

	execute (b, i, n: NATURAL_64; s: like {DATE_TIME_DURATION}.seconds_count)
			-- Start at most `n' more immediate child processors
			-- with the total of `i' child processors unless `i = 0'
			-- with higher number `b' with the overall start time `s'.
		local
			j: NATURAL_64
			k: NATURAL_64
			m: NATURAL_64
			c: NATURAL_64
		do
			if b = 0 then
				io.put_integer_64 ((create {DATE_TIME}.make_now_utc).relative_duration (create {DATE_TIME}.make_from_epoch (s.to_integer_32)).seconds_count)
			else
				from
					k := i - 1
					c := b - 1
					m := (k + n - 1) // n
					j := n.min (k)
				until
					j <= 0
				loop
					j := j - 1
					run (create {separate TEST}, c, m.min (k), n, s)
					c := c - m.min (k)
					k := k - m
				end
			end
		end

	run (t: separate TEST; b, i, n: NATURAL_64; s: like {DATE_TIME_DURATION}.seconds_count)
			-- Run `t.execute'.
		do
			t.execute (b, i, n, s)
		end

end
