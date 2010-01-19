
expanded class TEST2
inherit
	{NONE} TEST1
		redefine
			value
		end

feature
	value: like Current
	   do
		Result := precursor
	   end

end
