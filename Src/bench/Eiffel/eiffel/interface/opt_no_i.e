class
	OPT_NO_I 

inherit
	OPTIMIZE_I
		redefine
			is_no
		end
	
feature 

	is_no: BOOLEAN is True
			-- Is the option `no' ?

end
