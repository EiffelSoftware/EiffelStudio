indexing

	description: 
		"";
	date: "$Date$";
	revision: "$Revision $"

class FILE_NAME_SD

inherit

	AST_LACE

feature {LACE_AST_FACTORY} -- Initialization

	initialize (fn: like file__name) is
			-- Create a new FILE_NAME AST node.
		require
			fn_not_void: fn /= Void
		do
			file__name := fn
		ensure
			file__name: file__name = fn
		end

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
