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
			loc_idx: INTEGER;
			buf: GENERATION_BUFFER
		do
			buf := buffer
			target_type := real_type (attachment_type);
			source_type := real_type (expression.type);
			if source_type.is_none and target_type.is_basic then
				buf.putstring ("RTEC(EN_VEXP);");
				buf.new_line;
			else
				expression.generate;
				if need_metamorphosis then
					generate_metamorphose;
				end;
				if system.has_separate then
					if real_type(attachment_type).is_separate then
						if expression.stored_register.register_name /= Void then
							loc_idx := context.local_index (expression.stored_register.register_name);
						else
							loc_idx := -1;
						end;
						if loc_idx /= -1 then
							buf.put_protected_local_set (context.ref_var_used + loc_idx);
							buf.putstring (" = ");
							if not real_type(expression.type).is_separate then
								buf.putstring (" CURLTS(");
								expression.stored_register.print_register;
								buf.putstring ("); ");
							else
								expression.stored_register.print_register;
								buf.putstring (";");
							end;
							buf.new_line;
						end;
					end;
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
				buf.putstring (" = ");
				buf.putstring ("RTCL(");
				expression.print_register;
				buf.putchar(')');
			else
					-- Simple type objects are metamorphosed
				basic_i ?= source_type;		-- Cannot fail
				basic_i.metamorphose
					(register, expression, buf, context.workbench_mode);
			end;
			buf.putchar(';');
			buf.new_line;
		end;
			
	print_register is
			-- Print expression value
		local
			target_type, source_type: TYPE_I;
			target_ctype, source_ctype: TYPE_C;
			cast_generated: BOOLEAN;
			buf: GENERATION_BUFFER
		do
			buf := buffer
			target_type := real_type (attachment_type);
			source_type := real_type (expression.type);
			if target_type.is_none then
				buf.putstring ("(EIF_REFERENCE) 0");
			elseif target_type.is_true_expanded then
					-- The callee is responsible for cloning the reference.
				expression.print_register;
			elseif target_type.is_basic then
					-- Ensure correct value in case the target is a double
					-- and the source an int.
				target_ctype := target_type.c_type;
				source_ctype := source_type.c_type;
				if source_ctype.level /= target_ctype.level then
					cast_generated := True;
					target_ctype.generate_cast (buf);
					buf.putchar('(');
				end;
				expression.print_register;
				if cast_generated then
					buf.putchar(')');
				end;
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
