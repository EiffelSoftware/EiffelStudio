-- Constant value

deferred class VALUE_I 

inherit
	BYTE_CONST
	SHARED_ARRAY_BYTE
	SHARED_IL_CODE_GENERATOR
	
feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		require
			arg_non_void: other /= Void
			same_type: same_type (other)
		deferred
		end

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

	is_propagation_equivalent (other: like Current): BOOLEAN is
			-- Is `Current' equivalent for propagation of pass2/pass3?
		do
			Result := True;
		end;

	generate (buffer: GENERATION_BUFFER) is
			-- Generate value in `buffer'.
		require
			good_argument: buffer /= Void;
		deferred
		end;

	generate_il is
			-- Generate IL code for constant value.
		deferred
		end

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a constant value.
		require
			good_argument: ba /= Void
		deferred
		end;

	vqmc: VQMC is
		deferred
		end;

	append_signature (st: STRUCTURED_TEXT) is
		do
			st.add_string (dump)
		end;

	dump: STRING is
		deferred
		end;

	string_value: STRING is
		do
			Result := dump
		end;

	trace is
		do
			io.error.putstring (dump)
		end

	set_real_value (t: TYPE_A) is
			-- Used only by BIT_VALUE_I
		do
		end

end
