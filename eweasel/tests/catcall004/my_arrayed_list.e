class
	MY_ARRAYED_LIST [G]

inherit
	MY_LIST [G]

create
	make

feature
	make (n: INTEGER)
		do
			create list.make (n)
		end

	list: frozen ARRAYED_LIST [G]

	item: G
		do
			Result := list.item
		end

	extend (v: like item)
		do
			list.extend (v)
		end

	start
		do
			list.start
		end

	after: BOOLEAN
		do
			Result := list.after
		end

	forth
		do
			list.forth
		end

	append (other: MY_LIST [G])
		do
			from
				other.start
			until
				other.after
			loop
				list.extend (other.item)
				other.forth
			end
		end
end
