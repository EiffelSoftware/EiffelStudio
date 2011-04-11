note
	description	: "Class representing an immigrant"
	author		: "Martino Trosi & Matteo Cortonesi"
	date		: "Spring 2009"
	reviewer	: "Mohammad Seyed Alavi"
	revision	: "1.0.1"

class
	IMMIGRANT

inherit
	ACTOR

create {FANEUIL_HALL}

	make_with_hall

feature {NONE} -- Implementation

	type: STRING = "Immigrant"
			-- Actor type

	step
			-- Do a process step.
		do
			enter (hall)
			random.forth;
			(create {EXECUTION_ENVIRONMENT}).sleep (1000000 * random_integer (250, 500))
			check_in (hall)
			sit_down (hall)
			take_oath (hall)
			get_certificate (hall)
			leave (hall)
			over := True
		end

	enter (a_hall: separate HALL)
			-- Enter the hall.
		require
			judge_not_in_hall: not a_hall.judge_present
		do
			print (out + " entering%N")
			a_hall.enter_immigrant
		end

	check_in (a_hall: separate HALL)
			-- Check in.
		do
			print (out + " checking in%N")
			a_hall.check_in
		end

	sit_down (a_hall: separate HALL)
			-- Sit down.
		require
			judge_ready: a_hall.judge_ready
		do
			print (out + " taking place%N")
		end

	take_oath (a_hall: separate HALL)
			-- Take oath.
		do
			print (out + " taking oath%N")
			a_hall.take_oath
		end

	get_certificate (a_hall: separate HALL)
			-- Get certificate.
		require
			judge_not_ready: not a_hall.judge_ready
		do
			print (out + " getting certificate%N")
		end

	leave (a_hall: separate HALL)
			-- Leave the hall.
		require
			judge_not_present: not a_hall.judge_present
		do
			print (out + " leaving%N")
			a_hall.leave_immigrant
		end

end
