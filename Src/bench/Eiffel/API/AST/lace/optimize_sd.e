class OPTIMIZE_SD

inherit

	OPTION_SD
		redefine
			is_optimize
		end

feature

	option_name: STRING is
		once
			Result := "optimize"
		end;

	is_optimize: BOOLEAN is
			-- is the option an optimize one ?
		do
			Result := True;
		end

end
