indexing
	description: "Class representing a bus stop."
	author: "Mohammad Seyed Alavi"
	date: "24/07/2009"
	revision: "1.0.0"

class
	STATION

create
	make

feature {SENATE_BUS}
	make is
			-- station constructor
		do
			bus_is_waiting := false
			create waiting_list.make
			create checked_in_list.make
		end

feature {BUS} -- Basic Operations

	bus_enter is
			-- bus enters the bus stop
		require
			bus_is_waiting = false

		do
			bus_is_waiting := true

		ensure
			bus_is_waiting = true

		end

	pick_up is
			-- bus picks up the waiting passengers
		require
			bus_is_waiting = true

		local
			i: INTEGER
			passenger: separate PASSENGER

		do
			from
				i := 0
			until
				i >= 50 or
				checked_in_list.is_empty
			loop
				passenger := checked_in_list.item.passenger
				get_on_passenger(passenger)
				checked_in_list.remove
			end
		end

	leave is
			-- bus leaves the bus stop
		require
			bus_is_waiting = true
		local
			passenger: SEP_PASSENGER
		do
			from

			until
				waiting_list.is_empty
			loop
				passenger := waiting_list.item
				--io.put_string (waiting_list.item.out)
				checked_in_list.put (passenger)
				waiting_list.remove
			end

			bus_is_waiting := false

		ensure
			bus_is_waiting = false

		end

feature {PASSENGER} -- Basic Operations

	pass_enter (a_passenger: separate PASSENGER)is
			-- passenger enters the station
		do
			-- add passenger to the waiting list
			waiting_list.put (
                          create {SEP_PASSENGER}.set_passenger(a_passenger))
		end


feature {BUS} -- Implementation

	bus_is_waiting: BOOLEAN

	waiting_list: LINKED_QUEUE [SEP_PASSENGER]
		-- each passenger will be added to this list when arrive

	checked_in_list: LINKED_QUEUE [SEP_PASSENGER]
		-- if the bus doesn't exist in the station, add the passengers from waiting list to this list

feature {NONE}

	get_on_passenger(a_passenger: separate PASSENGER) is
			-- tell the passenger that it's his turn to get on
		do
			a_passenger.get_on
		end

invariant
	invariant_clause: True -- Your invariant here

end
