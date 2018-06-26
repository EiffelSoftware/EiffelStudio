class TEST

create
	make

feature {NONE} -- Initialization

	make
		local
			t: TEST2
		do
			create t.make
		end

end
