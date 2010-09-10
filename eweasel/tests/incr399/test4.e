
class TEST4
inherit
	TEST5
		redefine
			value
		end
feature
	value: INTEGER
		-- external "C inline"
		-- alias "13"
		once ("OBJECT")
			Result := precursor
		end
end
