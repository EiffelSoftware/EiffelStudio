class EXPR_ADDRESS_BL

inherit

	EXPR_ADDRESS_B
		redefine
			analyze, print_register, propagate,
			generate, unanalyze, free_register,
			register
		end;
	
feature

	register: REGISTER;
			-- Register used to store expression value

	propagate (r: REGISTRABLE) is
			-- Propagate a register in expression.
		do
			if r = No_register or not used (r) then
				if not context.propagated or r = No_register then
					expr.propagate (r);
				end;
			end;
		end;
 
	free_register is
			-- Free register used by expression
		do
			expr.free_register;
			if register /= Void then
				register.free_register
			end
		end;
 
	analyze is
			-- Analyze expression
		do
			context.init_propagation;
			expr.propagate (no_register);
			expr.analyze;
			if
				expr.type.is_basic and then
				(expr.register = Void or else not expr.register.is_temporary)
			then
				!! register.make (expr.type.c_type)
			end
			if expr.is_result and then expr.type.is_basic then
				context.mark_result_used;
			end
		end;
 
	unanalyze is
			-- Undo the analysis of the expression
		do
			expr.unanalyze;
		end;
 
	generate is
			-- Generate expression
		local
			buf: GENERATION_BUFFER
		do
			expr.generate;
			if register /= Void then
				register.print_register;
				buf := buffer
				buf.putstring (" = ");
				expr.print_register;
				buf.putchar (';');
				buf.new_line
			end
		end;
 
	print_register is
			-- Print expression value
		local
			r: REGISTRABLE
			buf: GENERATION_BUFFER
		do
			if register /= Void then
				r := register
			else
				r := expr
			end
			if expr.type.is_basic then
				buf := buffer
				buf.putstring ("(char *)&(");
				r.print_register;
				buf.putchar (')');
			else
				r.print_register;
			end
		end;
 
end
