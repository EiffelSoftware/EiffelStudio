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
			t1.f

			check
				same_once: any_once_cell.item = t1.any_once_cell.item
			end

			create t2
			if t2.any_once_cell.item = Void then
				io.put_string ("Not OK%N")
			else
				t2.any_once_cell.put ("PATH_NAME")
			end
			t2.f

			check
				same_once1: any_once_cell.item.is_equal (t2.any_once_cell.item)
				same_once2: t1.any_once_cell.item.is_equal (t2.any_once_cell.item)
			end
		end

end
