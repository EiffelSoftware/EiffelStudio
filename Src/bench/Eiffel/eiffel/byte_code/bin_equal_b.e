deferred class BIN_EQUAL_B

inherit
	BINARY_B
		rename
			register as left_register,
			set_register as set_left_register
		redefine
			free_register, unanalyze, generate_il,
			is_commutative, print_register, type,
			generate, analyze, is_unsafe, optimized_byte_node,
			calls_special_features, pre_inlined_code, inlined_byte_code
		end

feature -- Status

	is_built_in: BOOLEAN is True
			-- Is the current binary operator a built-in one ?

	is_commutative: BOOLEAN is True
			-- Operation is commutative.

feature

	set_register: ANY is do end;

	register: ANY is do end;

	type: TYPE_I is
			-- Expression type is boolean
		do
			Result := Boolean_c_type;
		end;

	generate_boolean_constant is
		deferred
		end;

	generate_equal is
			-- Generate equality if one side at least is an expanded
		do
			buffer.put_string ("RTEQ(");
			generate_equal_end;
		end;

	generate_equal_end is
			-- Generate last portion of equality.
		do
			if left_register = Void then
				left.print_register;
			else
				left_register.print_register;
			end;
			buffer.put_string (gc_comma);
			if right_register = Void then
				right.print_register;
			else
				right_register.print_register;
			end;
			buffer.put_character (')');
		end;

	generate_bit_equal is
			-- Generate equality if one side at least is a bit.
		do
			buffer.put_string ("RTEB(");
			generate_equal_end
		end;

	right_register: REGISTRABLE is
			-- Where metamorphosed right value is kept
		do
		end;

	set_right_register (r: REGISTRABLE) is
			-- Assign `r' to `right_register'
		do
		end;

	get_left_register is
			-- Get register for left expression
		local
			tmp_register: REGISTER;
		do
			if left_register = Void then
				create tmp_register.make (Reference_c_type);
				set_left_register (tmp_register);
			end;
		end;

	get_right_register is
			-- Get register for right expression
		local
			tmp_register: REGISTER;
		do
			if right_register = Void then
				create tmp_register.make (Reference_c_type);
				set_right_register (tmp_register);
			end;
		end;

	analyze is
			-- Analyze expression
		local
			left_type: TYPE_I;
			right_type: TYPE_I;
		do
			left_type := context.real_type (left.type);
			right_type := context.real_type (right.type);
			left.analyze;
			right.analyze;
			if (left_type.is_basic and not (right_type.is_none or
				right_type.is_basic)) or (right_type.is_basic and not
				(left_type.is_none or left_type.is_basic))
			then
				if left_type.is_basic then
					get_left_register;
				else
					get_right_register;
				end;
			end;
		end;

	unanalyze is
			-- Undo the analysis
		local
			void_register: REGISTER;
		do
			Precursor {BINARY_B}
			set_left_register (void_register);
			set_right_register (void_register);
		end;

	free_register is
			-- Free registers used
		do
			Precursor {BINARY_B}
			if left_register /= Void then
				left_register.free_register;
			end;
			if right_register /= Void then
				right_register.free_register;
			end;
		end;

	generate is
			-- Generate expression
		local
			basic_i: BASIC_I;
			buf: GENERATION_BUFFER
		do
			left.generate;
			right.generate;
			buf := buffer
			if left_register /= Void then
				basic_i ?= context.real_type (left.type);
				basic_i.metamorphose
					(left_register, left, buf, context.workbench_mode);
				buf.put_character (';');
				buf.put_new_line;
			end;
			if right_register /= Void then
				basic_i ?= context.real_type (right.type);
				basic_i.metamorphose
					(right_register, right, buf, context.workbench_mode);
				buf.put_character (';');
				buf.put_new_line;
			end;
		end;

	print_register is
			-- Print expression value
		local
			left_type: TYPE_I;
			right_type: TYPE_I;
			buf: GENERATION_BUFFER
		do
			left_type := context.real_type (left.type);
			right_type := context.real_type (right.type);

			if
				(left_type.is_none and right_type.is_basic) or
				(left_type.is_basic and right_type.is_none)
			then
					-- Simple type can never be Void
				generate_boolean_constant;
			elseif left_type.is_true_expanded or right_type.is_true_expanded or
				left_register /= Void or right_register /= Void
			then
				generate_equal;
			elseif left_type.is_bit or right_type.is_bit then
				generate_bit_equal
			else
				buf := buffer
				buf.put_string ("(EIF_BOOLEAN)(")
				if left_register = Void then
					left.print_register;
				else
					left_register.print_register;
				end;
				generate_operator;
				if right_register = Void then
					right.print_register;
				else
					right_register.print_register;
				end;
				buf.put_character (')')
			end;
		end;

feature -- IL code generation

	generate_il is
			-- Generate byte code for equality test
		local
			left_type: TYPE_I
			right_type: TYPE_I
			comparison_type: TYPE_I
			continue_label: IL_LABEL
			end_label: IL_LABEL
		do
			left_type := context.real_type (left.type)
			right_type := context.real_type (right.type)

			if
				(left_type.is_none and right_type.is_expanded) or
				(left_type.is_expanded and right_type.is_none)
			then
					-- Simple type can never be Void, so we simply evaluate
					-- expressions and then remove them from the stack to insert
					-- the expected value
				left.generate_il
				right.generate_il
				il_generator.pop
				il_generator.pop
				generate_il_boolean_constant
			else
				if
					(left_type.is_expanded or else right_type.is_expanded) and then
					not (left_type.is_basic and then right_type.is_basic)
				then
						-- Object (value) equality.

						-- Select reference type to which expanded types will be converted
						-- for comparison that expects arguments of type System.Object.
					if left_type.is_expanded then
						comparison_type := right_type
						if comparison_type.is_expanded then
								-- Both type are expanded. If either of them is external
								-- but not basic, the comparison type is System.Object.
								-- Otherwise it is ANY.
							if
								left_type.is_external and then not left_type.is_basic or else
								right_type.is_external and then not right_type.is_basic
							then
								create {CL_TYPE_I} comparison_type.make (system.system_object_id)
							else
								create {CL_TYPE_I} comparison_type.make (system.any_id)
							end
						end
					else
						comparison_type := left_type
					end

						-- Generate left operand.
					left.generate_il_for_type (comparison_type)
					if left_type.is_reference then
							-- Check for voidness.
						continue_label := il_generator.create_label
						end_label := il_generator.create_label
						il_generator.duplicate_top
						il_generator.branch_on_true (continue_label)
						il_generator.pop
						il_generator.put_boolean_constant (false)
						il_generator.branch_to (end_label)
						il_generator.mark_label (continue_label)
					end

						-- Generate right operand.
					right.generate_il_for_type (comparison_type)
					if right_type.is_reference then
							-- Check for voidness.
						continue_label := il_generator.create_label
						end_label := il_generator.create_label
						il_generator.duplicate_top
						il_generator.branch_on_true (continue_label)
							-- Remove left operand as well.
						il_generator.pop
						il_generator.pop
						il_generator.put_boolean_constant (false)
						il_generator.branch_to (end_label)
						il_generator.mark_label (continue_label)
					end

						-- Call "is_equal".
					il_generator.generate_object_equality_test
						-- Negate result if required.
					generate_il_modifier_opcode

						-- Mark end of equality expression (if required).
					if end_label /= Void then
						il_generator.mark_label (end_label)
					end
				else
						-- Reference or basic type equality.
					generate_converted_standard_il
				end
			end
		end

	generate_il_boolean_constant is
			-- Put `True' or `False' on stack depending if we generate
			-- an equality or an inequality operator.
		deferred
		end

	generate_il_modifier_opcode is
			-- Generate a `not' opcode in case of BIN_NE_B
		do
			-- Do nothing by default.
		end

feature -- Array optimization

	is_unsafe: BOOLEAN is
		do
			Result := right.is_unsafe or else
				left.is_unsafe
		end

	optimized_byte_node: EXPR_B is
		do
			Result := Current;
			left := left.optimized_byte_node;
			right := right.optimized_byte_node
		end

	calls_special_features (array_desc: INTEGER): BOOLEAN is
		do
			Result := left.calls_special_features (array_desc)
				or else right.calls_special_features (array_desc)
		end

feature -- Inlining

	pre_inlined_code: like Current is
		do
			Result := Current;
			left := left.pre_inlined_code
			right := right.pre_inlined_code
		end

	inlined_byte_code: like Current is
		do
			Result := Current
			left := left.inlined_byte_code
			right := right.inlined_byte_code
		end

end
