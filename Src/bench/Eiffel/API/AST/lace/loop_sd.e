indexing

	description: 
		"";
	date: "$Date$";
	revision: "$Revision $"

class LOOP_SD

inherit

	OPT_VAL_SD
		redefine
			is_loop
		end

feature -- Properties

	is_loop: BOOLEAN is
			-- is the option value `loop' ?
		do
			Result := True;
		end

end -- class LOOP_SD
