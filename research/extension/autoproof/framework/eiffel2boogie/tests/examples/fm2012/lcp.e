class LCP

feature

	lcp (a: ARRAY [INTEGER]; x, y: INTEGER): INTEGER
		note
			pure: True
		require
			a_not_empty: a.count >= 1
			x_in_range: 1 <= x and x <= a.count
			y_in_range: 1 <= y and y <= a.count
		do
			from
				Result := 0
			invariant
				Result >= 0
				x + Result <= a.count + 1
				y + Result <= a.count + 1
				across 0 |..| (Result-1) as i all a[x+i] = a[y+i] end
				(a[x] /= a[y]) implies (Result = 0)
			until
				x + Result = a.count + 1 or else
				y + Result = a.count + 1 or else
				a[x + Result] /= a[y + Result]
			loop
				Result := Result + 1
			variant
				a.count - Result + 1
			end
		ensure
			in_range0: Result >= 0
			in_range1: x + Result <= a.count + 1
			in_range2: y + Result <= a.count + 1
			is_prefix: across 0 |..| (Result-1) as i all a[x+i] = a[y+i] end
			longest_prefix: (x + Result = a.count + 1) or else (y + Result = a.count + 1) or else (a[x+Result] /= a[y+Result])

			trigger: (Result = 0) = (a[x] /= a[y]) -- necessary for proofs where result = 0
		end

	lcp_basic
		note
			framing: False
		local
			a: ARRAY [INTEGER]
			x: INTEGER
		do
			a := << 1 >>

			x := lcp (a, 1, 1)
			check x = 1 end

			a := << 1, 1 >>

			x := lcp (a, 1, 2)
			check x = 1 end
			x := lcp (a, 1, 1)
			check x = 2 end

			a := << 1, 2 >>

			x := lcp (a, 1, 2)
			check x = 0 end
			x := lcp (a, 1, 1)
			check x = 2 end

			a := << 1, 2, 2, 5 >>

			x := lcp (a, 1, 2)
			check x = 0 end

			a := << 1, 2, 3, 4, 1, 2, 3 >>

			x := lcp (a, 1, 3)
			check x = 0 end
			x := lcp (a, 1, 5)
			check x = 3 end
			x := lcp (a, 2, 6)
			check x = 2 end
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:
		"Copyright (c) 2013 ETH Zurich",
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
