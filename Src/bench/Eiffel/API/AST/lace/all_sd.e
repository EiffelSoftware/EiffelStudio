class ALL_SD

inherit

	OPT_VAL_SD
		redefine
			is_all
		end

feature

	is_all: BOOLEAN is
			-- Is the option value `all' ?
		do
			Result := True;
		end;

end
