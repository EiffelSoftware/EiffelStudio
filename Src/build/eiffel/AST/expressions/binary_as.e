
-- Abstract class for binary expression nodes

deferred class BINARY_AS

inherit

	EXPR_AS
		redefine
			simple_format
		end;

feature -- Attributes

	left: EXPR_AS;
			-- Left operand

	right: EXPR_AS;
			-- Right opernad

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

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.begin;
			left.simple_format (ctxt);
			if ctxt.last_was_printed then
				ctxt.need_dot;
				ctxt.prepare_for_infix (operator_name, right);
				ctxt.put_current_feature;
				if ctxt.last_was_printed then
					ctxt.commit;
				end
			end
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
end
