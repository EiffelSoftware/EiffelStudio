class TEST

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			s1, s2: separate A
		do
			create s1.make
			create s2.make
		end

end
