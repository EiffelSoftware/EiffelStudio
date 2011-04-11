note
	description	: "Class representing a judge"
	author		: "Martino Trosi & Matteo Cortonesi"
	date		: "Spring 2009"
	reviewer	: "Mohammad Seyed Alavi"
	revision	: "1.0.1"

class
	JUDGE

inherit
	ACTOR
		redefine
			out
		end

create {FANEUIL_HALL}

	make_with_hall

feature -- Access

	out: STRING = "Judge"
			-- Printable representation

feature {NONE} -- Implementation

	type: STRING = "Judge"
			-- Actor type

	step
			-- Do a process step.
		do
			random.forth;
			(create {EXECUTION_ENVIRONMENT}).sleep (1000000 * random_integer (1000, 2000))
			enter (hall)
			take_place (hall)
			confirm (hall)
			random.forth;
			(create {EXECUTION_ENVIRONMENT}).sleep (1000000 * random_integer (250, 500))
			leave (hall)
			over := true
		end

	enter (a_hall: separate HALL)
			-- Enter the hall.
		require
			not_present: not a_hall.judge_present
			immigrants_present: a_hall.immigrant_count > 0
			no_sworn_immigrants_present: not a_hall.has_sworn_immigrants
		do
			print (out + " entering%N")
			a_hall.set_judge_presence (True)
		end

	take_place (a_hall: separate HALL)
			-- Prepare to confirm.
		require
			immigrants_ready: a_hall.immigrants_ready
		do
			print (out + " taking place%N")
			a_hall.sit_judge
		end

	confirm (a_hall: separate HALL)
			-- Confirm.
		require
			a_hall.all_immigrants_sworn
		do
			print (out + " confirming%N")
			a_hall.confirm
		end

	leave (a_hall: separate HALL)
			-- Leave hall.
		do
			print (out + " leaving%N")
			a_hall.set_judge_presence (False)
		end

end
