-- Abstract node produced by yacc

deferred class AST_YACC

feature -- Yacc/Eiffel interface building primitives

	pass_address (n: INTEGER) is
			-- Eiffel-Yacc initialization
		do
			c_get_address (n, $Current, $set)
		end;

	set is
			-- Yacc initialization of the current object
		deferred
		end;

feature {NONE} -- Externals

	c_get_address (dtype: INTEGER; obj: POINTER; pointer: POINTER) is
			-- Send function pointer `pointer' relative to the feature
			-- of the class to which `obj' belongs to.
		external
			"C"
		end;

	yacc_arg (i: INTEGER): AST_YACC is
			-- I_th argument processed by yacc.
		external
			"C"
		end;

	yacc_bool_arg (i: INTEGER): BOOLEAN is
			-- I_th boolean processed by yacc.
		external
			"C"
		end;

	yacc_char_arg (i: INTEGER): CHARACTER is
			-- I-th character processed by yacc.
		external
			"C"
		end;
	
	yacc_int_arg (i: INTEGER): INTEGER is
			-- I-th integer processed by yacc.
		external
			"C"
		end;

	yacc_real_arg (i: INTEGER): REAL is
			-- I-th real processed by yacc.
		external
			"C"
		end;

    yacc_position: INTEGER is
			-- Recorded position of Current AST
        external
            "C [macro %"yacc.h%"]: EIF_INTEGER"
        end

end -- class AST_YACC
