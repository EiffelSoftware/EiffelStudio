note
	description	: "Class representing a spectator"
	author		: "Martino Trosi & Matteo Cortonesi"
	date		: "Spring 2009"
	reviewer	: "Mohammad Seyed Alavi"
	revision	: "1.0.1"

class
	SPECTATOR

inherit
	ACTOR

create
	make_with_hall

feature {NONE} -- Implementation

	type: STRING = "Spectator"
			-- Actor type

	step
			-- Do a process step.
		do
			enter (hall)
			spectate
			leave (hall)
			over := True
		end

	enter (a_hall: separate HALL)
			-- Enter the hall.
		require
			not a_hall.judge_present
		do
			print (out + " entering%N")
		end

	spectate
			-- Spectate.
		do
			random.forth;
			(create {EXECUTION_ENVIRONMENT}).sleep (1000000 * random_integer (500, 1000))
			print (out + " spectating%N")
			random.forth;
			(create {EXECUTION_ENVIRONMENT}).sleep (1000000 * random_integer (500, 1000))
		end

	leave (a_hall: separate HALL)
			-- Leave.
		do
			print (out + " leaving%N")
		end

end
