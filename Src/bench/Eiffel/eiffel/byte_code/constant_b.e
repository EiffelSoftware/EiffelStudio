-- Byte code for constants (hardwired in final mode)

class CONSTANT_B 

inherit

	ACCESS_B
		redefine
			set_parent, canonical,
			has_gcable_variable, is_single, enlarged, is_constant,
			propagate, print_register, free_register,
			unanalyze, analyze, analyze_on, generate, generate_on,
			make_byte_code, allocates_memory, generate_il, need_target
		end
	
feature -- Access

	value: VALUE_I;
			-- Constant value for hardwiring
	
	access: ACCESS_B;
			-- Accessing constant when hardwiring not possible

	canonical: CALL_B is
			-- Canonical call
		do
			Result := access
		end;

	type: TYPE_I is
			-- Access type
		do
			Result := access.type;
		end;

feature -- Status

	is_constant: BOOLEAN is True
			-- Current is constant

	need_target: BOOLEAN is False
			-- Current does not need a target to be accessed.

feature -- Setting

	set_value (v: like value) is
			-- Assign `v' to `value'.
		do
			value := v;
		end;
	
	set_access (a: like access) is
			-- Assign `a' to `access'.
		do
			access := a;
		end;

	set_parent (n: NESTED_B) is
			-- Assign `n' to `parent'.
		do
			parent := n;
			access.set_parent (n);
		end;

feature -- Comparison

	same (other: ACCESS_B): BOOLEAN is
			-- Is `other' the same access to constant ?
		local
			constant_b: CONSTANT_B;
			o_value: like value
		do
			constant_b ?= other;
			if constant_b /= Void then
				o_value := constant_b.value
				Result := value.same_type (o_value) and then
					value.is_equivalent (o_value)
			end
		end;

	has_gcable_variable: BOOLEAN is
			-- Does current access makes use of a GC-able variable
		do
			if context.workbench_mode then
				Result := access.has_gcable_variable;
			end;
		end;
	
	is_single: BOOLEAN is
			-- Is access a single one ?
		do
			if context.workbench_mode then
				Result := access.is_single;
			else
					-- Hardwired constant is a single access
				Result := true;
			end;
		end;

	propagate (r: REGISTRABLE) is
			-- Propagate register accross access
		do
			if context.workbench_mode then
				access.propagate (r);
			end;
		end;
	
	print_register is
			-- Print register value (generates constant)
		do
			if context.workbench_mode then
				access.print_register;
			else
				value.generate (buffer);
			end;
		end;

	free_register is
			-- Free register used by constant
		do
			if context.workbench_mode then
				access.free_register;
			end;
		end;
	
	unanalyze is
			-- Undo the analysis
		do
			if context.workbench_mode then
				access.unanalyze;
			end;
		end;

	analyze is
			-- Analyze constant
		do
			if context.workbench_mode then
				access.analyze;
			end;
		end;
	
	analyze_on (reg: REGISTRABLE) is
			-- Analyze constant access on `reg'
		do
			if context.workbench_mode then
				access.analyze_on (reg);
			end;
		end;

	generate is
			-- Generate constant
		do
			if context.workbench_mode then
				access.generate;
			end;
		end;

	generate_on (reg: REGISTRABLE) is
			-- Generate constant access on `reg'
		do
			if context.workbench_mode then
				access.generate_on (reg);
			else
				print_register
			end;
		end;

	enlarged: like Current is
			-- Enlarge access
		do
			if context.workbench_mode then
				access := access.enlarged;
			end;
			Result := Current;
		end;

	allocates_memory: BOOLEAN is
		do
			Result := value.is_string or else value.is_bit
		end

feature -- IL code generation

	generate_il is
			-- Generate byte code for a call to a constant.
		do
			value.generate_il
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a call to a constant
		do
			access.make_byte_code (ba);
		end;

end
