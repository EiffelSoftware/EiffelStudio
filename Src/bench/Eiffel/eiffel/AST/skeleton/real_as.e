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
		
	LEAF_AS

create
	make

feature {NONE} -- Initialization

	make (a_type: like constant_type; r: STRING) is
			-- Create a new REAL_AS node of type `a_type' with `r'
			-- containing the textual representation
			-- of the real value.
		require
			r_not_void: r /= Void
		do
			value := r.string
			value.replace_substring_all ("_","")
			constant_type := a_type
		ensure
			value_not_void: value /= Void
			value_set: not r.has ('_') implies value.is_equal (r)
				-- and then r.has ('_') implies value.is_equal (r) (modulo removed underscores)
			constant_type_set: constant_type = a_type
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_real_as (Current)
		end

feature -- Access

	value: STRING
			-- Real value
			
	constant_type: TYPE_A
			-- Actual type of real constant if specified.

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := value.is_equal (other.value) and then equal (constant_type, other.constant_type)
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
			if constant_type = Void then
				context.put (Real_64_type)
			else
				fixme ("We should check the `constant_type' matches the real `value'.")
				context.put (constant_type)
			end
		end

	byte_node: REAL_CONST_B is
			-- Associated byte code
		do
			create Result
			Result.set_value (value)
		end

feature {AST_EIFFEL} -- Output

	string_value: STRING is
		do
			Result := value.twin
		end

end -- class REAL_AS
