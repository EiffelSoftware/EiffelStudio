class TEST

create
	make

feature {NONE} -- Creation

	make
		local
			list: ARRAYED_LIST [INTEGER]
		do
			create list.make (5)
			list.extend (1)
			list.extend (2)
			list.extend (3)
			list.extend (4)
			list.extend (5)
			print (∀ x ∈ list | x > 0); io.put_new_line -- True
			print (∀ x ∈ list | x > 1); io.put_new_line -- False
			print (∃ x ∈ list | x > 4); io.put_new_line -- True
			print (∃ x ∈ list | x > 5); io.put_new_line -- False
			-- ⟳ x ∈ list ⟦print (x); io.put_new_line⟧
		end

end
