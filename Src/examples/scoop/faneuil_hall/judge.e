indexing
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

	out: STRING is "Judge"
			-- How to print the judge?

feature {NONE} -- Implementation

	type: STRING is "Judge"
			-- What's the type?

	step is
			-- Do a process step.
		do
			random.forth;
			(create {EXECUTION_ENVIRONMENT}).sleep (1000000 * random_integer (1000, 2000))
			enter (hall)
			take_place(hall)
			confirm (hall)
			random.forth;
			(create {EXECUTION_ENVIRONMENT}).sleep (1000000 * random_integer (250, 500))
			leave (hall)
			over := true
		end

	enter (a_hall: attached separate HALL) is
			-- Enter the hall.
		require
			not a_hall.judge_present
			a_hall.immigrants > 0
			a_hall.judge_enterance_ready
		do
			io.put_string (out + " entering%N")
			a_hall.set_judge (True)
		end

	take_place(a_hall: attached separate HALL) is
			-- Sit in judgment position
		require
			a_hall.immigrants_ready
		do
			io.put_string (out + " taking place%N")
			a_hall.sit_judge
		end

	confirm (a_hall: attached separate HALL) is
			-- Confirm.
		require
			a_hall.immigrants_swear_done
		do
			io.put_string (out + " confirming%N")
			a_hall.confirm
		end

	leave (a_hall: attached separate HALL) is
			-- Leave the hall.
		do
			io.put_string (out + " leaving%N")
			a_hall.set_judge (False)
		end
end
