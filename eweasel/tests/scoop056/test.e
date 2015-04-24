class TEST

create
	make

feature {NONE} -- Creation
	
	make
			-- Run the test.
		do
			f (Current)
		end

feature -- Test

	f (y: separate TEST)
		do
			separate x6 as x7, x7 as x8 do end -- Unknown idenfier in the second expression.
			separate x7 as x8, x6 as x7 do end -- Unknown idenfier in the first expression.
		end

end
