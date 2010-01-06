class TEST1 [G -> A create default_create end]

create
	make

feature

	make is
		do
			create {ARRAYED_LIST [G]} arrayed_list.make (10)
		end

feature -- Access

	item: G
	list: LIST [G]
	arrayed_list: LIST [G]

feature -- Settings

	set_lists (a_list1, a_list2: LIST [G]) is
		do
			create {ARRAYED_LIST [G]} list.make (1)
			list.append (a_list1)
			list.append (a_list2)
		end

	set_item (v: G) is
		do
			item := v
		end

	operate is
		local
			g: G
		do
			print ("Operating on a list of type " + list.generating_type.out + "%N")
			list.extend (create {G})
			list.extend (item)
			from
				list.start
			until
				list.after
			loop
				if list.item /= Void then
					g ?= list.item
					if g = Void then
						print ("Catcall with ")
					end
					list.item.operate
				end
				list.forth
			end
			print ("%N")
		end

end

