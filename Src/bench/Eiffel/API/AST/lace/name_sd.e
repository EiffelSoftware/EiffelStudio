class NAME_SD

inherit

	OPT_VAL_SD
		redefine
			is_name
		end

feature

	is_name: BOOLEAN is
			-- is the option value a name option ?
		do
			Result := True;
		end

end
