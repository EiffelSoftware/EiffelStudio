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

creation {ROOT_SD, ID_SD, YACC_LACE, D_PRECOMPILED_SD}

	make

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
