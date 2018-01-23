class TEST2

inherit

	TEST1
		redefine
			value
		end

feature

	value: INTEGER
		do
			Result := 47
		-- once ("OBJECT")
			-- Result := precursor
		end

end
