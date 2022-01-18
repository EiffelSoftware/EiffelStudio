class A_ACROSS

feature

	set_across
		local
			l_set1: MML_SET [INTEGER]
			l_set2: MML_SET [BOOLEAN]
		do
			l_set1 := << 1, 2, 3, 4 >>
			check across l_set1 as i all 0 < i and i < 5 end end
			check across l_set1 as i all
					across l_set1 as j all 2 <= i + j and i + j <= 8  end
			end end

			l_set2 := << True, True >>
			check across l_set2 as i all i end end
		end

	sequence_across
		local
			l_seq1: MML_SEQUENCE [INTEGER]
			l_seq2: MML_SEQUENCE [BOOLEAN]
		do
			l_seq1 := << 1, 2, 3, 4 >>
			check across l_seq1 as i all 0 < i and i < 5 end end
			check across l_seq1 as i all
					across l_seq1 as j all 2 <= i + j and i + j <= 8  end
			end end
			l_seq2 := << True, True >>
			check across l_seq2 as i all i end end
		end

	map_across
		local
			l_map: MML_MAP [INTEGER, INTEGER]
		do
			create l_map
			l_map := l_map.updated (1, -1)
			l_map := l_map.updated (2, -2)
			l_map := l_map.updated (3, -3)
			l_map := l_map.updated (4, -4)
			check across l_map as i all 0 < i and i < 5 end end
		end

	interval_across
		do
			check across 1 |..| 4 as i all 0 < i and i < 5 end end
			check across 1 |..| 4 as i all
				across 5 |..| 6 as j all 6 <= i + j and i + j <= 10 end
			end end
		end

	simple_array_across
		local
			l_array1: SIMPLE_ARRAY [INTEGER]
			l_array2: SIMPLE_ARRAY [BOOLEAN]
		do
			create l_array1.init (<< 1, 2, 3, 4 >>)
			check across l_array1 as i all 0 < i and i < 5 end end
			check across l_array1 as i all
					across l_array1 as j all 2 <= i + j and i + j <= 8  end
			end end
			create l_array2.init (<< True, True >>)
			check across l_array2 as i all i end end
		end

	simple_list_across
		local
			l_list1: SIMPLE_LIST [INTEGER]
			l_list2: SIMPLE_LIST [BOOLEAN]
		do
			create l_list1.make
			l_list1.extend_back (1)
			l_list1.extend_back (2)
			l_list1.extend_back (3)
			l_list1.extend_back (4)
			check across l_list1 as i all 0 < i and i < 5 end end
			check across l_list1 as i all
					across l_list1 as j all 2 <= i + j and i + j <= 8  end
			end end
			create l_list2.make
			l_list2.extend_back (True)
			l_list2.extend_back (True)
			check across l_list2 as i all i end end
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:
		"Copyright (c) 2014 ETH Zurich",
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
