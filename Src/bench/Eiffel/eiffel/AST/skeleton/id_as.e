indexing
    description: "Node for id. Version for Bench."
    date: "$Date$"
    revision: "$Revision$"

class ID_AS

inherit
	ATOMIC_AS
		undefine
			copy, out, is_equal
		redefine
			is_id, is_equivalent,
			good_integer, good_character,
			make_integer, make_character,
			record_dependances
		end

	STRING
		rename
			set as string_set,
			is_integer as string_is_integer
		end

creation
	make, initialize

feature {AST_FACTORY} -- Initialization

	initialize (s: STRING) is
			-- Create a new ID AST node made up
			-- of characters contained in `s'.
		require
			s_not_void: s /= Void
			s_not_empty: not s.is_empty
		do
			make (s.count)
			append_string (s)
		end

feature -- Properties

	is_id: BOOLEAN is True
			-- Is the current atomic node an id ?

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := is_equal (other)
		end
feature -- Conveniences

	record_dependances is
		local
			constant_i: CONSTANT_I
			depend_unit: DEPEND_UNIT 
		do
			constant_i ?= context.a_class.feature_table.item (Current)
			!!depend_unit.make (context.a_class.class_id, constant_i)
			context.supplier_ids.extend (depend_unit)
		end

	good_integer: BOOLEAN is
			-- Is the atomic a good integer bound for multi-branch ?
		local
			constant_i: CONSTANT_I
		do
			constant_i ?= context.a_class.feature_table.item (Current)
			Result := constant_i /= Void
						and then constant_i.value.is_integer
		end

	good_character: BOOLEAN is
			-- Is the atomic a good character bound for multi-branch ?
		local
			constant_i: CONSTANT_I
		do
			constant_i ?= context.a_class.feature_table.item (Current)
			Result := constant_i /= Void
						and then constant_i.value.is_character
		end

	make_integer: INT_CONST_VAL_B is
			-- Integer value
		local
			constant_i: CONSTANT_I
			integer_value: INTEGER_CONSTANT
		do
			constant_i ?= context.a_class.feature_table.item (Current)
			integer_value ?= constant_i.value
			!! Result.make (context.a_class, integer_value.value, constant_i)
		end

	make_character: CHAR_CONST_VAL_B is
			-- Character value
		local
			constant_i: CONSTANT_I
			char_value: CHAR_VALUE_I
		do
			constant_i ?= context.a_class.feature_table.item (Current)
			char_value ?= constant_i.value
			!! Result.make (context.a_class, char_value.char_val, constant_i)
		end

feature {COMPILER_EXPORTER, FEAT_NAME_ID_AS} -- Conveniences

	load (s: STRING) is
		do
			wipe_out
			append (s)
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_string (Current)
		end

	string_value: STRING is
		do
			Result := clone (Current)
		end

end -- class ID_AS
