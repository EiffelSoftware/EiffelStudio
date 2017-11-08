note
	description: "[
		Physical sensor device measuring the temperature, humidity, and pressure in a closed system (container).
		Publisher			
		]"
	author: "Volkan Arslan"
	date: "$Date$"
	revision: "$Revision$"
	institute: "Chair of Software Engineering, ETH Zurich, Switzerland"

class
	SENSOR

create
	make

feature {NONE} -- Initialization

	make
			-- Create all necessary event objects.
		do
			create temperature_event
			create humidity_event
			create pressure_event
		end

feature -- Access

	temperature: INTEGER
			-- Container temperature

	humidity: INTEGER
			-- Container humidity	

	pressure: INTEGER
			-- Container pressure		

feature -- Element change

	set_temperature (a_temperature: INTEGER)
			-- Set `a_temperature' to `temperature'.
			-- Publish the value change of `temperature'.
		require
			valid_temperature: a_temperature > -100 and a_temperature < 1000
		do
			temperature := a_temperature
			temperature_event.publish ([temperature])
		ensure
			temperature_set: temperature = a_temperature
		end

	set_humidity (a_humidity: INTEGER)
			-- Set `a_humidity' to `humidity'.	
			-- Publish the value change of `humidity'.
		require
			positive_humidity: a_humidity >= 0
		do
			humidity := a_humidity
			humidity_event.publish ([humidity])
		ensure
			humidity_set: humidity = a_humidity
		end

	set_pressure (a_pressure: INTEGER) 
			-- Set `a_pressure' to `pressure'.
			-- Publish the value change of `pressure'.			
		require
			positive_pressure: a_pressure >= 0
		do
			pressure := a_pressure
			pressure_event.publish ([pressure])
		ensure
			pressure_set: pressure = a_pressure
		end

feature -- Events

	temperature_event: EVENT_TYPE [TUPLE [INTEGER]]
			-- Event associated with `temperature'.

	humidity_event: EVENT_TYPE [TUPLE [INTEGER]]
			-- Event associated with `humidity'.

	pressure_event: EVENT_TYPE [TUPLE [INTEGER]]
			-- Event associated with `pressure'.

invariant

	temperature_event_not_void: temperature_event /= Void
	humidity_event_not_void: humidity_event /= Void
	pressure_event_not_void: pressure_event /= Void

end -- class SENSOR
