indexing

	description: "Node for boolean constant. Version for Bench."
	date: "$Date$"; revision: "$Revision$"

class BOOL_AS

inherit
	ATOMIC_AS
		redefine
			type_check, byte_node, value_i, is_equivalent
		end

feature {AST_FACTORY} -- Initialization

	initialize (b: BOOLEAN) is
			-- Create a new BOOLEAN AST node.
		do
			value := b
		ensure
			value_set: value = b
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
			!! Result
			Result.set_bool_val (value)
		end

	type_check is
			-- Type chek a boolean type
		do
			context.put (Boolean_type)
		end

	byte_node: BOOL_CONST_B is
			-- Associated byte code
		do
			!! Result
			Result.set_value (value)
		end

feature -- Output

	string_value: STRING is
		do
			Result := value.out
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
		do
			if value then
				ctxt.put_text_item (ti_True_keyword)
			else
				ctxt.put_text_item (ti_False_keyword)
			end
		end

end -- class BOOL_AS
