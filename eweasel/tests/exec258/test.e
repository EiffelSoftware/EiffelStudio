
class TEST
create
	make
feature

	make is
		local
			t3: TEST2 [ TEST1 [DOUBLE, STRING]]
		do
			create t3
			t3.make
		end

	t: LIST [TEST1 [DOUBLE, STRING]]

end
