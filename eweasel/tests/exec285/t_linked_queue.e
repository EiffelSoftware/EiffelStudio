class
	T_LINKED_QUEUE [G]

inherit
	T_QUEUE [G]
		select
			item
		end

	T_LINKED_LIST [G]
		rename
			item as ll_item
		end

feature

	item: G is
			--
		do
			print ("version LINKED_QUEUE%N")
		end

end
