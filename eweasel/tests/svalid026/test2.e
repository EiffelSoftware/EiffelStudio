
class TEST2
inherit
	TEST1
		redefine
			value
		end

feature
	value: like Current
		do
			Result := precursor
		end

        a: DOUBLE

end
