indexing

	description: 
		"";
	date: "$Date$";
	revision: "$Revision $"

class INVARIANT_SD

inherit

	OPT_VAL_SD
		redefine
			is_invariant
		end

feature -- Properties

	is_invariant: BOOLEAN is
			-- is the option value `invariant' ?
		do
			Result := True;
		end

end -- class INVARIANT_SD
