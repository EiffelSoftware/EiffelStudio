class OPT_ALL_I 

inherit

	OPTIMIZE_I
		redefine
			is_all
		end
	
feature 

	is_all: BOOLEAN is
			-- Is the option `all' ?
		do
			Result := True;
		end;

end
