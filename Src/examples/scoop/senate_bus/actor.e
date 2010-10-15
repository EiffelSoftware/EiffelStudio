indexing
	description : "Class representing a generic actor."
	author		: "Martino Trosi & Matteo Cortonesi"
	date		: "Spring 2009"
	reviewer	: "Mohammad Seyed Alavi"
	revision	: "1.0.2"

deferred class
	ACTOR
inherit
	SHARED_RANDOM
	redefine
		out
	end

feature {NONE} -- Creation

	make_with_station(a_id: INTEGER; a_station: separate STATION) is
			-- Creation procedure.
		do
			id := a_id
			station := a_station
			create random.set_seed (id)
		end

feature -- Access

	id: INTEGER
			-- Id of actor

	out: STRING is
			-- How to print actor?
		once
			Result := type + "-" + id.out
		end

	type: STRING is
			-- What's the type of this?
		deferred
		end

feature {SENATE_BUS} -- Basic operations

	live is
			-- Live.
		do
			from

			until
				over
			loop
				step
			end
		end

feature {NONE} -- Implementation

	over: BOOLEAN
			-- Is life over?

	step is
			-- Do a step.
		deferred
		end

	station: separate STATION
			-- Reference to attached separate station

invariant

	station_not_void: station /= Void

end
