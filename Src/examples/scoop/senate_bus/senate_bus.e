note
	description	: "System's root class"
	author		: "Mohammad Seyed Alavi"
	date		: "23/07/2009"
	revision	: "1.0.0"

class
	SENATE_BUS

create
	make

feature -- Initialization

	make
			-- Creation procedure.
		local
			i: INTEGER
			t_passenger: separate PASSENGER
		do
			create station.make
			create bus.make_with_station(0, station)
			launch_actor (bus)

			from
				i := 1
			until
				i > passengers
			loop
				create t_passenger.make_with_station(i, station)
				launch_actor (t_passenger)
				i := i + 1
				(create {EXECUTION_ENVIRONMENT}).sleep (500 * 1000000)
			end
		end

feature {NONE} -- Implementation

	launch_actor(a_actor: separate ACTOR)
			-- Launch an actor.
		do
			a_actor.live
		end

	passengers: INTEGER = 30

	bus: separate BUS

	station: separate STATION

end -- class SENATE_BUS	
