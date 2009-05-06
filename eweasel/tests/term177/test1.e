class
	TEST1 [G]

inherit
	TEST2

create
	make

feature

	make (v: G)
		local
			objects: HASH_TABLE [G, INTEGER]
			l_res: ARRAYED_LIST [G]
		do
			create objects.make (10)
			objects.force (v.twin, 3)
			objects.force (v.twin, 4)
			create l_res.make (10)
			objects.linear_representation.do_all (
				agent (g: G; r: ARRAYED_LIST [G]) do
					r.extend(internal.dup(g))
				end (?, l_res))

			copy_fields(l_res.first, v)
		end

end
