class TEST2
feature 
	try_test2 (a: separate TEST1 b: separate TEST)
		do
			a.try_test1 (b.y, b)
		end

	is_valid: BOOLEAN 
		$(ONCE_BODY)

end

