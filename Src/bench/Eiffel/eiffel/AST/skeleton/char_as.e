indexing
	description: "Node for character constant. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class CHAR_AS

inherit
	ATOMIC_AS
		redefine
			type_check, byte_node, value_i,
			inspect_value,
			is_valid_inspect_value
		end

	LEAF_AS

	CHARACTER_ROUTINES

create
	initialize

feature {NONE} -- Initialization

	initialize (c: CHARACTER; l, co, p: INTEGER) is
			-- Create a new CHARACTER AST node.
		require
			l_non_negative: l >= 0
			co_non_negative: co >= 0
			p_non_negative: p >= 0
		do
			value := c
			set_position (l, co, p, 1)
		ensure
			value_set: value = c
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_char_as (Current)
		end

feature -- Properties

	value: CHARACTER
			-- Character value

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := value = other.value
		end

feature -- Conveniences

	value_i: CHAR_VALUE_I is
			-- Interface value
		do
			create Result.make (value)
		end

	type_check is
			-- Type check character
		do
			context.put (Character_type)
		end

	byte_node: CHAR_CONST_B is
			-- Associated byte code
		do
			create Result
			Result.set_value (value)
		end

feature {COMPILER_EXPORTER} -- Multi-branch instruction processing

	is_valid_inspect_value (value_type: TYPE_A): BOOLEAN is
			-- Is the atomic a good bound for multi-branch of the given `value_type'?
		do
			Result := value_type.is_character
		end

	inspect_value (value_type: TYPE_A): CHAR_VAL_B is
			-- Inspect value of the given `value_type'
		do
		   create Result.make (value)
		end

feature -- Output

	string_value: STRING is
		do
			Result := char_text (value)
			Result.precede ('%'')
			Result.extend ('%'')
		end

end -- class CHAR_AS
