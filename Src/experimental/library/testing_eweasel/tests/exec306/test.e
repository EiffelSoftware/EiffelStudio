
class TEST

create
	make, make_from_test2

feature

	make_from_test2 (t: TEST2 [ANY])
		do
			print (t.value.out + "%N")
		end

	make
		local
			t: TEST2 [INTEGER]
			v: TEST
		do
			t.set_value (47)
			create v.make_from_test2 (t)
		end

end

