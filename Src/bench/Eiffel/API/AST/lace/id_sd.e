-- Node for id

class ID_SD

inherit

	ATOMIC_SD
		undefine
			copy, out, is_equal, twin
		redefine
			set,
			pass_address
		end;
	STRING
		rename
			adapt as string_adapt,
			set as string_set
		end

creation

	make

feature

	pass_address (n: INTEGER) is
			-- Eiffel-Yacc interface
		do
			c_get_address (n, $Current, $set);
			getid_create ($make);
			getid_area ($to_c)
		end;

	set is
			-- Append `s' and put current value in hash table.
		local	
			s: STRING;
		do
			s ?= yacc_arg (0);
			append (s);
			start_position := yacc_int_arg (0);
			end_position := yacc_int_arg (1);
		ensure then
			not_empty: not empty;
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

end
