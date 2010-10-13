indexing
	description	: "Generic class for actors"
	author		: "Martino Trosi & Matteo Cortonesi"
	date		: "Spring 2009"
	reviewer	: "Mohammad Seyed Alavi"
	revision	: "1.0.1"

deferred class
	ACTOR

inherit
	SHARED_RANDOM
	redefine
		out
	end

feature {FANEUIL_HALL} -- Creation procedure

	make_with_hall (a_id: INTEGER; a_hall: attached separate HALL) is
			-- Creation procedure.
		require
			a_id_positive: a_id > 0
			a_hall_not_void: a_hall /= Void
		do
			id := a_id
			hall := a_hall
			create random.set_seed (a_id)
		ensure
			id_set: id = a_id
			hall_set: hall = a_hall
		end

feature -- Access

	id: INTEGER
			-- Id of the actor

	out: STRING is
			-- How to print actor?
		once
			Result := type + "-" + id.out
		end

feature {FANEUIL_HALL} -- Basic operations

	live is
			-- Live.
		do
			from

			invariant
				-- This loop is intended to loop forever, invariant and variant are not useful.
			until
				over
			loop
				step
			end
		end

feature {NONE} -- Implementation

	hall: attached separate HALL
			-- Reference to the attached separate hall

	type: STRING is
			-- What's the type of this object?
		deferred
		end

	over: BOOLEAN
			-- Is life over?

	step is
			-- Do a process step.
		deferred
		end

invariant

	id_positive: id > 0

	hall_not_void: hall /= Void

end
