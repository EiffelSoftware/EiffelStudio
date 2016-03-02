class TEST

inherit
	MEMORY

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		local
			a: ARGUMENTS_32
		do
			create time.make (4)
			create a
			if
				a.argument_count /= 1 or else
				not (a.argument (1).is_natural_8 and then a.argument (1).to_natural_8 <= 63)
			then
				io.error.put_string ("[
					Usage: test power
					
					power - 2^power is number of times to access elements of a structure in a loop.
					0 - estimate power to complete one iteration in about 1 second.
				]")
				(create {EXCEPTIONS}).die (-1)
			end
			power := a.argument (1).to_natural_8
			if power = 0 then
					-- Compure `power'.
				run (agent (i: INTEGER; n: NATURAL_64; start, stop: DATE_TIME)
					local
						target: SPECIAL [CHARACTER_32]
						j: NATURAL_64
						x: INTEGER
						y: CHARACTER_32
					do
						target := special_basic [i]
						start.make_now_utc
						from j := n until j <= 0 loop
							across target as c loop
								y := c.item
								x := x + y.code
							end
							j := j - 1
						end
						stop.make_now_utc
						answer := x
					end,
					"SPECIAL")
			end
				-- String
			run (agent (i: INTEGER; n: NATURAL_64; start, stop: DATE_TIME)
				local
					target: STRING_32
					j: NATURAL_64
					x: INTEGER
					y: CHARACTER_32
				do
					target := string [i]
					start.make_now_utc
					from j := n until j <= 0 loop
						across target as c loop
							y := c.item
							x := x + y.code
						end
						j := j - 1
					end
					stop.make_now_utc
					answer := x
				end,
				"STRING_32 across")
--			run (agent (i: INTEGER; n: NATURAL_64; start, stop: DATE_TIME)
--				local
--					target: separate STRING_32
--					j: NATURAL_64
--					x: INTEGER
--					y: CHARACTER_32
--				do
--					target := string [i]
--					start.make_now_utc
--					from j := n until j <= 0 loop
--						across target as c loop
--							y := c.item
--							x := x + y.code
--						end
--						j := j - 1
--					end
--					stop.make_now_utc
--					answer := x
--				end,
--				"separate STRING_32 across")
				-- Special
			run (agent (i: INTEGER; n: NATURAL_64; start, stop: DATE_TIME)
				local
					target: SPECIAL [CHARACTER_32]
					j: NATURAL_64
					x: INTEGER
					y: CHARACTER_32
				do
					target := special_basic [i]
					start.make_now_utc
					from j := n until j <= 0 loop
						across target as c loop
							y := c.item
							x := x + y.code
						end
						j := j - 1
					end
					stop.make_now_utc
					answer := x
				end,
				"SPECIAL across")
--			run (agent (i: INTEGER; n: NATURAL_64; start, stop: DATE_TIME)
--				local
--					target: separate SPECIAL [CHARACTER_32]
--					j: NATURAL_64
--					x: INTEGER
--					y: CHARACTER_32
--				do
--					target := special_basic [i]
--					start.make_now_utc
--					from j := n until j <= 0 loop
--						across target as c loop
--							y := c.item
--							x := x + y.code
--						end
--						j := j - 1
--					end
--					stop.make_now_utc
--					answer := x
--				end,
--				"separate SPECIAL across")
				-- Array
			run (agent (i: INTEGER; n: NATURAL_64; start, stop: DATE_TIME)
				local
					target: ARRAY [CHARACTER_32]
					j: NATURAL_64
					x: INTEGER
					y: CHARACTER_32
				do
					target := array_basic [i]
					start.make_now_utc
					from j := n until j <= 0 loop
						across target as c loop
							y := c.item
							x := x + y.code
						end
						j := j - 1
					end
					stop.make_now_utc
					answer := x
				end,
				"ARRAY across")
--			run (agent (i: INTEGER; n: NATURAL_64; start, stop: DATE_TIME)
--				local
--					target: separate ARRAY [CHARACTER_32]
--					j: NATURAL_64
--					x: INTEGER
--					y: CHARACTER_32
--				do
--					target := array_basic [i]
--					start.make_now_utc
--					from j := n until j <= 0 loop
--						across target as c loop
--							y := c.item
--							x := x + y.code
--						end
--						j := j - 1
--					end
--					stop.make_now_utc
--					answer := x
--				end,
--				"separate ARRAY across")
				-- Arrayed list
			run (agent (i: INTEGER; n: NATURAL_64; start, stop: DATE_TIME)
				local
					target: ARRAYED_LIST [CHARACTER_32]
					j: NATURAL_64
					x: INTEGER
					y: CHARACTER_32
				do
					target := arrayed_list_basic [i]
					start.make_now_utc
					from j := n until j <= 0 loop
						across target as c loop
							y := c.item
							x := x + y.code
						end
						j := j - 1
					end
					stop.make_now_utc
					answer := x
				end,
				"ARRAYED_LIST across")
--			run (agent (i: INTEGER; n: NATURAL_64; start, stop: DATE_TIME)
--				local
--					target: separate ARRAYED_LIST [CHARACTER_32]
--					j: NATURAL_64
--					x: INTEGER
--					y: CHARACTER_32
--				do
--					target := arrayed_list_basic [i]
--					start.make_now_utc
--					from j := n until j <= 0 loop
--						across target as c loop
--							y := c.item
--							x := x + y.code
--						end
--						j := j - 1
--					end
--					stop.make_now_utc
--					answer := x
--				end,
--				"separate ARRAYED_LIST across")
				-- Across loops on ITERABLE.
			across
				indexable_basic as q
			loop
				run (agent (i: INTEGER; n: NATURAL_64; start, stop: DATE_TIME; iterable: SPECIAL [ITERABLE [CHARACTER_32]])
					local
						target: ITERABLE [CHARACTER_32]
						j: NATURAL_64
						x: INTEGER
						y: CHARACTER_32
					do
						target := iterable [i]
						start.make_now_utc
						from j := n until j <= 0 loop
							across target as c loop
								y := c.item
								x := x + y.code
							end
							j := j - 1
						end
						stop.make_now_utc
						answer := x
					end
					(?, ?, ?, ?, q.item.data),
					q.item.name + " poly across")
			end
				-- Regular loops.
				-- String
			run (agent (i: INTEGER; n: NATURAL_64; start, stop: DATE_TIME)
				local
					target: STRING_32
					j: NATURAL_64
					x: INTEGER
					k, m: INTEGER
					y: CHARACTER_32
				do
					target := string [i]
					start.make_now_utc
					from j := n until j <= 0 loop
						from
							k := 1
							m := target.count
						until
							k > m
						loop
							y := target [k]
							x := x + y.code
							k := k + 1
						end
						j := j - 1
					end
					stop.make_now_utc
					answer := x
				end,
				"STRING_32 regular")
				-- Special
			run (agent (i: INTEGER; n: NATURAL_64; start, stop: DATE_TIME)
				local
					target: SPECIAL [CHARACTER_32]
					j: NATURAL_64
					x: INTEGER
					k, m: INTEGER
					y: CHARACTER_32
				do
					target := special_basic [i]
					start.make_now_utc
					from j := n until j <= 0 loop
						from
							k := 0
							m := target.count
						until
							k >= m
						loop
							y := target [k]
							x := x + y.code
							k := k + 1
						end
						j := j - 1
					end
					stop.make_now_utc
					answer := x
				end,
				"SPECIAL regular")
				-- Array
			run (agent (i: INTEGER; n: NATURAL_64; start, stop: DATE_TIME)
				local
					target: ARRAY [CHARACTER_32]
					j: NATURAL_64
					x: INTEGER
					k, m: INTEGER
					y: CHARACTER_32
				do
					target := array_basic [i]
					start.make_now_utc
					from j := n until j <= 0 loop
						from
							k := 1
							m := target.count
						until
							k > m
						loop
							y := target [k]
							x := x + y.code
							k := k + 1
						end
						j := j - 1
					end
					stop.make_now_utc
					answer := x
				end,
				"ARRAY regular")
				-- Arrayed list
			run (agent (i: INTEGER; n: NATURAL_64; start, stop: DATE_TIME)
				local
					target: ARRAYED_LIST [CHARACTER_32]
					j: NATURAL_64
					x: INTEGER
					k, m: INTEGER
					y: CHARACTER_32
				do
					target := arrayed_list_basic [i]
					start.make_now_utc
					from j := n until j <= 0 loop
						from
							k := 1
							m := target.count
						until
							k > m
						loop
							y := target [k]
							x := x + y.code
							k := k + 1
						end
						j := j - 1
					end
					stop.make_now_utc
					answer := x
				end,
				"ARRAYED_LIST regular")
				-- Regular loops on ITERABLE.
			across
				indexable_basic as q
			loop
				run (agent (i: INTEGER; n: NATURAL_64; start, stop: DATE_TIME; indexable: SPECIAL [READABLE_INDEXABLE [CHARACTER_32]])
					local
						target: READABLE_INDEXABLE [CHARACTER_32]
						j: NATURAL_64
						x: INTEGER
						k, m: INTEGER
						y: CHARACTER_32
					do
						target := indexable [i]
						start.make_now_utc
						from j := n until j <= 0 loop
							from
								k := target.lower
								m := target.upper
							until
								k > m
							loop
								y := target [k]
								x := x + y.code
								k := k + 1
							end
							j := j - 1
						end
						stop.make_now_utc
						answer := x
					end
					(?, ?, ?, ?, q.item.data),
					q.item.name + " poly regular")
			end
				-- Report results.
			report
		end

feature {NONE} -- Access

	power: NATURAL_8
			-- Maximum number of seconds per iteration.

	max_count: NATURAL_16 = 1024
			-- Maximum size of a structure.

	answer: INTEGER
			-- A dummy variable used to make sure loops are not optimized away because they have no effect.

feature {NONE} -- Benchmark

	run (p: PROCEDURE [INTEGER, NATURAL_64, DATE_TIME, DATE_TIME]; name: STRING)
		local
			start_time: DATE_TIME
			stop_time: DATE_TIME
			n: NATURAL_64
			i: INTEGER
			j: INTEGER
		do
			create start_time.make_now_utc
			create stop_time.make_now_utc
			from
				if power = 0 then
						-- Start from a resonably large number.
					n := {NATURAL_64} 1 |<< 10
						-- Only maximum size of a structure is of interest.
					i := max_count
					j := string.upper
				else
					n := {NATURAL_64} 1 |<< power
					i := 0
					j := string.lower
				end
			until
				n = 0 or i > max_count
			loop
				full_collect
				full_coalesce
				full_collect
				p (j, n, start_time, stop_time)
				if power = 0 then
						-- Compute `power' by making one test run for about 1 second.
					if stop_time.relative_duration (start_time).seconds_count >= 1 then
							-- The time is more than 1 second.
							-- Record `power' and exit loop.
						from
							n := n * max_count // 2
						until
							n = 0
						loop
							n := n // 2
							power := power + 1
						end
					else
							-- The time is less than 1 second.
							-- Make one more iteration.
						n := n * 2
					end
				else
					record (n, i, start_time, stop_time, name)
						-- Increase size of a structure.
					if i = 0 then
						i := 1
					else
						i := i * 2
							-- Decrease iteration count.
						n := (n + 1) // 2
					end
					j := j + 1
				end
			end
		end

	record (n: NATURAL_64; i: INTEGER; start_time, stop_time: DATE_TIME; name: STRING)
		local
			entry: detachable like time.item
		do
				-- Find corresponding entry.
			across
				time as c
			loop
				if c.item.name.same_string_general (name) then
					entry := c.item
				end
			end
			if not attached entry then
				entry := [name, create {ARRAYED_LIST [TUPLE [n: NATURAL_64; i: INTEGER; duration: REAL_64]]}.make (10)]
				time.extend (entry)
			end
			entry.timing.extend (n, i, stop_time.relative_duration (start_time).fine_seconds_count)
		end

	time: ARRAYED_LIST [TUPLE [name: STRING; timing: ARRAYED_LIST [TUPLE [n: NATURAL_64; i: INTEGER; duration: REAL_64]]]]
			-- Measurements grouped by structure name.

feature {NONE} -- Output

	put_delimiter
			-- Output a delimiter.
		do
			io.put_character (';')
		end

	report
			-- Report that test `name' took time from `start_time' to `stop_time' to complete.
		local
			r: REAL_64
			i: INTEGER
			n: INTEGER
		do
				-- Compute maximum number of runs.
			across
				time as c
			loop
				if c.item.timing.count > n then
					n := c.item.timing.count
				end
			end
				-- Print header.
			io.put_string ("power=")
			io.put_natural_8 (power)
			put_delimiter
			from
				i  := 0
			until
				i >= n
			loop
				if i = 0 then
					io.put_character ('0')
				else
					io.put_double (2^(i - 1))
				end
				put_delimiter
				i := i + 1
			end
			io.put_new_line
			across
				time as c
			loop
				io.put_string (c.item.name)
				put_delimiter
				across
					c.item.timing as t
				loop
						-- Normalize result.
					if t.item.i = 0 then
						r := t.item.duration * (2 ^ power) / t.item.n
					else
						r := t.item.duration * (2 ^ power) / (t.item.i * t.item.n.to_real_64)
					end
					io.put_integer_64 ((r * 1000).truncated_to_integer_64)
					put_delimiter
				end
				io.put_new_line
			end
		end

feature {NONE} -- Data structures to iterate over

	string: SPECIAL [STRING_32]
		once
			Result := (create {GENERATOR [CHARACTER_32, like string.item]}).generate
				(agent (n: like max_count): like string.item
					do
						create Result.make_filled (' ', n)
					end,
				max_count)
		end

	special_basic: SPECIAL [SPECIAL [CHARACTER_32]]
		once
			Result := (create {GENERATOR [CHARACTER_32, like special_basic.item]}).generate
				(agent (n: like max_count): like special_basic.item
					do
						create Result.make_filled (' ', n)
					end,
				max_count)
		end

	array_basic: SPECIAL [ARRAY [CHARACTER_32]]
		once
			Result := (create {GENERATOR [CHARACTER_32, like array_basic.item]}).generate
				(agent (n: like max_count): like array_basic.item
					do
						create Result.make_filled (' ', 1, n)
					end,
				max_count)
		end

	arrayed_list_basic: SPECIAL [ARRAYED_LIST [CHARACTER_32]]
		once
			Result := (create {GENERATOR [CHARACTER_32, like arrayed_list_basic.item]}).generate
				(agent (n: like max_count): like arrayed_list_basic.item
					do
						create Result.make_filled (n)
					end,
				max_count)
		end

	indexable_basic: SPECIAL [TUPLE [data: SPECIAL [READABLE_INDEXABLE [CHARACTER_32]]; name: STRING]]
		once
			create Result.make_empty (4)
			Result.extend (string, "STRING_32")
			Result.extend (special_basic, "SPECIAL basic")
			Result.extend (array_basic, "ARRAY basic")
			Result.extend (arrayed_list_basic, "ARRAYED_LIST basic")
		end

	special_reference: SPECIAL [SPECIAL [detachable TEST]]
		once
			Result := (create {GENERATOR [detachable TEST, like special_reference.item]}).generate
				(agent (n: like max_count): like special_reference.item
					do
						create Result.make_filled (Void, n)
					end,
				max_count)
		end

	array_reference: SPECIAL [ARRAY [detachable TEST]]
		once
			Result := (create {GENERATOR [detachable TEST, like array_reference.item]}).generate
				(agent (n: like max_count): like array_reference.item
					do
						create Result.make_filled (Void, 1, n)
					end,
				max_count)
		end

	arrayed_list_reference: SPECIAL [ARRAYED_LIST [detachable TEST]]
		once
			Result := (create {GENERATOR [detachable TEST, like arrayed_list_reference.item]}).generate
				(agent (n: like max_count): like arrayed_list_reference.item
					do
						create Result.make_filled (n)
					end,
				max_count)
		end

	iterable_reference: SPECIAL [SPECIAL [ITERABLE [detachable TEST]]]
		once
			create Result.make_empty (3)
			Result.extend (special_reference)
			Result.extend (array_reference)
			Result.extend (arrayed_list_reference)
		end

end
