indexing

	description: "Node for real constant. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class REAL_AS

inherit
	ATOMIC_AS
		redefine
			is_equivalent
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

feature {AST_EIFFEL} -- Output

	string_value: STRING is
		do
			Result := value.twin
		end

end -- class REAL_AS
