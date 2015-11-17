class A

create
	make

feature {NONE} -- Creation

	make (t: TEST)
			-- Call a parenthesis alias on `t'.
		do
			t (False)
		end

end