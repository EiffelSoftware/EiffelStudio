class
	OPT_YES_I 

inherit
	OPTIMIZE_I
		redefine
			is_yes
		end
	
feature 

	is_yes: BOOLEAN is True
			-- Is the option `yes' ?

end
