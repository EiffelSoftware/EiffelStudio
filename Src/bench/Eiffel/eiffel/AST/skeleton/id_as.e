indexing
    description: "Node for id. Version for Bench."
    date: "$Date$"
    revision: "$Revision$"

class ID_AS

inherit
	LEAF_AS
		undefine
			copy, out, is_equal
		end

	ATOMIC_AS
		undefine
			copy, out, is_equal
		redefine
			inspect_value,
			is_id,
			is_equivalent,
			is_valid_inspect_value,
			record_dependances,
			unique_constant
		end

	STRING
		rename
			set as string_set,
			is_integer as string_is_integer
		end

create
	make, initialize

feature {NONE} -- Initialization

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
			append (s)
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

feature -- Type check

	record_dependances is
		local
			constant_i: CONSTANT_I
			depend_unit: DEPEND_UNIT 
		do
			constant_i ?= context.current_class.feature_table.item (Current)
			create depend_unit.make (context.current_class.class_id, constant_i)
			context.supplier_ids.extend (depend_unit)
		end

feature {COMPILER_EXPORTER} -- Multi-branch instruction processing

	is_valid_inspect_value (value_type: TYPE_A): BOOLEAN is
			-- Is the atomic a good bound for multi-branch of the given `value_type'?
		local
			constant_i: CONSTANT_I
		do
			constant_i ?= context.current_class.feature_table.item (Current)
			Result := constant_i /= Void and then constant_i.value.valid_type (value_type)
		end

	inspect_value (value_type: TYPE_A): INTERVAL_VAL_B is
			-- Inspect value of the given `value_type'
		local
			constant_i: CONSTANT_I
		do
			constant_i ?= context.current_class.feature_table.item (Current)
			Result := constant_i.value.inspect_value (value_type)
		end

	unique_constant: CONSTANT_I is
			-- Associated unique constant (if any)
		local
			constant_i: CONSTANT_I
		do
			constant_i ?= context.current_class.feature_table.item (Current)
			if constant_i /= Void and then constant_i.is_unique then
				Result := constant_i
			end
		end

feature {AST_EIFFEL} -- Output

	string_value: STRING is
		do
			Result := twin
		end

end -- class ID_AS
