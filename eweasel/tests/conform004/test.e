class TEST

create
	make

feature {NONE} -- Initialization

	make
		local
			t1: TEST1 [attached TUPLE [INTEGER, INTEGER]]
		do
			create t1.make ([1, 2])
		end

end
