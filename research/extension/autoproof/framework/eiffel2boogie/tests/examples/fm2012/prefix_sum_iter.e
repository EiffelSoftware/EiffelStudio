class
	PREFIX_SUM_ITER

create
	make

feature

	make (a: ARRAY [INTEGER])
		require
			a /= Void
			a.count \\ 2 = 0
		do
			array := a
		ensure
			array = a
		end

	array: ARRAY [INTEGER]

	upsweep: INTEGER
		note
			modifies: array__all
			framing: False
			inline_in_caller: True
		require
			inv1: array /= Void
			inv2: array.count = 8
			across 1 |..| 8 as i all -100_000_000 < array[i] and array[i] < 100_000_000 end
		local
			space: INTEGER
			left, right: INTEGER
		do
			from
				space := 1
--			invariant
--				inv1: array /= Void
--				inv2: array.count \\ 2 = 0
--				i1: space >= 1
--				i2: space \\ 2 = 0
			until
				space >= array.count
			loop
				from
					left := space
--				invariant
--					inv1: array /= Void
--					inv2: array.count \\ 2 = 0
--					i2: space >= 1
--					i2: space \\ 2 = 0
--					j2: left >= space
				until
					left > array.count
				loop
					right := left + space
					array[right] := array[left] + array[right]
					left := left + space * 2
				end
				space := space * 2
			end
			Result := space
		ensure
			array.count = 8
			array[1] = old(array[1])
			array[2] = old(array[1] + array[2])
			array[3] = old(array[3])
			array[4] = old(array[1] + array[2] + array[3] + array[4])
			array[5] = old(array[5])
			array[6] = old(array[5] + array[6])
			array[7] = old(array[7])
			array[8] = old(array[1] + array[2] + array[3] + array[4] + array[5] + array[6] + array[7] + array[8])
			Result = 8
--			across array.count as i all (i.item // 2 = 1) implies array[i.item] = original[i.item] end
--			across 1 |..| array.count as i all (i.item // 2 = 1) implies array[i.item] = old(array[i.item]) end
		end

	downsweep (a_space: INTEGER; original: ARRAY [INTEGER])
		note
			modifies: array__all
			inline_in_caller: True
		require
			array /= original
			array.count = 8 and original.count = 8
			a_space = 8
			array[1] = original[1]
			array[2] = original[1] + original[2]
			array[3] = original[3]
			array[4] = original[1] + original[2] + original[3] + original[4]
			array[5] = original[5]
			array[6] = original[5] + original[6]
			array[7] = original[7]
			array[8] = original[1] + original[2] + original[3] + original[4] + original[5] + original[6] + original[7] + original[8]
		local
			space: INTEGER
			left, right, temp: INTEGER
		do
			space := a_space
			array[array.count] := 0
			from
				space := space // 2
			until
				space <= 0
			loop
				from
					right := space * 2
				until
					right > array.count
				loop
					left := right - space
					temp := array[right]
					array[right] := array[left] + array[right]
					array[left] := temp
					right := right + space * 2
				end
				space := space // 2
			end
		ensure
			original[1] = old(original[1])
			original[2] = old(original[2])
			original[3] = old(original[3])
			original[4] = old(original[4])
			original[5] = old(original[5])
			original[6] = old(original[6])
			original[7] = old(original[7])
			original[8] = old(original[8])
			array[1] = 0
			array[2] = original[1]
			array[3] = original[1] + original[2]
			array[4] = original[1] + original[2] + original[3]
			array[5] = original[1] + original[2] + original[3] + original[4]
			array[6] = original[1] + original[2] + original[3] + original[4] + original[5]
			array[7] = original[1] + original[2] + original[3] + original[4] + original[5] + original[6]
			array[8] = original[1] + original[2] + original[3] + original[4] + original[5] + original[6] + original[7]
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
