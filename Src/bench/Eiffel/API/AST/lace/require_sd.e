class REQUIRE_SD

inherit

	OPT_VAL_SD
		redefine
			is_require
		end

feature

	is_require: BOOLEAN is
			-- Is the option value `require' ?
		do
			Result := True;
		end

end
