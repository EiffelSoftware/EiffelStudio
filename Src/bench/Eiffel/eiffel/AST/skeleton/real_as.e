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
			value.replace_substring_all ("_","")
		ensure
			value_set: value = r
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_real_as (Current)
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
			create Result.make_real_64 (value.to_double)
		end

	type_check is
			-- Type check a real type
		do
			context.put (Real_64_type)
		end

	byte_node: REAL_CONST_B is
			-- Associated byte code
		do
			create Result
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
			Result := value.twin
		end

end -- class REAL_AS
