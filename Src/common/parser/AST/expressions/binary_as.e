indexing
	description: 
		"AST representation for binary expression nodes."
	date: "$Date$"
	revision: "$Revision$"

deferred class BINARY_AS

inherit
	EXPR_AS

feature {AST_FACTORY} -- Initialization

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

	left: EXPR_AS;
			-- Left operand

	right: EXPR_AS;
			-- Right operand

feature -- Properties

	balanced: BOOLEAN is
			-- Is the current binary operation subject to the balancing
			-- rule proper to simple numeric types ?
		do
			-- Do nothing
		end

	bit_balanced: BOOLEAN is
			-- Is the current binary operation subject to the
			-- balancing rule proper to bit types ?
		do
			-- Do nothing
		end

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

--feature {AST_EIFFEL} -- Output
--
--	simple_format (ctxt: FORMAT_CONTEXT) is
--			-- Reconstitute text.
--		do
--			left.simple_format (ctxt);
--			ctxt.prepare_for_infix (operator_name, right);
--			ctxt.put_infix_feature;
--		end

feature {BINARY_AS}	-- Replication

	set_left (l: like left) is
		require
			valid_arg: l /= Void
		do
			left := l
		end

	set_right (l: like right) is
		require
			valid_arg: l /= Void
		do
			right := l
		end

end -- class BINARY_AS
