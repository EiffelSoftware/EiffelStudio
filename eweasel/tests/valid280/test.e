class TEST
		
create
	make

feature {NONE}

	make
		do
		end

	f (a_node: ARRAY [ANY])
		local
			i: INTEGER
			l_children: ARRAY [like a_node]
			l_node: ARRAY [ANY]
		do
			create l_children.make_empty
			i := l_children.upper
			l_node := l_children.item (i)
		end

end
