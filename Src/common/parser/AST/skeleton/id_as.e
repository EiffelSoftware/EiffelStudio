-- Node for id

class ID_AS

inherit

	ATOMIC_AS
		undefine
			copy, out, is_equal, twin
		redefine
			pass_address, is_id,
			good_integer, good_character,
			make_integer, make_character,
			format
		end;
	STRING
		rename
			set as string_set
		end

creation

	make

feature

-- SHOULD BE OBSOLETE
--	start_position: INTEGER;
			-- Start position of the string
--	end_position: INTEGER;
			-- Ending position of the string

	is_id: BOOLEAN is
			-- Is the current atomic node an id ?
		do
			Result := True;
		end;

	pass_address (n: INTEGER) is
			-- Eiffel-Yacc interface
		do
			c_get_address (n, $Current, $set);
			getid_create ($make);
			getid_area ($to_c);
		end;
	
	set is
			-- Yacc initialization
		local
			s: STRING;
		do
			s ?= yacc_arg (0);
			append (s);
		ensure then
			not_empty: not empty;
		end;

feature -- Conveniences

	good_integer: BOOLEAN is
			-- Is the atomic a good integer bound for multi-branch ?
		local
			constant_i: CONSTANT_I;
		do
			constant_i ?= context.a_class.feature_table.item (Current);
			Result :=   constant_i /= Void
						and then
						constant_i.value.is_integer
		end;

	good_character: BOOLEAN is
			-- Is the atomic a good character bound for multi-branch ?
		local
			constant_i: CONSTANT_I;
		do
			constant_i ?= context.a_class.feature_table.item (Current);
			Result :=   constant_i /= Void
						and then
						constant_i.value.is_character;
		end;

	make_integer: INT_CONST_VAL_B is
			-- Integer value
		local
			constant_i: CONSTANT_I;
			integer_value: INT_VALUE_I;
		do
			constant_i ?= context.a_class.feature_table.item (Current);
			integer_value ?= constant_i.value;
			!!Result.make (integer_value.int_val, constant_i);
		end;

	make_character: CHAR_CONST_VAL_B is
			-- Character value
		local
			constant_i: CONSTANT_I;
			char_value: CHAR_VALUE_I;
		do
			constant_i ?= context.a_class.feature_table.item (Current);
			char_value ?= constant_i.value;
			!!Result.make (char_value.char_val, constant_i);
		end;

	depend_unit: DEPEND_UNIT is
		local
			feature_i: FEATURE_I;
			class_c: CLASS_C;
		do
			class_c := context.a_class;
			feature_i := class_c.feature_table.item (Current);
			!!Result.make (class_c.id, feature_i.feature_id);
		end;

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_string (Current);
			ctxt.always_succeed;
		end;

	load (s: STRING) is
		do
			wipe_out;
			append (s);
		end;
			

feature {NONE}

	getid_create (ptr: POINTER) is
		external
			"C"
		end;

	getid_area (ptr: POINTER) is
		external
			"C"
		end;

end
