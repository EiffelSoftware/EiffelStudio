indexing

	description: "Node for real constant. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class REAL_AS

inherit
	ATOMIC_AS
		redefine
			type_check, byte_node, value_i, is_equivalent
		end

feature {AST_FACTORY} -- Initialization

	initialize (r: STRING) is
			-- Create a new REAL AST node with `r'
			-- containing the textual representation
			-- of the real value.
		require
			r_not_void: r /= Void
		do
			value := r
		ensure
			value_set: value = r
		end

feature -- Properties

	value: STRING
			-- Real value

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := value.is_equal (other.value)
		end

feature -- Type check and byte code

	value_i: REAL_VALUE_I is
			-- Interface value
		do
			!! Result
			Result.set_real_val (value)
		end

	type_check is
			-- Type check a real type
		do
			context.put (Double_type)
		end

	byte_node: REAL_CONST_B is
			-- Associated byte code
		do
			!! Result
			Result.set_value (value)
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_text_item (
				create {NUMBER_TEXT}.make (string_value)
			)
		end

	string_value: STRING is
		do
			Result := clone (value)
		end

end -- class REAL_AS
