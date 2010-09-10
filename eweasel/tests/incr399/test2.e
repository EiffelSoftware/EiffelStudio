
class TEST2
inherit
	TEST1
		redefine
			value
		end
feature
	value: INTEGER
		external "C inline"
		alias "47"
		-- once ("OBJECT")
			-- Result := precursor
		end

end
