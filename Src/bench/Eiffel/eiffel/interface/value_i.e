-- Constant value

deferred class VALUE_I 

inherit

	BYTE_CONST;
	SHARED_ARRAY_BYTE
	
feature 

	valid_type (t: TYPE_A): BOOLEAN is
			-- Is the current value compatible with `t' ?
		require
			good_argument: t /= Void
		deferred
		end;

	is_integer: BOOLEAN is
			-- Is the constant an integer constant ?
		do
			-- Do nothing
		end;

	is_boolean: BOOLEAN is
			-- Is the constant a real constant ?
		do
			-- Do nothing
		end;

	is_character: BOOLEAN is
			-- is the constant a character constant ?
		do
			-- Do nothing
		end;

	is_real: BOOLEAN is
			-- is the constant a real constant ?
		do
			-- Do nothing
		end;

	is_double: BOOLEAN is
			-- Is the constant a double constant ?
		do
			-- Do nothing
		end;

	is_string: BOOLEAN is
			-- Is the constant a string constant ?
		do
			-- Do nothing
		end;

	is_bit: BOOLEAN is
			-- Is the constant a bit constant ?
		do
			-- Do nothing
		end;

	generate (file: INDENT_FILE) is
			-- Generate value in `file'.
		require
			good_argument: file /= Void;
			is_open: file.is_open_write or file.is_open_append;
		deferred
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a constant value.
		require
			good_argument: ba /= Void
		deferred
		end;

end
