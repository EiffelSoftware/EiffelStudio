class TEST

inherit
	MEMORY

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		local
			a: SPECIAL [INTEGER]
		do
			create a.make_filled (0, 0x10_0000) -- 1M of elements.
			create time.make (4)
				-- Compure `max_iterations'.
			run (agent (n: NATURAL_64; start, stop: DATE_TIME; target: SPECIAL [INTEGER])
				local
					j: NATURAL_64
					has_non_zero: BOOLEAN
					y: CHARACTER_32
				do
					start.make_now_utc
					from j := n until j <= 0 loop
						has_non_zero := False
						across
							target as c
						until
							has_non_zero
						loop
							has_non_zero := c.item /= 0
						end
						j := j - 1
					end
					stop.make_now_utc
					answer := has_non_zero
				end (?, ?, ?, a),
				"loop")
			run (agent (n: NATURAL_64; start, stop: DATE_TIME; target: SPECIAL [INTEGER])
				local
					j: NATURAL_64
					has_non_zero: BOOLEAN
					y: CHARACTER_32
				do
					start.make_now_utc
					from j := n until j <= 0 loop
						has_non_zero :=	not across target as c until c.item /= 0 all True end
						j := j - 1
					end
					stop.make_now_utc
					answer := has_non_zero
				end (?, ?, ?, a),
				"all")
			run (agent (n: NATURAL_64; start, stop: DATE_TIME; target: SPECIAL [INTEGER])
				local
					j: NATURAL_64
					has_non_zero: BOOLEAN
					y: CHARACTER_32
				do
					start.make_now_utc
					from j := n until j <= 0 loop
						has_non_zero :=	across target as c until c.item /= 0 some False end
						j := j - 1
					end
					stop.make_now_utc
					answer := has_non_zero
				end (?, ?, ?, a),
				"some")
				-- Report results.
			report
		end

feature {NONE} -- Access

	max_iterations: NATURAL_64
			-- Maximum number of iterations.

	answer: BOOLEAN
			-- A dummy variable used to make sure loops are not optimized away because they have no effect.

	threshold: INTEGER = 5
			-- A threshold (in percent) that should not be exceeded for measuments to be considered equal.

feature {NONE} -- Benchmark

	run (p: PROCEDURE [NATURAL_64, DATE_TIME, DATE_TIME]; name: STRING)
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
				if max_iterations = 0 then
						-- Start from a resonably large number.
					n := 1
				else
					n := max_iterations
				end
			until
				n = 0
			loop
				full_collect
				full_coalesce
				full_collect
				p (n, start_time, stop_time)
				if max_iterations = 0 and then stop_time.relative_duration (start_time).seconds_count < 1 then
						-- The time is less than 1 second.
						-- Increase number of iterations.
					n := n * 2
				else
						-- The time is more than 1 second or number of iterations is specified.
						-- Record time and exit the loop.
					record (start_time, stop_time, name)
					n := 0
				end
			end
		end

	record (start_time, stop_time: DATE_TIME; name: STRING)
		do
			time.extend (stop_time.relative_duration (start_time).fine_seconds_count, name)
		end

	time: HASH_TABLE [REAL_64, STRING]
			-- Measurements grouped by iteration name.

feature {NONE} -- Output

	report
			-- Report that test `name' took time from `start_time' to `stop_time' to complete.
		local
			baseline: REAL_64
		do
			baseline := time ["loop"]
			across
				time as c
			loop
				if (c.item - baseline).abs * 100 / baseline >= threshold then
					io.put_string ("Baseline for loop: ")
					io.put_integer_64 ((baseline * 1000).truncated_to_integer_64)
					io.put_new_line
					io.put_string ("Measurement for %"")
					io.put_string (c.key)
					io.put_string ("%": ")
					io.put_integer_64 ((c.item * 1000).truncated_to_integer_64)
					io.put_new_line
				end
			end
		end

end
