note
	explicit: "all"

class
	A_MAPS

feature

	good (m: MML_MAP [INTEGER, INTEGER])
		local
			m1, m2: MML_MAP [INTEGER, INTEGER]
			seq: MML_SEQUENCE [INTEGER]
			set: MML_SET [INTEGER]
		do
			check m.count >= 0 end

			m1 := {MML_MAP [INTEGER, INTEGER]}.empty_map
			check m1.is_empty end
			check not m1.domain [1] end
			check not m1.has (1) end
			check across m1 as i all False end end

			create m2.singleton (1, 5)
			check m2.to_bag [0] = 0 end
			check m2.domain [1] end
			check m2.has (5) end
			check m2.range [5] end
			check not m2.range [6] end
			check m2.is_constant (5) end
			check m2 [1] = 5 end
			check m2.count = 1 end

			m1 := m2.updated (2, 10).updated (3, 14)
			check m1.to_bag [0] = 0 end
			check m1.count = 3 end
			m1 := m1.updated (3, 15)
			check m1.count = 3 end

			check m1.inverse [15, 3] and not m1.inverse [14, 3] end
			check m1.count = 3 end

			set := m1.image ({MML_SET [INTEGER]}.empty_set & 3 & 2)
			check set [15] end
			check not set [5] end

			m2 := m1 | ({MML_SET [INTEGER]}.empty_set & 3 & 2)
			check m2.domain [2] end
			check not m2.domain [1] end
			check not m2.domain [10] end
			check m2 [3] = 15 end

			seq := m1.sequence_image ({MML_SEQUENCE [INTEGER]}.empty_sequence & 3 & 2)
			check seq.count = 2 end
			check seq [1] = 15 and seq [2] = 10 end

			m2 := m1.updated (4, 10)
			check m2.to_bag [10] = 2 end
			check m2.to_bag [0] = 0 end
			check m2.count = 4 end

			check m2.removed (5) = m2 end
			check m2.is_disjoint (m1 | {MML_SET [INTEGER]}.empty_set) end

			create m2.singleton (1, 6)
			m2 := m2.updated (4, 20)
			check (m1 + m2) [1] = 6 end
			check (m1 + m2) [4] = 20 end
			check (m1 + m2) [2] = 10 end
		end

	good1 (m: MML_MAP [A_SETS, A_SETS])
		require
			not m.is_empty
			across m as k all k /= Void end
			across m.range as x all x /= Void end
		local
			key: A_SETS
		do
			key := m.domain.any_item
			check attached {A_SETS} key end
			check m.range [m [key]] end
			check attached {A_SETS} m [key] end
		end

	bad (m: MML_MAP [INTEGER, INTEGER]; i: INTEGER)
		require
			m.domain [2]
		local
			x: INTEGER
			set: MML_SET [INTEGER]
			seq: MML_SEQUENCE [INTEGER]
		do
			if i = 1 then
				x := m [1] -- Bad
			elseif i = 2 then
				create set.singleton (1)
				set := m.image (set) -- Bad
			else
				create seq.singleton (2)
				seq := seq & 3
				seq := m.sequence_image (seq) -- Bad
			end
		end

invariant
	subjects = []

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:
		"Copyright (c) 2014 ETH Zurich",
		"Copyright (c) 2018 Politecnico di Milano",
		"Copyright (c) 2022 Schaffhausen Institute of Technology"
	author: "Nadia Polikarpova", "Alexander Kogtenkov"
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
