note
	description: "{POOLED_THREAD} is used in combination with {THREAD_POOL} to allow for pooled threads."
	date: "$Date$"
	revision: "$Revision$"

class
	PERFORMANCE_TEST

inherit
	ARGUMENTS

create
	make,
	make_empty

feature {NONE} -- Initialization

	make
			--
		local
			pool: THREAD_POOL [PERFORMANCE_TEST]
			times, i: NATURAL
		do
			times := argument (1).to_natural_32
			print ("%Nstart%N")
			--create pool.make (argument(2).to_natural_32, agent integral_generator)
			create pool.make (argument(2).to_natural_32)
			from
				i := 0
			until
				i >= times
			loop
				integral (0, 100)
				i := i + 1
			end
			print ("middle%N")
			from
				i := 0
			until
				i >= times
			loop
				pool.add_work (agent integral (0, 10))
				i := i + 1
			end
			print ("%Nstop%N")
			pool.terminate
			print ("all finished%N")
		end

	make_empty
		do
		end

	integral_generator: PERFORMANCE_TEST
		do
			create Result.make_empty
		end

	f (x: REAL): REAL
			--
		do
			Result := x*x
		end

feature -- Agent

	integral (low, high: REAL)
		require
			meaingful_interval: low <= high
		local
			x: REAL
			res: REAL
			step: REAL
		do

			step := 0.1
			from
				x:= low
			until
				x > high
			loop
				res := res + step * f(x)
				x := x + step
			end
			print (".")
		end
end
