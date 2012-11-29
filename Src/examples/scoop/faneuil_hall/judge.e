note
	description	: "Class representing a judge"
	author		: "Martino Trosi & Matteo Cortonesi"
	date		: "Spring 2009"
	reviewer	: "Mohammad Seyed Alavi"
	revision	: "1.0.1"

class
	JUDGE

inherit
	SHARED_RANDOM
		redefine
			out
		end

create {FANEUIL_HALL}

	make

feature {NONE} -- Initialization

	make (a_hall: separate HALL)
			-- Initialize with hall.
		require
			a_hall_not_void: a_hall /= Void
		do
			hall := a_hall
		ensure
			hall_set: hall = a_hall
		end

feature -- Access

	out: STRING = "JUDGE"
			-- Printable representation

feature -- Basic operations

	act
			-- Process all expected immigrants.
		do
			from
				random.forth;
			until
				sworn_immigrant_count = expected_immigrant_count (hall)
			loop
				random.forth;
				(create {EXECUTION_ENVIRONMENT}).sleep ({INTEGER_64} 1_000_000 * random_integer (1_000, 2_000))
				if present_immigrant_count (hall) > 0 then
					enter (hall)
					take_place (hall)
					confirm (hall)
					random.forth;
					(create {EXECUTION_ENVIRONMENT}).sleep ({INTEGER_64} 1_000_000 * random_integer (250, 500))
					leave (hall)
				end
			end
		end

feature {NONE} -- Implementation

	hall: separate HALL
			-- Faneuil Hall

	sworn_immigrant_count: INTEGER
			-- Number of immigrants sworn in so far.

	expected_immigrant_count (a_hall: separate HALL): INTEGER
			-- Total immigrants expected for today.
		do
			Result := a_hall.expected_immigrant_count
		end

	present_immigrant_count (a_hall: separate HALL): INTEGER
			-- Number of immigrants present in hall
		do
			Result := a_hall.present_immigrant_count
		end

	enter (a_hall: separate HALL)
			-- Enter the hall.
		require
			not_present: not a_hall.judge_present
			immigrants_present: a_hall.present_immigrant_count > 0
			no_sworn_immigrants_present: not a_hall.has_sworn_immigrants
		do
			print (out + " entering%N")
			a_hall.set_judge_presence (True)
			sworn_immigrant_count := sworn_immigrant_count + a_hall.present_immigrant_count
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
