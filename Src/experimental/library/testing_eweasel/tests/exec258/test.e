
class TEST
create
	make
feature

	make is
		local
			t2: TEST2 [ TEST1 [DOUBLE, STRING]]
			t4: TEST4 [NATURAL_16]
		do
			create t2
			t2.make

			create t4
			t4.feature_with_old ({INTEGER_16} 4)
		end

	t: LIST [TEST1 [DOUBLE, STRING]]

end
