class TEST

create
	make

feature

	make
		local
			start, stop: DATE_TIME
			i: INTEGER
			a: ARRAY [READABLE_STRING_32]
			n: like max_count
		do
			a := (create {ARGUMENTS_32}).argument_array
			if a.upper = 0 then
				n := max_count
			elseif a.upper = 1 and then a [1].is_integer then
				n := a [1].to_integer
			end
			if n = 0 then
				(create {EXCEPTIONS}).die (0)
			elseif n < 0 then
				exit ("Invalid argument, positive integer is expected.%N")
			end
			io.put_string ("Iterations: ")
			io.put_integer (n)
			io.put_new_line
			create start.make_now_utc
			create stop.make_now_utc

			io.put_string ("Attribute in postcondition: ")
			start.make_now_utc
			from
				i := n
			until
				i <= 0
			loop
				old_attribute_in_postcondition
				i := i - 1
			end
			stop.make_now_utc
			print (stop.relative_duration (start).fine_seconds_count.rounded)
			io.put_string (" seconds")
			io.put_new_line

			io.put_string ("Attribute in body: ")
			start.make_now_utc
			from
				i := n
			until
				i <= 0
			loop
				old_attribute_in_body
				i := i - 1
			end
			stop.make_now_utc
			print (stop.relative_duration (start).fine_seconds_count.rounded)
			io.put_string (" seconds")
			io.put_new_line
		end

feature {NONE} -- Arguments

	max_count: INTEGER = 100

	arguments: ARRAYED_LIST [STRING_32]
		once
			create Result.make (1)
			Result.extend ({STRING_32} "0")
		end

feature {NONE} -- Termination

	exit (message: STRING)
		do
			io.error.put_string (message)
			io.error.put_new_line;
			(create {EXCEPTIONS}).die (-1)
		end

feature {NONE} -- Test

	item: INTEGER
			-- A value to be checkde in old expressions.

	old_attribute_in_postcondition
			-- Increment `item` and check the effect in the postcondition.
		do
			item := item + 1
		ensure
			item = old item + 1
		end

	old_attribute_in_body
			-- Increment `item` using its old value in the body.
		do
--			item := old item + 1
		end

end
