-- Access to Current

class CURRENT_B

inherit

	ACCESS_B
		redefine
			enlarged, is_current, generate_il_call_access,
			register_name, pre_inlined_code, print_register, generate_il_address, generate_il_value,
			is_fast_as_local
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_current_b (Current)
		end

feature

	type: TYPE_I is
			-- Current type
		do
			Result := context.current_type;
		end;

	is_current: BOOLEAN is
			-- This is an access to Current
		do
			Result := True
		end

	same (other: ACCESS_B): BOOLEAN is
			-- Is `other' the same access as Current ?
		local
			current_b: CURRENT_B;
		do
			current_b ?= other;
			Result := current_b /= Void
		end;

	enlarged: CURRENT_B is
			-- Enlarges the tree to get more attributes and returns the
			-- new enlarged tree node.
		do
				-- This is the root of the call tree
			create {CURRENT_BL} Result;
		end;

	register_name: STRING is
			-- The "Current" string
		once
			Result := "Current";
		end;

	print_register is
			-- Print "Current" register
		do
			context.buffer.put_string (register_name)
		end

feature -- IL code generation

	is_fast_as_local: BOOLEAN is true
			-- Is expression calculation as fast as loading a local?

	generate_il_call_access (is_target_of_call: BOOLEAN) is
			-- Generate IL code for an access to Current
		do
			if is_target_of_call then
				il_generator.generate_current
			else
				generate_il_value
			end
		end

	generate_il_address is
			-- Generate address of Current.
		do
			il_generator.generate_current_address
		end

	generate_il_value is
			-- Generate code that evaluates expression and puts its value
			-- (rather than a pointer to it) to the evaluation stack.
		local
			type_i: TYPE_I
		do
			il_generator.generate_current
			type_i := real_type (type)
			if type_i.is_expanded then
				il_generator.generate_load_from_address (type_i)
			end
		end

feature -- Inlining

	pre_inlined_code: CURRENT_B is
		do
			create {INLINED_CURRENT_B} Result
		end

end
