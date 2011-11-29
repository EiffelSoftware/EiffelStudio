
class TEST3
inherit
	ANY
inherit {NONE}
	TEST2
		redefine
			is_valid, try
		end
	
feature

	is_valid: INTEGER = 13
	
	try
		do
			precursor
		end

end

