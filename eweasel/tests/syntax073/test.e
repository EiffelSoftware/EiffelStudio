class TEST

create
	make

feature {NONE} -- Creation

	make
		local
			list: ARRAYED_LIST [INTEGER]
			set: ARRAYED_SET [INTEGER]
		do
			create list.make (5)
			list.extend (1)
			list.extend (2)
			list.extend (3)
			list.extend (4)
			list.extend (5)
			create set.make_from_iterable (list)

			report (∀ x: list ¦ x > 0)
			report (∀ x: list ¦ x > 1)
			report (∃ x: list ¦ x > 4)
			report (∃ x: list ¦ x > 5)
			report (∀ x: list ¦ ∃ y: list ¦ y >= x)
			report (∃ x: list ¦ ∀ y: list ¦ y >= x)
			report (∀ x: list ¦ set ∋ x )
			⟳ x: list ¦ ⟳ y: list ¦ if x < y then print (x.out + "<" + y.out + "%N") end ⟲ ⟲
		end

feature {NONE} -- Output

	report (v: BOOLEAN)
		do
			io.put_boolean (v)
			io.put_new_line
		end

end
