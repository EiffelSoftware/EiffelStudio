-- Enlarged parameter expression

class PARAMETER_BL 

inherit

	PARAMETER_B
		redefine
			analyze, generate, unanalyze, register, set_register,
			free_register, print_register, propagate, c_type
		end;
	
feature 

	register: REGISTRABLE;
			-- Register used to store metamorphosed value

	set_register (r: REGISTRABLE) is
			-- Assign `r' to `register'
		do
			register := r;
		end;

	c_type: TYPE_C is
			-- C type of the attachment target
		do
			Result := real_type (attachment_type).c_type;
		end;

	need_metamorphosis: BOOLEAN is
			-- Do we need to issue a metamorphosis on the parameter?
		local
			target_type, source_type: TYPE_I;
		do
			target_type := real_type (attachment_type);
			source_type := real_type (expression.type);
			Result := not (target_type.is_none or target_type.is_expanded) and then
				(source_type.is_expanded)
		end;

	propagate (r: REGISTRABLE) is
			-- Propagate a register in expression.
		do
			expression.propagate (r);
			if r /= No_register and then r.c_type.is_pointer then
				register := r;
			end;
		end;

	free_register is
			-- Free register used by expression
		do
			expression.free_register;
			if register /= Void then
				register.free_register;
			end;
		end;

	analyze is
			-- Analyze expression
		do
			expression.analyze;
			if need_metamorphosis then
				get_register;
			end;
		end;
	
	unanalyze is
			-- Undo the analysis of the expression
		do
			expression.unanalyze;
			register := Void;
		end;
	
	generate is
			-- Generate expression
		local
			target_type, source_type: TYPE_I;
			buf: GENERATION_BUFFER
		do
			buf := buffer
			target_type := real_type (attachment_type);
			source_type := real_type (expression.type);
			if source_type.is_none and target_type.is_basic then
				buf.put_string ("RTEC(EN_VEXP);");
				buf.put_new_line;
			else
				expression.generate;
				if need_metamorphosis then
					generate_metamorphose;
				end;
			end;
		end;

	generate_metamorphose is
			-- Change value of parameter by running a metamorphose
		local
			source_type: TYPE_I;
			basic_i: BASIC_I;
			buf: GENERATION_BUFFER
		do
			buf := buffer
			source_type := real_type (expression.type);
			if source_type.is_true_expanded then
					-- Expanded objects are cloned
				register.print_register;
				buf.put_string (" = ");
				buf.put_string ("RTCL(");
				expression.print_register;
				buf.put_character(')');
			else
					-- Simple type objects are metamorphosed
				basic_i ?= source_type;		-- Cannot fail
				basic_i.metamorphose
					(register, expression, buf, context.workbench_mode);
			end;
			buf.put_character(';');
			buf.put_new_line;
		end;
			
	print_register is
			-- Print expression value
		local
			target_type, source_type: TYPE_I;
			l_basic: BASIC_I
			target_ctype, source_ctype: TYPE_C;
			cast_generated: BOOLEAN;
			buf: GENERATION_BUFFER
		do
			buf := buffer
			target_type := real_type (attachment_type);
			source_type := real_type (expression.type);
			if target_type.is_none then
				buf.put_string ("(EIF_REFERENCE) 0");
			elseif target_type.is_true_expanded then
					-- The callee is responsible for cloning the reference.
				expression.print_register;
			elseif target_type.is_basic then
				if source_type.is_none then
						-- We pass `Void' as argument of a routine which expects a basic type,
						-- since the exception is triggered before the call (see `generate')
						-- our goal is to generate code that compiles, therefore we generate
						-- the value by default.
					l_basic ?= target_type
					check l_basic_not_void: l_basic /= Void end
					l_basic.generate_default_value (buf)
				else
						-- Ensure correct value in case the target is a double
						-- and the source an int.
					target_ctype := target_type.c_type;
					source_ctype := source_type.c_type;
					if source_ctype.level /= target_ctype.level then
						cast_generated := True;
						target_ctype.generate_cast (buf);
						buf.put_character('(');
					end;
					expression.print_register;
					if cast_generated then
						buf.put_character(')');
					end;
				end
			else
					-- In that case, we have been careful not to propagate any
					-- 'No_register' value. However, this does not mean there
					-- is an attached register if the source is basic (e.g. if
					-- we have the constant '4' or '5 - 3'). This is where
					-- the 'register' attribute plays its role...
				if source_type.is_expanded then
					register.print_register;
				else
					expression.print_register;
				end;
			end;
		end;

	fill_from (p: PARAMETER_B) is
			-- Fill in node from parameter `b'
		do
			expression := p.expression.enlarged;
			attachment_type := p.attachment_type;
		end;

end
