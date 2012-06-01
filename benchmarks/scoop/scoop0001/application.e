note
	description : "cycletest application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit {NONE}
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	processors: INTEGER
	queries: INTEGER
	count: INTEGER

	make
		local
			a: ARRAY [separate PROCESSOR]
			i, j: INTEGER
			p: separate PROCESSOR
			t1, t2: TIME
			time: DOUBLE
			rand: RANDOM
		do
			if argument_count >= 2 then
				processors := argument (1).to_integer_32
				queries := argument (2).to_integer_32
				count := argument (3).to_integer_32
			else
				processors := 50
				queries := 100
				count := 10000
			end

			from
				create a.make_empty
				i := 1
			until
				i > processors
			loop
				create p.make
				a.force (p, i)
				i := i + 1
			end

			time := 0


			from
				i := 1
				create rand.set_seed (123)
			until
				i > queries
			loop
				j := rand.item \\ processors + 1
				rand.forth

				create t1.make_now
				call (a [j])
				create t2.make_now
				time := time + t2.relative_duration (t1).fine_second

				i := i + 1
			end

			print ("time = " + time.out + "%N")

		end

	call (p1: separate PROCESSOR)
		do
			p1.query (count)
		end

end
