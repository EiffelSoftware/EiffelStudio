note
	explicit: "all"

class A_SETS

feature

	good (s: MML_SET[INTEGER])
		local
			s1, s2: MML_SET[INTEGER]
		do
			check s1.is_empty end
			s1 := s & 1 & 2
			check s1.has (1) end
			s2 := s1 / 2
			check s2 <= s1 end
			check s1 >= s2 end
			check (s1 * s2).has(1) end
			check (s1 - s2).is_disjoint(s2 - s1) end
			check s1 <= s1 + s2 end
			s2 := {MML_SET[INTEGER]}.empty_set & 1
			check s2.any_item = 1 end
			check s2.count = 1 end
			create s1.singleton (1)
			check s1.count = 1 end
			check across s1 as i all i = 1 end end

			s1 := create {MML_SET[INTEGER]}.singleton (5)
			check s1 ~ create {MML_SET[INTEGER]}.singleton (5) end
			check not s1.is_empty end
		end

	good1 (s: MML_SET [A_SETS])
		require
			not s.is_empty
			across s as x all x /= Void  end
		do
			check attached {A_SETS} s.any_item end
		end

	bad (s: MML_SET[INTEGER]; i: INTEGER)
		local
			s1: MML_SET[INTEGER]
			x: INTEGER
		do
			s1 := s1 & 1
			if i = 1 then
				x := s.any_item
			elseif i = 2 then
				check bad_disjoint: s.is_disjoint (s1) end
			elseif i = 3 then
				check bad_empty: s.is_empty end
			elseif i = 4 then
				check bad_has: s.has (1)  end
			else
				check s1.any_item = 2 end
			end
		end

	interval
		local
			in1: MML_INTERVAL
			s1: MML_SET [INTEGER]
		do
			create in1.from_range (1, 10)
			check in1.count = 10 end
			check in1 [5] end

			s1 := in1 + create {MML_INTERVAL}.from_range (21, 30)
			check s1 [5] end
			check s1 [25] end
			check not s1 [15] end

			check in1 <= in1 & 11 end
			check in1 >= in1.removed (5) end
		end

invariant
	subjects = []

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
