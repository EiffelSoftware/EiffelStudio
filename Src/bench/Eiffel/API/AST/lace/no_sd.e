indexing

	description: 
		"";
	date: "$Date$";
	revision: "$Revision $"

class NO_SD

inherit

	YES_OR_NO_SD
		redefine
			is_no
		end

feature -- Properties

	is_no: BOOLEAN is
			-- is the option value `no' ?
		do
			Result := True;
		end

end -- class NO_SD
