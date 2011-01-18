note
	description: "Class representing a passenger."
	author: "Mohammad Seyed Alavi"
	date: "24/07/2009"
	revision: "1.0.0"

class
	PASSENGER

inherit
	ACTOR

create {SENATE_BUS}

	make_with_station

feature {STATION}
	
	get_on
			-- it will be called when the passenger is getting on the bus
		do
			io.put_string (out + " is getting on the Bus!%N")
		end

feature {NONE} -- Implementation

	step
			-- Do a step.
		do
			io.put_string (out + " comes to station%N")
			enter (station)
			over := True
		end

	enter (a_station: separate STATION)
		require
			a_station /= void
		do
			a_station.pass_enter (current)
		end

	type: STRING = "Passenger"
			-- What's the type of this?

end
