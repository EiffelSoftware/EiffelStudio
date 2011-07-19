class TEST1
feature 
	try_test1 (a: separate TEST2 b: separate TEST)
		do
			b.try_test (b.y)
		end
end

