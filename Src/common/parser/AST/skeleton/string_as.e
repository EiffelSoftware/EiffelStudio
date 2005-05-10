indexing

	description: "Node for string constants. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class STRING_AS

inherit
	ATOMIC_AS
		redefine
			is_equivalent
		end
	
	LEAF_AS
	
	CHARACTER_ROUTINES

create
	initialize

feature {NONE} -- Initialization

	initialize (s: STRING; l, c, p, n: INTEGER) is
			-- Create a new STRING AST node.
		require
			s_not_void: s /= Void
			l_non_negative: l >= 0
			c_non_negative: c >= 0
			p_non_negative: p >= 0
			n_non_negative: n >= 0
		do
			value := s
			set_position (l, c, p, n)
		ensure
			value_set: value = s
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_string_as (Current)
		end

feature -- Properties

	value: STRING
			-- Real string value.
			
	is_once_string: BOOLEAN
			-- Is current preceded by `once' keyword?

feature -- Settings

	set_is_once_string (v: like is_once_string) is
			-- Set `is_once_string' with `v'.
		do
			is_once_string := v
		ensure
			is_once_string_set: is_once_string = v
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
				-- `value' cannot be Void
			Result := is_once_string = other.is_once_string and then value.is_equal (other.value)
		end

feature -- Output

	string_value: STRING is
			-- Formatted value.
		do
			Result := eiffel_string (value)
			Result.precede ('"')
			Result.extend ('"')
		end

feature {INFIX_PREFIX_AS, DOCUMENTATION_ROUTINES} -- Status setting

	set_value (s: STRING) is
		do
			value := s
		end

invariant
	value_not_void: value /= Void

end -- class STRING_AS
