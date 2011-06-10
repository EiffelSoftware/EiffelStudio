
class TEST
inherit
	MEMORY

create
	make
feature
	
	make (args: ARRAY [STRING]) is
		local
			list: LINKED_LIST [STRING]
			k, count, iters: INTEGER
		do
			collection_off
			count := args.item (1).to_integer
			iters := args.item (2).to_integer
			create list.make
			from
				k := 1
			until
				k > count
			loop
				list.extend ("weasel")
				k := k + 1
			end
			from
				k := 1	
			until
				k > iters
			loop
				print ("Calling deep_twin%N")
				list := list.deep_twin
				k := k + 1
			end
		end

end
