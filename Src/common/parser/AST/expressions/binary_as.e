indexing
	description: "Abstract class for binary expression nodes, Bench version"
	date: "$Date$"
	revision: "$Revision$"

deferred class BINARY_AS

inherit
	EXPR_AS
		redefine
			start_location, end_location
		end

feature {NONE} -- Initialization

	initialize (l: like left; r: like right) is
			-- Create a new BINARY AST node.
		require
			l_not_void: l /= Void
			r_not_void: r /= Void
		do
			left := l
			right := r
		ensure
			left_set: left = l
			right_set: right = r
		end

feature -- Attributes

	left: EXPR_AS
			-- Left operand

	right: EXPR_AS
			-- Right opernad

feature -- Location

	start_location: LOCATION_AS is
			-- Start location of Current
		do
			Result := left.start_location
		end

	end_location: LOCATION_AS is
			-- End location of Current
		do
			Result := right.end_location
		end
		
	operator_location: LOCATION_AS is
			-- Location of operator
		do
			fixme ("This is not precise enough, we ought to have the precise location.")
			Result := left.end_location
		end

feature -- Properties

	infix_function_name: STRING is
			-- Internal name of the infix feature associated to the
			-- binary expression
		deferred
		end

	operator_name: STRING is
		do
			Result := infix_function_name;	
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

