indexing
    description: "Node for id. Version for Bench."
    date: "$Date$"
    revision: "$Revision$"

class ID_AS

inherit
	ATOMIC_AS
		undefine
			copy, out, is_equal, setup, consistent
		redefine
			pass_address, is_id,
			good_integer, good_character,
			make_integer, make_character,
			record_dependances,
			is_equivalent
		end

	STRING
		rename
			set as string_set,
			is_integer as string_is_integer
		end

creation
	make

feature {AST_FACTORY} -- Initialization

	initialize (s: STRING) is
			-- Create a new ID AST node made up
			-- of characters contained in `s'.
		require
			s_not_void: s /= Void
			s_not_empty: not s.empty
		do
			make (s.count)
			append_string (s)
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		local
			s: STRING
		do
			s ?= yacc_arg (0)
			append (s)
		ensure then
			not_empty: not empty
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
			!!depend_unit.make (context.a_class.id, constant_i)
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
			integer_value: INT_VALUE_I
		do
			constant_i ?= context.a_class.feature_table.item (Current)
			integer_value ?= constant_i.value
			!! Result.make (integer_value.int_val, constant_i)
		end

	make_character: CHAR_CONST_VAL_B is
			-- Character value
		local
			constant_i: CONSTANT_I
			char_value: CHAR_VALUE_I
		do
			constant_i ?= context.a_class.feature_table.item (Current)
			char_value ?= constant_i.value
			!! Result.make (char_value.char_val, constant_i)
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

feature -- C interactions

	pass_address (n: INTEGER) is
			-- Eiffel-Yacc interface
		do
			c_get_address (n, $Current, $set)
			getid_create ($make)
			getid_area ($to_c)
		end

feature {NONE}

	getid_create (ptr: POINTER) is
		external
			"C"
		end

	getid_area (ptr: POINTER) is
		external
			"C"
		end

end -- class ID_AS
