class ENSURE_SD

inherit

	OPT_VAL_SD
		redefine
			is_ensure
		end

feature

	is_ensure: BOOLEAN is
			-- Is the option value `ensure' ?
		do
			Result := true;
		end

end
