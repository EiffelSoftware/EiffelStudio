note
	explicit: "all"

class
	A_RELATIONS

feature
	good (r: MML_RELATION [INTEGER, INTEGER])
		local
			r1, r2: MML_RELATION [INTEGER, INTEGER]
			s: MML_SET [INTEGER]
		do
			check r.count >= 0 end
			check r.count = r.inverse.count end
			check not r.is_empty implies r.count > 0 end
			check r | r.domain = r end

			r1 := {MML_RELATION [INTEGER, INTEGER]}.empty_relation
			check r1.is_empty end
			check not r1 [1, 1] end
			check r1.count = 0 end
			check r1.inverse.is_empty end
			check (r1 * r).is_empty end

			create r2.singleton (1, 1)
			check r2 [1, 1] and not r2 [2, 1] end
			check r2.count = 1 end

			r1 := r1.extended (1, 2).extended (2, 2).extended (1, 1)
			check r1.image_of (1)[1] and r1.image_of (1)[2] and not r1.image_of (1)[0] end
			s := {MML_SET [INTEGER]}.empty_set & 1 & 2 & 3
			check r1.image (s) = r1.range end

			check r1.domain [1] and r1.domain [2] and not r1.domain [0] end
			check r1.range [1] and r1.range [2] and not r1.range [0] end
			check r1.count = 3 end
			check r1 + r2 = r1 end
			check r1 * r2 = r2 end
			check r1.inverse [2, 1] end

			r1 := r1 - r2
			check r1 [1, 2] and r1 [2, 2] and not r1 [1, 1] end
		end

	good1 (r: MML_RELATION [A_RELATIONS, A_RELATIONS])
		require
			not r.is_empty
			across r as x all x.left /= Void and x.right /= Void end
		local
			u: A_RELATIONS
		do
			u := r.domain.any_item
			check attached {A_RELATIONS} u end
			check across r.image_of (u) as v all attached {A_RELATIONS} v end end
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
