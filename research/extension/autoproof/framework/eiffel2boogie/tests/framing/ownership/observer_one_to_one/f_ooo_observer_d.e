note
	explicit: "all"

class F_OOO_OBSERVER_D

create
	make

feature

	make (s: F_OOO_SUBJECT_D)
		note
			status: creator
		require
			s.observer = Void
			s.is_wrapped -- default: public

			modify (s)
			modify (Current) -- default: creator
		do
			subject := s
			s.register (Current)
			check s.inv end
			cache := s.value

			set_subjects ([subject])
			wrap -- default: public/creator
		ensure
			subject = s
			is_wrapped -- default: public/creator
			s.is_wrapped -- default: public
		end

feature -- Access

	cache: INTEGER
			-- Cached value of subject.

	subject: F_OOO_SUBJECT_D
			-- Subject of this observer.

feature {F_OOO_SUBJECT_D} -- Element change

	notify
		require
			is_open
			inv_without ("cache_synchronized")

			modify_field ("cache", Current)
		do
			cache := subject.value
		ensure
			inv
		end

invariant
	attached subject
	subjects = [subject]
	subject.observer = Current
	cache_synchronized: cache = subject.value
	across subjects as sc all sc.observers.has (Current) end -- default
	owns = [] -- default
	observers = [] -- default

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
