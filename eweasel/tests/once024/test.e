
class TEST

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			l_o1: TEST1
			l_o2: TEST1
		do
			create l_o1.make_once
			create l_o2.make_once
			check
				same_object: l_o1 = l_o2
			end
		end
end						