class
	A
	
create
	make

feature

	make is
		do
			create list.make (0)
			list.extend ("")
		end

	f is
		do
		end
		
	list: ARRAYED_LIST [STRING]

invariant
	invari: not list.is_empty

end
