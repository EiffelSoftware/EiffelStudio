class
	TEST

inherit
	SHARED_ANY

create
	make

feature -- Initialization

	make is
			-- Run application.
		local
			t1: TEST1
			t2: TEST2
		do
			any_once_cell.put ("STRING")
			create t1
			create t2
			t1.f
			t2.f
		end

end
