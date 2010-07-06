
class TEST1 [G]
feature
	a: like {TEST2}.value
		once
			create Result.make (0)
		end
		

end
