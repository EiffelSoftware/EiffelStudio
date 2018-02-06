class TEST1

inherit
	TEST2
		redefine
			is_valid, try
		end
feature

	is_valid: INTEGER
		do
			Result := 47 + 13
		end
	
	try
		do
			precursor
		end

end
