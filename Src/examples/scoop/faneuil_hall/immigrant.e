note
	description	: "Class representing an immigrant"
	author		: "Martino Trosi & Matteo Cortonesi"
	date		: "Spring 2009"
	reviewer	: "Mohammad Seyed Alavi"
	revision	: "1.0.1"

class
	IMMIGRANT

inherit
	SHARED_RANDOM
		redefine
			out
		end

create {FANEUIL_HALL}

	make

feature {NONE} -- Initialization

	make (a_id: INTEGER; a_hall: separate HALL)
			-- Initialize with identity and hall.
		require
			a_id_positive: a_id > 0
			a_hall_not_void: a_hall /= Void
		do
			id := a_id
			hall := a_hall
		ensure
			id_set: id = a_id
			hall_set: hall = a_hall
		end

feature -- Access

	id: INTEGER
			-- Id of the actor

feature -- Basic operations

	act
			-- Become a citizen.
		do
			(create {EXECUTION_ENVIRONMENT}).sleep ({INTEGER_64} 1_000_000 * random_integer (500, 2_000))
			enter (hall)
			random.forth;
			(create {EXECUTION_ENVIRONMENT}).sleep ({INTEGER_64} 1_000_000 * random_integer (250, 500))
			check_in (hall)
			sit_down (hall)
			take_oath (hall)
			get_certificate (hall)
			leave (hall)
		end

feature -- Output

	out: STRING
			-- Printable representation
		once
			Result := "IMMIGRANT-" + id.out
		end

feature {NONE} -- Implementation

	hall: separate HALL
			-- Faneuil Hall

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


invariant

	id_positive: id > 0

end
