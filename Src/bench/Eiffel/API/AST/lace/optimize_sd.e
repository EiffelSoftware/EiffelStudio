class OPTIMIZE_SD

inherit

	OPTION_SD
		redefine
			is_optimize
		end

feature

	is_optimize: BOOLEAN is
			-- is the option an optimize one ?
		do
			Result := True;
		end

end
