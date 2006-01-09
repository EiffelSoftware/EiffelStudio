indexing
	description: "Abstract class for binary expression nodes, Bench version"
	date: "$Date$"
	revision: "$Revision$"

deferred class BINARY_AS

inherit
	EXPR_AS
	
feature {NONE} -- Initialization

	initialize (l: like left; r: like right; o: like operator) is
			-- Create a new BINARY AST node.
		require
			l_not_void: l /= Void
			r_not_void: r /= Void
		do
			left := l
			right := r
			operator := o
		ensure
			left_set: left = l
			right_set: right = r
			operator_set: operator = o
		end

feature -- Attributes

	left: EXPR_AS
			-- Left operand

	right: EXPR_AS
			-- Right opernad

feature -- Roundtrip

	operator: AST_EIFFEL
			-- Binary operation AST node.

feature -- Location

	operator_location: LOCATION_AS is
			-- Location of operator
		do
			fixme ("This is not precise enough, we ought to have the precise location.")
			Result := left.end_location
		end

feature -- Roundtrip/Location

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			Result := left.complete_start_location (a_list)
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			Result := right.complete_end_location (a_list)
		end

feature -- Properties

	infix_function_name: STRING is
			-- Internal name of the infix feature associated to the
			-- binary expression
		deferred
		end

	op_name: STRING is
			-- Symbol representing the operator (without the infix).
		deferred
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (left, other.left) and then
				equivalent (right, other.right)
		end

invariant
	left_not_void: left /= Void
	right_not_void: right /= Void

end -- class BINARY_AS

