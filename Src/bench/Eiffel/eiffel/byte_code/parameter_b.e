-- Parameter expression

class PARAMETER_B 

inherit

	EXPR_B
		redefine
			enlarged, is_hector, make_byte_code,
			is_simple_expr, has_gcable_variable, has_call,
			stored_register, is_unsafe, optimized_byte_node,
			calls_special_features, size,
			pre_inlined_code, inlined_byte_code,
			allocates_memory, generate_il
		end;
	
feature 

	expression: EXPR_B;
			-- Expression

	attachment_type: TYPE_I;
			-- Type to which the expression is attached

	set_expression (e: EXPR_B) is
			-- Assign `e' to `expression'.
		do
			expression := e;
		end;

	set_attachment_type (t: TYPE_I) is
			-- Assign `t' to `attachment_type'.
		do
			attachment_type := t;
		end;

	type: TYPE_I is
			-- Expression type
		do
			Result := expression.type;
		end;

	used (r: REGISTRABLE): BOOLEAN is
			-- Is `r' used in the expression ?
		do
			Result := expression.used (r);
		end;

	is_hector: BOOLEAN is
			-- Is the expression a non-protected one ?
		do
			Result := expression.is_hector;
		end;

	is_simple_expr: BOOLEAN is
			-- Is the current expression a simple one ?
		do
			Result := expression.is_simple_expr;
		end;
	
	has_gcable_variable: BOOLEAN is
			-- Does the expression have a GCable variable ?
		do
			Result := expression.has_gcable_variable;
		end;

	has_call: BOOLEAN is
			-- Does the expression have a call ?
		do
			Result := expression.has_call;
		end;

	allocates_memory: BOOLEAN is
		do
			Result :=
					-- Is there a metamorphosis?
				(not attachment_type.is_basic and expression.type.is_basic)
				or else expression.allocates_memory
		end;

	stored_register: REGISTRABLE is
			-- The register in which the expression is stored
		do
			Result := expression.stored_register;
		end;

	enlarged:  PARAMETER_BL is
			-- Enlarge the expression
		do
			!!Result;
			Result.fill_from (Current);
		end;

feature -- IL code generation

	generate_il is
			-- Generate IL code for `expression'
		local
			target_type, source_type: TYPE_I
		do
			expression.generate_il

			target_type := context.real_type (attachment_type);
			if target_type.is_none then
					-- Do nothing
			elseif target_type.is_reference then
				source_type := context.real_type (expression.type)
				if source_type.is_expanded then
						-- Source is an expanded type and target is a reference:
						-- metamorphose with boxing.
					generate_il_metamorphose (source_type, target_type, True)
				end
			end
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for the expression
		local
			target_type, source_type: TYPE_I;
			basic_target, basic_source: BASIC_I;
			basic_type: BASIC_I;
		do
			expression.make_byte_code (ba);
			target_type := context.real_type (attachment_type);
			source_type := context.real_type (expression.type);

			if target_type.is_none then
					-- Do nothing
			elseif target_type.is_true_expanded then
					-- The feature called with this actual parameter
					-- will do the copy and trigger a possible exception
					-- Do nothing here.
			elseif target_type.is_basic then
				if source_type.is_none then
					ba.append (Bc_exp_excep);
				end;
				if target_type.is_numeric and then source_type.is_numeric then
					basic_target ?= target_type;
					basic_source ?= source_type;
					if
						basic_source.level /= basic_target.level
					then
						basic_target.generate_byte_code_cast (ba)
					end;
				end;
			else
				if source_type.is_basic then
						-- Source is basic and target is a reference:
						-- metamorphose
					basic_type ?= source_type;
					ba.append (Bc_metamorphose);
				elseif source_type.is_true_expanded then
						-- Source is expanded and target is a reference:
						-- clone
					ba.append (Bc_clone);
				end;
				if system.has_separate and then 
				(target_type.is_separate and not source_type.is_separate) then
					ba.append (Bc_sep_to_sep);
				end;
			end;
		end;

feature -- Array optimization

	calls_special_features (array_desc: INTEGER): BOOLEAN is
		do
			Result := expression.calls_special_features (array_desc)
		end

	is_unsafe: BOOLEAN is
		do
			Result := expression.is_unsafe
		end

	optimized_byte_node: like Current is
		do
			Result := Current
			expression := expression.optimized_byte_node
		end

feature -- Inlining

	size: INTEGER is
		do
			Result := expression.size
		end

	pre_inlined_code: like Current is
		do
			Result := Current;
			expression := expression.pre_inlined_code
		end

	inlined_byte_code: like Current is
		do
			Result := Current
			expression := expression.inlined_byte_code
		end

end
