-- An Eiffel expression.

deferred class EXPR_B

inherit

	REGISTRABLE
		redefine
			get_register, free_register
		end;

	BYTE_NODE
		redefine
			need_enlarging, enlarged
		end;
	SHARED_C_LEVEL;
	TYPE_I_CONST;

feature

	type: TYPE_I is
			-- Expression type
		deferred
		end;

	c_type: TYPE_C is
			-- C type of the expression
		do
			Result := real_type (type).c_type;
		end;

	used (r: REGISTRABLE): BOOLEAN is
			-- Is register `r' used in local or forthcomming dot calls ?
		deferred
		end;

	get_register is
			-- Get a temporary register to hold result of expr. If a register
			-- has already been propagated, then `register' is not void and
			-- nothing has to be done.
		local
			tmp_register: REGISTER;
			ctype: TYPE_C;
		do
			if register = Void then
				ctype := c_type;
				if not ctype.is_void then
					!!tmp_register.make (ctype);
					set_register (tmp_register);
				end;
			end;
		ensure then
			register_exists: register = Void implies type.is_void;
		end;

	free_register is
			-- Free register used by expr, if necessary
		do
			if register /= Void then
				register.free_register;
			end;
		end;

	print_register is
			-- Print register.
		do
			register.print_register;
		end;

	is_simple_expr: BOOLEAN is
			-- Is the current expression a simple one ?
			-- Definition: an expression <E> is simple if the assignment
			-- target := <E> is generated as such in C when "target" is a
			-- predefined entity propagated in <E>.
			-- Currently, the only simple expressions are the calls
			-- the manifest strings and the constants.
		do
		end;

	is_hector: BOOLEAN is
			-- Is the current expression an hector one ?
			-- Definition: an expression <E> is hector if it is a parameter
			-- of an external function call, <E> is of the form $<A> and <A>
			-- is an attribute or a local variable.
		do
		end;

	has_gcable_variable: BOOLEAN is
			-- Does the expression have a GCable variable ?
			-- Definition: a GCable variable is a variable which is placed
			-- under the control of the garbage collector, directly or
			-- indirectly via the hooks.
		do
		end;

	has_call: BOOLEAN is
			-- Does the expression have a call ?
		do
		end;

	unanalyze is
			-- Undo the effect of analyze.
		do
		end;

	stored_register: REGISTRABLE is
			-- The register in which the expression is stored
		do
			Result := register;
			if Result = Void then
				Result := Current;
			end;
		end;

	need_enlarging: BOOLEAN is true;
			-- All the expressions need enlarging

	enlarged: EXPR_B is
			-- Redefined for type check
		do
			Result := Current;
		end;

	register_name: STRING is
			-- Do nothing
		do
		end;

end
