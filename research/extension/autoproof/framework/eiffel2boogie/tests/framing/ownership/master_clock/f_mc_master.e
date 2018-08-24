note
	description: "Master clock with reset."

frozen class F_MC_MASTER

create
	make

feature {NONE} -- Initialization

	make
			-- Create a master clock.
		note
			status: creator
		do
		ensure
			time_reset: time = 0
			no_observers: observers.is_empty
		end

feature -- Access

	time: INTEGER
			-- Time.
		note
			guard: time_increased
		attribute
		end

feature -- Update			

	tick
			-- Increment time.
		require
			modify_field (["time", "closed"], Current)
		do
			-- This update satisfies its guard and thus preserves the invariant of slave clocks:
			time := time + 1
		ensure
			time_increased: time > old time
		end

	reset
			-- Reset time to zero.
		require
			observers_open: across observers as o all o.item.is_open end
			modify_field (["time", "closed"], Current)
		do
			-- This update does not satisfy its guard,
			-- so the method requires that the observers be open:
			time := 0
		ensure
			time_reset: time = 0
		end

feature -- Specification

	time_increased (new_time: INTEGER; o: ANY): BOOLEAN
			-- Is `new_time' greater than `time'?
		note
			status: functional
		do
			Result := new_time >= time
		end

invariant
	time_non_negative: 0 <= time

note
	explicit: observers
end
