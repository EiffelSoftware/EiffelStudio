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
			-- What's the type?

	step
			-- Do a process step.
		do
			enter (hall)
			random.forth;
			(create {EXECUTION_ENVIRONMENT}).sleep (1000000 * random_integer (250, 500))
			check_in (hall)
			sit_down (hall)
			swear(hall)
			get_certificate (hall)
			leave (hall)
			over := True
		end

	enter (a_hall: separate HALL)
			-- Enter the hall.
		require
			not a_hall.judge_present
		do
			io.put_string (out + " entering%N")
			a_hall.enter_immigrant
		end

	check_in (a_hall: separate HALL)
			-- Check in.
		do
			io.put_string (out + " checking in%N")
			a_hall.check_in
		end

	sit_down (a_hall: separate HALL)
			-- Sit down.
		require
			a_hall.judge_ready
		do
			io.put_string (out + " taking place%N")
		end

	swear (a_hall: separate HALL)
			-- Swear.
		do
			io.put_string (out + " swearing%N")
			a_hall.swear
		end

	get_certificate (a_hall: separate HALL)
			-- Get the certificate.
		require
			not a_hall.judge_ready
		do
			io.put_string (out + " getting certificate%N")
		end

	leave (a_hall: separate HALL)
			-- Leave the hall.
		require
			not a_hall.judge_present
		do
			io.put_string (out + " leaving%N")
			a_hall.leave_immigrant
		end

end
