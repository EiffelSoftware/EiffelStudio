indexing

	description: 
		"AST representation for binary expression nodes.";
	date: "$Date$";
	revision: "$Revision$"

deferred class BINARY_AS

inherit

	EXPR_AS

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			left ?= yacc_arg (0);
			right ?= yacc_arg (1);
		ensure then
			left_exists: left /= Void;
			right_exists: right /= Void
		end;

feature -- Properties

	left: EXPR_AS;
			-- Left operand

	right: EXPR_AS;
			-- Right operand

	balanced: BOOLEAN is
			-- Is the current binary operation subject to the balancing
			-- rule proper to simple numeric types ?
		do
			-- Do nothing
		end;

	balanced_result: BOOLEAN is
			-- is the result of the infix operation subject to the
			-- balancing rule ?
		do
			-- Do nothing
		end;

	bit_balanced: BOOLEAN is
			-- Is the current binary operation subject to the
			-- balancing rule proper to bit types ?
		do
			-- Do nothing
		end;

	infix_function_name: STRING is
			-- Internal name of the infix feature associated to the
			-- binary expression
		deferred
		end;

	operator_is_keyword: BOOLEAN is
		do
			Result := true;
		end;

	operator_is_special: BOOLEAN is 
		do
			Result := false;
		end;

	operator_name: STRING is
		do
			Result := infix_function_name;	
		end;

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (left, other.left) and then
				equivalent (right, other.right)
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			left.simple_format (ctxt);
			ctxt.prepare_for_infix (operator_name, right);
			ctxt.put_infix_feature;
		end;

feature {BINARY_AS}	-- Replication

	set_left (l: like left) is
		require
			valid_arg: l /= Void
		do
			left := l
		end;

	set_right (l: like right) is
		require
			valid_arg: l /= Void
		do
			right := l
		end;

end -- class BINARY_AS
