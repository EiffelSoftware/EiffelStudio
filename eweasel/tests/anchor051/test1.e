
class TEST1 [G]
feature
	value: ARRAY [like {TEST1 [like {G}.out]}.default]
	       do
			create Result.make (1, 10)
	       end

end

