indexing

	description: 
		"Node for id.";
	date: "$Date$";
	revision: "$Revision $"

class ID_SD

inherit

	AST_LACE
		undefine
			copy, out, is_equal, setup, consistent
		redefine
			set,
			pass_address
		end;
	STRING
		rename
			adapt as string_adapt,
			set as string_set
		end

creation {AST_LACE, YACC_LACE}

	make

creation {LACE_AST_FACTORY}

	initialize

feature {LACE_AST_FACTORY} -- Initialization

	initialize (s: STRING) is
			-- Create a new ID AST node made up
			-- of characters contained in `s'.
		require
			s_not_void: s /= Void
			s_not_empty: not s.empty
		do
			make (s.count)
			append_string (s)
		end

feature {NONE} -- Initialization 

	set is
			-- Append `s' and put current value in hash table.
		local	
			s: STRING;
		do
			s ?= yacc_arg (0);
			append (s);
		ensure then
			not_empty: not empty;
		end;

feature {YACC_LACE}

	pass_address (n: INTEGER) is
			-- Eiffel-Yacc interface
		do
			c_get_address (n, $Current, $set);
			getid_create ($make);
			getid_area ($to_c)
		end;

feature {NONE} -- Externals

	getid_create (ptr: POINTER) is
		external
			"C"
		end;

	getid_area (ptr: POINTER) is
		external
			"C"
		end;

end -- class ID_SD
