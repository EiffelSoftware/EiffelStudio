indexing

	description: 
		"";
	date: "$Date$";
	revision: "$Revision $"

class REQUIRE_SD

inherit

	OPT_VAL_SD
		redefine
			is_require
		end

feature -- Properties

	is_require: BOOLEAN is
			-- Is the option value `require' ?
		do
			Result := True;
		end

end -- class REQUIRE_SD
