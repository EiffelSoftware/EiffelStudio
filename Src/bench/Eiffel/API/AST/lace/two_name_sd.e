indexing

	description: 
		"";
	date: "$Date$";
	revision: "$Revision $"

class TWO_NAME_SD

inherit

	AST_LACE

feature {LACE_AST_FACTORY} -- Initialization

	initialize (o: like old_name; n: like new_name) is
			-- Create a new TWO_NAME AST node.
		require
			o_not_void: o /= Void
			n_not_void: n /= Void
		do
			old_name := o
			new_name := n
		ensure
			old_name_set: old_name = o
			new_name_set: new_name = n
		end

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
