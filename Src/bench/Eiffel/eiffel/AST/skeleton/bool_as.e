indexing

	description: "Node for boolean constant. Version for Bench."
	date: "$Date$"; revision: "$Revision$"

class BOOL_AS

inherit
	ATOMIC_AS
		redefine
			type_check, byte_node, value_i, is_equivalent
		end
		
	LEAF_AS

create
	initialize

feature {NONE} -- Initialization

	initialize (b: BOOLEAN; l, c, p, s: INTEGER) is
			-- Create a new BOOLEAN AST node.
		do
			value := b
			set_position (l, c, p, s)
		ensure
			value_set: value = b
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_bool_as (Current)
		end

feature -- Properties

	value: BOOLEAN
			-- Integer value

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := value = other.value
		end

feature -- Type check

	value_i: BOOL_VALUE_I is
		do
			create Result.make (value)
		end

	type_check is
			-- Type chek a boolean type
		do
			context.put (Boolean_type)
		end

	byte_node: BOOL_CONST_B is
			-- Associated byte code
		do
			create Result.make (value)
		end

feature -- Output

	string_value: STRING is
		do
			Result := value.out
		end

end -- class BOOL_AS
