class
	OPT_ALL_I 

inherit
	OPTIMIZE_I
		redefine
			is_all
		end
	
feature 

	is_all: BOOLEAN is True
			-- Is the option `all' ?

end
