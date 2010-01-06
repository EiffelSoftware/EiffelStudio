
class TEST2
inherit
	TEST1
feature
	value5: INTEGER = 5

	value6: INTEGER
		do
			Result := 6
		end

	value7: INTEGER
		once
			Result := 7
		end

	value8: INTEGER
		external "C inline"
		alias "8"
		end

end
