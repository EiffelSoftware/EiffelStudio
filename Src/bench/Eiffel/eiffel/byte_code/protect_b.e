-- Run-time protection service for external parameters (non-hector ones which
-- are true Eiffel references).

class PROTECT_B 

inherit

	UNARY_B
		redefine
			register, set_register,
			analyze, generate, unanalyze,
			print_register, free_register,
			type, enlarged, make_byte_code,
			is_unsafe, optimized_byte_node,
			pre_inlined_code, inlined_byte_code,
			generate_il
		end
	
feature 

	register: REGISTRABLE;
			-- Register used to store the hector pointer
	
	set_register (r: REGISTRABLE) is
			-- Assign `r' to `register'
		do
			register := r;
		end;

	type: TYPE_I is
			-- Expression's type
		do
			Result := expr.type;
		end;

	analyze is
			-- Analyze expression and get a register to store the hector index
		local
			ref_register: REF_REGISTER;
		do
			context.init_propagation;
			expr.analyze;
			!!ref_register.make (Reference_c_type);
			register := ref_register;
		end;

	unanalyze is
			-- Undo the analysis
		do
			expr.unanalyze;
		end;

	generate is
			-- Generate the parameter, and then the protection. Of course, the
			-- scheme relies on the property that every parameter is stored in
			-- a register (no Void_register propagation).
		local
			buf: GENERATION_BUFFER
		do
			expr.generate;
			register.print_register;
			buf := buffer
			buf.putstring (" = RTHP(");
			expr.print_register;
			buf.putstring (gc_rparan_semi_c);
			buf.new_line;
		end;
	
	enlarged: like Current is
			-- Enlarge the expression
		do
			expr := expr.enlarged;
			Result := Current;
		end;

	print_register is
			-- Print the value of the variable
		do
			register.print_register;
		end;

	free_register is
			-- Free register used to store the hector pointer and al.
		do
			register.free_register;
			expr.free_register;
		end;

feature -- IL code generation

	il_operator_constant: INTEGER is
			-- Il operator value.
		do
			check False end
		end

	generate_il is
			-- Generate IL code for protected expression.
		do
			check False end
		end

feature -- Byte code generation

	operator_constant: CHARACTER is
			-- Do nothing
		do
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a protected expression
		do
			expr.make_byte_code (ba);
		end;

feature -- Array optimization

	is_unsafe: BOOLEAN is
		do
			Result := expr.is_unsafe
		end

	optimized_byte_node: like Current is
		do
			Result := Current
			expr := expr.optimized_byte_node
		end

feature -- Inlining

	pre_inlined_code: like Current is
		do  
			Result := Current
			expr ?= expr.pre_inlined_code
		end

	inlined_byte_code: like Current is
		do
			Result := Current
			expr := expr.inlined_byte_code
		end

end
