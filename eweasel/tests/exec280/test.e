class TEST

inherit
	TEST1
		redefine
			target
		end

create
	make

feature -- Access

	target: TEST2

end
