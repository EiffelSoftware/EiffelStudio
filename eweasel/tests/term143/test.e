class TEST

create
	make

feature {NONE} -- Initialization

	make is
		local
			t: TEST2
		do
			create t.make
		end

end
