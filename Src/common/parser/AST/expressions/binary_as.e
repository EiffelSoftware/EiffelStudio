indexing

	description: "Abstract class for binary expression nodes";
	date: "$Date$";
	revision: "$Revision$"

deferred class BINARY_AS

inherit

	EXPR_AS

feature -- Attributes

	left: EXPR_AS;
			-- Left operand

	right: EXPR_AS;
			-- Right operand

feature -- Initialization

	set is
			-- Yacc initialization
		do
			left ?= yacc_arg (0);
			right ?= yacc_arg (1);
		ensure then
			left_exists: left /= Void;
			right_exists: right /= Void
		end;

feature -- Balancing rule control

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

feature -- Type check, byte code and dead code removal

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

feature -- Simple formatting

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
