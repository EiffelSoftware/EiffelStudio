indexing

	description: 
		"";
	date: "$Date$";
	revision: "$Revision $"

class CHECK_SD

inherit

	OPT_VAL_SD
		redefine
			is_check
		end

feature -- Properties

	is_check: BOOLEAN is
			-- Is the option value `check' ?
		do
			Result := True;
		end

end -- class CHECK_SD
