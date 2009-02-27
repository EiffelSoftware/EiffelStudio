
class TEST1

feature

	value: STRING
		require
			good: value2 /= Void
		once
			Result := ""
		end

	value2: STRING
		do
			Result := ""
		end

end
