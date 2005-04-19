indexing

	description: "Node for boolean constant. Version for Bench."
	date: "$Date$"; revision: "$Revision$"

class BOOL_AS

inherit
	ATOMIC_AS
		redefine
			is_equivalent
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

feature -- Output

	string_value: STRING is
		do
			Result := value.out
		end

end -- class BOOL_AS
