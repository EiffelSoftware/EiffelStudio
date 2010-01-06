class TEST

create
	make

feature {NONE} -- Initialization

	make is
			-- Execute test.
		local
			a: ARRAY2 [INTEGER]
		do
			create a.make (1, 3)
			a.initialize (345)
			a.wipe_out
		end

end
