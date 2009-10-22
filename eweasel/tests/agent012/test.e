class
	TEST

create
	make
 
feature
 
	make
		local
			h: HASH_TABLE [INTEGER, STRING]
		do
			create h.make (10)
			do_it (agent h.force (3, ?))
			print (h.item ("foo"))
		end
 
	do_it (a_action: PROCEDURE [ANY, TUPLE [STRING]])
		do
			a_action.call (["foo"])
		end
 
end
