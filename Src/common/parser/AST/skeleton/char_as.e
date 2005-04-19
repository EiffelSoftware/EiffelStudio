indexing
	description: "Node for character constant. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class CHAR_AS

inherit
	ATOMIC_AS

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

feature -- Output

	string_value: STRING is
		do
			Result := char_text (value)
			Result.precede ('%'')
			Result.extend ('%'')
		end

end -- class CHAR_AS
