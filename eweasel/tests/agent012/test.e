class
	TEST

create
	make

feature

	make
		do
			test1
			test2
		end

	test1
		local
			hs: HASH_TABLE [INTEGER, STRING]
			hi: HASH_TABLE [INTEGER, INTEGER]
		do
			create hs.make (10)
			create hi.make (10)
			do_it_s (agent hs.force (3, ?))
			print (hs.item ("foo"))
			io.put_new_line
			do_it_i (agent hi.force (3, ?))
			print (hi.item (3))
			io.put_new_line
		end

	do_it_s (a_action: PROCEDURE [ANY, TUPLE [STRING]])
		do
			a_action.call (["foo"])
		end

	do_it_i (a_action: PROCEDURE [ANY, TUPLE [INTEGER]])
		do
			a_action.call ([3])
		end

	test2
		local
			h: HASH_TABLE [ANY, HASHABLE]
			a: HASHABLE
		do
			create {HASH_TABLE [INTEGER, INTEGER]} h.make (10)
			a := 3
			(agent h.force (3, ?)).call ([a])
			print (h.item (3))
			io.put_new_line
		end
end
