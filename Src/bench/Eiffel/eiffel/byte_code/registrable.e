-- Records common properties of Eiffel sub-expressions, which can
-- be put in temporary registers (expression spliting).

deferred class REGISTRABLE 
	
feature 

	register: REGISTRABLE is
			-- Where expression is stored.
		do
		end;
	
	set_register (r: REGISTRABLE) is
			-- Set current register to `r'
		do
		end;

	c_type: TYPE_C is
			-- Associated C type
		deferred
		end;

	register_name: STRING is
			-- The ASCII representation of the register
		deferred
		end;

	context: BYTE_CONTEXT is
			-- Context in which generation occurs
		deferred
		end;

	get_register is
			-- Ask for a new register.
		do
		end;

	free_register is
			-- Free register for use by others.
		do
		end;
	
	print_register is
			-- Generates the C representation of `register'
		do
			context.buffer.putstring (register_name)
		end;

	propagate (r: REGISTRABLE) is
			-- Propagates the target of assignment `r' to avoid
			-- an extra temporary variable.
		do
		end;

	is_result: BOOLEAN is
			-- Is register the Result entity ?
		do
		end;

	is_current: BOOLEAN is
			-- Is register the Current entity ?
		do
		end;

	is_argument: BOOLEAN is
			-- Is register an argument entity ?
		do
		end;

	is_predefined: BOOLEAN is
			-- Is Current a predefined entity ?
		do
			Result := is_local or else is_argument or else is_result or else is_current;
		end;

	is_special: BOOLEAN is
			-- Is register Result or Current ?
		do
		end;

	is_local: BOOLEAN is
			-- Is register a local entity ?
		do
		end;

	is_temporary: BOOLEAN is
			-- Is register a temporary one ?
		do
		end;

	No_register: VOID_REGISTER is
			-- Special entity for no register
		once
			!!Result;
		end;

feature -- Concurrent Eiffel

	is_separate: BOOLEAN is
		do
			
		end;

end
