indexing

    description: "Node for id. Version for Bench.";
    date: "$Date$";
    revision: "$Revision$"

class ID_AS_B

inherit

	ID_AS
		redefine
			good_integer, good_character,
			record_dependances
		end;

	ATOMIC_AS_B
		undefine
			copy, out, is_equal, setup, consistent,
			pass_address, is_id, string_value, simple_format
		redefine
			good_integer, good_character,
			make_integer, make_character,
			record_dependances, format
		end;

	STRING
		rename
			set as string_set,
			is_integer as string_is_integer
		end

creation

	make

feature -- Conveniences

	record_dependances is
		local
			constant_i: CONSTANT_I;
			depend_unit: DEPEND_UNIT 
		do
			constant_i ?= context.a_class.feature_table.item (Current);
			!!depend_unit.make (context.a_class.id, constant_i.feature_id);
			context.supplier_ids.extend (depend_unit);
		end;

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

	format (ctxt: FORMAT_CONTEXT_B) is
			-- Reconstitute text.
		do
			ctxt.put_string (Current);
			ctxt.always_succeed;
		end;

end -- class ID_AS_B
