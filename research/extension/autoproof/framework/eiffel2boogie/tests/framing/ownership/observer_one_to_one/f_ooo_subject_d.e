note
	explicit: "all"

class F_OOO_SUBJECT_D

inherit

	ANY
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
		note
			status: creator
		do
			wrap -- default: creator
		ensure then
			is_wrapped -- default: creator
			observer = Void -- default: default_create
		end

feature -- Access

	value: INTEGER
		-- Subject's value.

	observer: detachable F_OOO_OBSERVER_D
		-- Observer of this subject.

feature -- Element change

	update (new_val: INTEGER)
		require
			is_wrapped	-- default: public
			across observers as oc all oc.is_wrapped end -- default: public

			modify_field (["cache", "closed"], observer)
			modify_field (["value", "closed"], Current)
		do
			unwrap -- default: public
			if attached observer then
				observer.unwrap
			end
			value := new_val
			if attached observer then
				observer.notify
				observer.wrap
			end
			wrap -- default: public
		ensure
			value_set: value = new_val
			is_wrapped	-- default: public
			across observers as oc all oc.is_wrapped end -- default: public
		end

feature {F_OOO_OBSERVER_D} -- Element change

	register (o: F_OOO_OBSERVER_D)
			-- Register `o' as observer.
		note
			explicit: contracts
		require
			observer = Void
			is_wrapped
			o.is_open

			modify_field (["observer", "observers", "closed"], Current)
		do
			unwrap
			observer := o
			set_observers ([o])
			wrap
		ensure
			observer = o
			is_wrapped
		end

invariant
	observer = Void implies observers = []
	observer /= Void implies observers = [observer]
	owns = [] -- default
	subjects = [] -- default

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
