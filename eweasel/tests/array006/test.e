class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run tests.
		local
			a: ARRAY [INTEGER]
		do
				-- Make sure there is a qualified call just before manifest array.
			Current.f
			a := <<1, 2, 3>>
		end

feature {TEST} -- Test

	f
		do
		end

end
