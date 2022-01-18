class
	VSTTE2010

feature -- VSTTE 2010: Sum & max

	sum_and_max (a: SIMPLE_ARRAY [INTEGER]): TUPLE [sum, max: INTEGER]
			-- Calculate sum and maximum of array `a'.
		note
			framing: False
		require
			a_not_void: a /= Void
			a_not_empty: a.count > 0
			a_non_negative: across a as ai all ai >= 0 end
		local
			i: INTEGER
			sum, max: INTEGER
		do
			from
				i := 0
			invariant
				0 <= i and i <= a.count
				sum <= i * max
			until
				i >= a.count
			loop
				sum := sum + a [i + 1]
				if a [i + 1] > max then
					max := a [i + 1]
				end
				i := i + 1
			variant
				a.count - i
			end

			Result := [sum, max]
		ensure
			sum_in_range: Result.sum <= a.count * Result.max
		end

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
