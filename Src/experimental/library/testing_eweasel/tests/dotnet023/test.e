class TEST

create

	make

feature {NONE} -- Creation

	make is
			-- Run test.
		local
			a: A
		do
			if a /= Void then
				a.dispose
			end
		end

end
