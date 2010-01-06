
deferred class TEST1
feature
	value0: INTEGER

	value1: INTEGER = 1
	
	value2: INTEGER
		do
			Result := 2
		end

	value3: INTEGER
		once
			Result := 3
		end

	value4: INTEGER
		external "C inline"
		alias "4"
		end

	value5: INTEGER
		deferred
		end

	value6: INTEGER
		deferred
		end

	value7: INTEGER
		deferred
		end

	value8: INTEGER
		deferred
		end

end
