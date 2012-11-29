note
	description	: "Class representing a spectator"
	author		: "Martino Trosi & Matteo Cortonesi"
	date		: "Spring 2009"
	reviewer	: "Mohammad Seyed Alavi"
	revision	: "1.0.1"

class
	SPECTATOR

inherit
	SHARED_RANDOM
		redefine
			out
		end

create
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
			-- Observe citizenship procedure.
		do
			(create {EXECUTION_ENVIRONMENT}).sleep ({INTEGER_64} 1_000_000 * random_integer (500, 2_000))
			enter (hall)
			spectate
			leave (hall)
		end

feature -- Output

	out: STRING
			-- Printable representation
		once
			Result := "SPECTATOR-" + id.out
		end

feature {NONE} -- Implementation

	hall: separate HALL
			-- Faneuil Hall

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
			(create {EXECUTION_ENVIRONMENT}).sleep ({INTEGER_64} 1_000_000 * random_integer (500, 1_000))
			print (out + " spectating%N")
			random.forth;
			(create {EXECUTION_ENVIRONMENT}).sleep ({INTEGER_64} 1_000_000 * random_integer (500, 1_000))
		end

	leave (a_hall: separate HALL)
			-- Leave.
		do
			print (out + " leaving%N")
		end

invariant

	id_positive: id > 0

end
