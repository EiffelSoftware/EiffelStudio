class
	TEST1
create
	make

feature

	make
		local
			n: INTEGER
		do
			create list.make (10)
			from
				n := 1
			until
				n > 10
			loop
				list.extend ("Weasel")
				n := n + 1
			end
		end
	
	list: ARRAYED_LIST [STRING]

invariant
	valid: across list as c all c.item ~ once "Weasel"end
end
