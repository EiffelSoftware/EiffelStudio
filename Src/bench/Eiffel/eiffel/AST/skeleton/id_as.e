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
			good_integer, good_character, is_inspect_value,
			make_integer, make_character,
			record_dependances
		end

	STRING
		rename
			set as string_set,
			is_integer as string_is_integer
		end

create
	make, initialize

feature {AST_FACTORY} -- Initialization

	initialize (s: STRING) is
			-- Create a new ID AST node made up
			-- of characters contained in `s'.
		require
			s_not_void: s /= Void
			s_not_empty: not s.is_empty
		local
			l_int: INTEGER
		do
			make (s.count)
			append_string (s)
				-- Force computation of `hash_code' so that it gets stored in AST.
			l_int := hash_code
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_id_as (Current)
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
			constant_i ?= context.current_class.feature_table.item (Current)
			create depend_unit.make (context.current_class.class_id, constant_i)
			context.supplier_ids.extend (depend_unit)
		end

	good_integer: BOOLEAN is
			-- Is the atomic a good integer bound for multi-branch ?
		local
			constant_i: CONSTANT_I
		do
			constant_i ?= context.current_class.feature_table.item (Current)
			Result := constant_i /= Void
						and then constant_i.value.is_integer
		end

	good_character: BOOLEAN is
			-- Is the atomic a good character bound for multi-branch ?
		local
			constant_i: CONSTANT_I
		do
			constant_i ?= context.current_class.feature_table.item (Current)
			Result := constant_i /= Void
						and then constant_i.value.is_character
		end

	is_inspect_value (type: TYPE_A): BOOLEAN is
			-- Is the atomic a good bound for multi-branch of the given `type'?
		local
			constant_i: CONSTANT_I
		do
			constant_i ?= context.current_class.feature_table.item (Current)
			Result := constant_i /= Void and then constant_i.value.valid_type (type)
		end

	make_integer: INT_CONST_VAL_B is
			-- Integer value
		local
			constant_i: CONSTANT_I
			integer_value: INTEGER_CONSTANT
		do
			constant_i ?= context.current_class.feature_table.item (Current)
			integer_value ?= constant_i.value
			create Result.make (context.current_class, integer_value.integer_32_value, constant_i)
		end

	make_character: CHAR_CONST_VAL_B is
			-- Character value
		local
			constant_i: CONSTANT_I
			char_value: CHAR_VALUE_I
		do
			constant_i ?= context.current_class.feature_table.item (Current)
			char_value ?= constant_i.value
			create Result.make (context.current_class, char_value.character_value, constant_i)
		end

feature {COMPILER_EXPORTER, FEAT_NAME_ID_AS} -- Conveniences

	load (s: STRING) is
		local
			l_int: INTEGER
		do
			wipe_out
			append (s)
				-- Force computation of `hash_code' so that it gets stored in AST.
			l_int := hash_code
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_string (Current)
		end

	string_value: STRING is
		do
			Result := twin
		end

end -- class ID_AS
