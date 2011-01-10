
class TEST2 [G]
feature
	to_val1: TEST1 [INTEGER]
		once ("OBJECT")
			create Result
		end

	to_val2: TEST1 [BOOLEAN]
		once ("OBJECT")
			create Result
		end

	to_val3: TEST1 [CHARACTER_32]
		once ("OBJECT")
			create Result
		end

	to_val4: TEST1 [DOUBLE]
		once ("OBJECT")
			create Result
		end

	val: G

	$EXTRA_ATTRIBUTES

end
