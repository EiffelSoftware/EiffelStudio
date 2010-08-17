
class TEST1 [G]
feature
	a: like {TEST2 [like {ANY}.out]}.value
		once
			create Result.make (0)
		end
		

end
