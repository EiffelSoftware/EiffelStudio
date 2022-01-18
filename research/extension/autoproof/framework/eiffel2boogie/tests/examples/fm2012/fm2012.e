class
	FM2012

feature -- LCP

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

feature -- Prefix sum

	prefix_sum
		note
			framing: False
		local
			orig, a: ARRAY [INTEGER]
			p: PREFIX_SUM_ITER
			space: INTEGER
		do
			orig := << 3, 1, 7, 0, 4, 1, 6, 3 >>
			a := << 3, 1, 7, 0, 4, 1, 6, 3 >>

			create p.make (a)

			check p.array ~ << 3, 1, 7, 0, 4, 1, 6, 3 >> end

			space := p.upsweep

			check p.array ~ << 3, 4, 7, 11, 4, 5, 6, 25 >> end

			p.downsweep (space, orig)

			check p.array ~ << 0, 3, 4, 11, 11, 15, 16, 22 >> end
			check orig ~ << 3, 1, 7, 0, 4, 1, 6, 3 >> end
		end

feature -- Tree Del

	search_tree_delete_min (old_root: TREE_NODE): TUPLE [new_root: TREE_NODE; min: INTEGER]
		note
			verify: False
			inline_in_caller: True
		require
			old_root_not_void: old_root /= Void
			is_binary_search_tree: True -- all nodes left < data and all nodes right > data
		local
			tt, pp, p, new_root: TREE_NODE
			min: INTEGER
		do
			p := old_root.left
			if p = Void then
				min := old_root.data
				new_root := old_root.right
			else
				from
					pp := old_root
					tt := p.left
--				invariant
--					pp /= Void
--					p /= Void
--					p.data = p.data
				until
					tt = Void
				loop
					pp := p
					p := tt
					tt := p.left
				end
				min := p.data
				tt := p.right
				pp.set_left (tt)
				new_root := old_root
			end
			Result := [new_root, min]
		ensure
			new_root_is_binary_search_tree: True -- all nodes left < data and all nodes right > data
			min_was_minimum: True -- all old nodes :: min <= nodes.data
			min_is_not_in_tree: True -- all nodes :: min < nodes.data
		end

	treedel
		note
			framing: False
		local
			node1, node2, node3: TREE_NODE
			res: TUPLE [root: TREE_NODE; min: INTEGER]
		do
			create node1.make (Void, Void, 5)
			res := search_tree_delete_min (node1)
			check res.root = Void end
			check res.min = 5 end

			create node2.make (Void, Void, 7)
			create node1.make (Void, node2, 5)
			res := search_tree_delete_min (node1)
			check res.root = node2 end
			check res.min = 5 end

			create node3.make (Void, Void, 3)
			create node2.make (Void, Void, 7)
			create node1.make (node3, node2, 5)
			res := search_tree_delete_min (node1)
			check res.root = node1 end
			check res.min = 3 end
		end


	treedel2 (a, b, c: INTEGER)
		note
			framing: False
		require
			a < b and b < c
		local
			node1, node2, node3: TREE_NODE
			res: TUPLE [root: TREE_NODE; min: INTEGER]
		do
			create node3.make (Void, Void, a)
			create node2.make (Void, Void, c)
			create node1.make (node3, node2, b)
			res := search_tree_delete_min (node1)
			check res.root = node1 end
			check res.min = a end
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
