class OPT_NO_I 

inherit

	OPTIMIZE_I
		redefine
			is_no
		end
	
feature 

	is_no: BOOLEAN is
			-- Is the option `no' ?
		do
			Result := True;
		end;

end
