class OPT_YES_I 

inherit

	OPTIMIZE_I
		redefine
			is_yes
		end
	
feature 

	is_yes: BOOLEAN is
			-- Is the option `yes' ?
		do
			Result := True;
		end;

end
