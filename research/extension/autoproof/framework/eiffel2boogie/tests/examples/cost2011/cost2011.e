class
	COST2011

feature -- COST 2011: Maximum in an array

	max_in_array (a: SIMPLE_ARRAY [INTEGER]): INTEGER
			-- Index of maximum element of `a'.
		require
			a_not_empty: a.count > 0
		local
			x, y: INTEGER
		do
			from
				x := 1
				y := a.count
			invariant
				1 <= x and y <= a.count
				y >= x
				across 1 |..| x as i all a.sequence[i] <= a.sequence[x] or a.sequence[i] <= a.sequence[y] end
				across y |..| a.count as i all a.sequence[i] <= a[x] or a.sequence[i] <= a.sequence[y] end
			until
				x = y
			loop
				if a[x] <= a[y] then
					x := x + 1
				else
					y := y - 1
				end
			variant
				y - x
			end
			Result := x
		ensure
			result_in_range: 1 <= Result and Result <= a.count
			result_is_max1: across 1 |..| a.count as i all a[i] <= a[Result] end
			result_is_max2: across a as i all i <= a[Result] end
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:
		"Copyright (c) 2013-2014 ETH Zurich",
		"Copyright (c) 2018 Politecnico di Milano",
		"Copyright (c) 2022 Schaffhausen Institute of Technology"
	author: "Julian Tschannen", "Alexander Kogtenkov"
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
