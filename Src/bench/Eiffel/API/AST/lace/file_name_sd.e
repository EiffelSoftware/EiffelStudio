indexing

	description: 
		"";
	date: "$Date$";
	revision: "$Revision $"

class FILE_NAME_SD

inherit

	AST_LACE

feature {NONE} -- Initialization 

	set is
			-- Yacc initialization
		do
			file__name ?= yacc_arg (0);
		end;

feature -- Properties

	file__name: ID_SD;
			-- File name

end -- class FILE_NAME_SD
