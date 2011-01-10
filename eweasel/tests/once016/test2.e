
class TEST2
feature
	to_val1: TEST2
		once ("OBJECT")
			create Result
			Result := to_val1
		end

	val: INTEGER

end
