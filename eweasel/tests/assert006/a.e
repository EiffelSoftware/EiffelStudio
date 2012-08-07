class A
create
	make
feature
	make
		do
			create list.make (10)
			list.extend (3)
			list.finish
			list.forth
		end

	f
		do
				-- In theory we should have a precondition violation here.
			list.forth
	 	end

	list: ARRAYED_LIST [INTEGER]


invariant
	has_occurrences: list.occurrences (1) = 0
	

end
