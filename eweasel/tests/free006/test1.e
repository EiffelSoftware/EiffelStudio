class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		do
			if attached {A} Current as a then
				a.do_nothing
			end
		end

end