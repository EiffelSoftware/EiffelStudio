indexing

	description: 
		"";
	date: "$Date$";
	revision: "$Revision $"

class TWO_NAME_SD

inherit

	AST_LACE

feature {NONE} -- Initialization 

	set is
			-- Yacc initialization
		do
			old_name ?= yacc_arg (0);
			new_name ?= yacc_arg (1)
		end

feature -- Properties

	old_name: ID_SD;
			-- Old name

	new_name: ID_SD;
			-- New name

end -- class TWO_NAME_SD
