indexing
	description: ""
	date: "$Date$"
	revision: "$Revision $"

class
	LOOP_SD

inherit
	OPT_VAL_SD
		redefine
			is_loop
		end

feature -- Properties

	is_loop: BOOLEAN is True
			-- Is the option value `loop' ?

end -- class LOOP_SD
