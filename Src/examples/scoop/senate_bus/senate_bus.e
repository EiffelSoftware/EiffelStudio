indexing
	description	: "System's root class"
	author		: "Mohammad Seyed Alavi"
	date		: "23/07/2009"
	revision	: "1.0.0"

class
	SENATE_BUS
inherit
	SHARED_RANDOM

create
	make

feature -- Initialization

	make is
		-- Creation procedure.
	local
		i: INTEGER
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

	launch_actor(a_actor: attached separate ACTOR) is
		-- Launch an actor.
	do
		a_actor.live
	end

	t_passenger: attached separate PASSENGER

	passengers: INTEGER is 30

	bus: attached separate BUS

	station: attached separate STATION

end -- class SENATE_BUS	
