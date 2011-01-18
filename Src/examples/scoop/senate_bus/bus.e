note
	description: "Class representing a bus."
	author: "Mohammad Seyed Alavi"
	date: "24/07/2009"
	revision: "1.0.0"

class
	BUS
inherit
	ACTOR

create {SENATE_BUS}

	make_with_station

feature {NONE} -- Implementation

	step
			-- Do a step.
		do
			io.put_string (out + " is coming to station%N")
			enter (station)
			io.put_string (out + " entered the station%N")
			pick_up (station)
			leave (station)
			io.put_string (out + " left the station%N")
			(create {EXECUTION_ENVIRONMENT}).sleep (2000 * 1000000)
		end

	enter (a_station: separate STATION)
		require
			a_station /= void
			not a_station.bus_is_waiting
		do
			a_station.bus_enter
		end

	pick_up (a_station: separate STATION)
		require
			a_station /= void
		do
			a_station.pick_up
		end

	leave (a_station: separate STATION)
		require
			a_station /= void
		do
			a_station.leave
		end

	type: STRING = "Bus"
			-- What's the type of this?

end
