note
	description: "Master clock with reset."
	explicit: "all"

frozen class F_MC_MASTER_D

create
	make

feature {NONE} -- Initialization

	make
			-- Create a master clock.
		note
			status: creator
		require
			modify (Current)
		do
			wrap
		ensure
			time_reset: time = 0
			no_observers: observers.is_empty
			default_wrapped: is_wrapped
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
			default_wrapped: is_wrapped
			default_observers_wrapped: across observers as o all o.is_wrapped end
			modify_field (["time", "closed"], Current)
		do
			unwrap
			-- This update satisfies its guard and thus preserves the invariant of slave clocks:
			time := time + 1
			wrap
		ensure
			time_increased: time > old time
			default_wrapped: is_wrapped
		end

	reset
			-- Reset time to zero.
		require
			wrapped: is_wrapped
			observers_open: across observers as o all o.is_open end
			modify_field (["time", "closed"], Current)
		do
			unwrap
			-- This update does not satisfy its guard,
			-- so the method requires that the observers be open:
			time := 0
			wrap
		ensure
			wrapped: is_wrapped
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
	default_owns: owns = []
	default_subjects: subjects = []

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:
		"Copyright (c) 2013-2014 ETH Zurich",
		"Copyright (c) 2018 Politecnico di Milano",
		"Copyright (c) 2022 Schaffhausen Institute of Technology"
	author: "Julian Tschannen", "Nadia Polikarpova", "Alexander Kogtenkov"
	license: "GNU General Public License"
	license_name: "GPL"
	EIS: "name=GPL", "src=https://www.gnu.org/licenses/gpl.html", "tag=license"
	copying: "[
		This program is free software; you can redistribute it and/or modify it under the terms of
		the GNU General Public License as published by the Free Software Foundation; either version 1,
		or (at your option) any later version.

		This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
		without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
		See the GNU General Public License for more details.

		You should have received a copy of the GNU General Public License along with this program.
		If not, see <https://www.gnu.org/licenses/>.
	]"

end
