deferred class BIN_EQUAL_B 

inherit

	BINARY_B
		rename
			register as left_register,
			set_register as set_left_register,
			free_register as old_free_register,
			unanalyze as old_unanalyze
		redefine
			make_byte_code, is_commutative, print_register, type,
			generate, analyze, is_unsafe, optimized_byte_node,
			calls_special_features, pre_inlined_code, inlined_byte_code
		end;

	BINARY_B
		rename
			register as left_register,
			set_register as set_left_register
		redefine
			free_register, unanalyze,
			make_byte_code, is_commutative, print_register, type,
			generate, analyze, is_unsafe, optimized_byte_node,
			calls_special_features, pre_inlined_code, inlined_byte_code
		select
			free_register, unanalyze
		end

feature 

	set_register: ANY is do end;

	register: ANY is do end;

	type: TYPE_I is
			-- Expression type is boolean
		do
			Result := Boolean_c_type;
		end;

	is_commutative: BOOLEAN is true;
			-- Operation is commutative.

	generate_boolean_constant is
		deferred
		end;

	generate_equal is
			-- Generate equality if one side at least is an expanded
		do
			generated_file.putstring ("RTEQ(");
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
			generated_file.putstring (gc_comma);
			if right_register = Void then
				right.print_register;
			else
				right_register.print_register;
			end;
			generated_file.putchar (')');
		end;

	generate_bit_equal is
			-- Generate equality if one side at least is a bit.
		do
			generated_file.putstring ("RTEB(");
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
				!!tmp_register.make (Reference_c_type);
				set_left_register (tmp_register);
			end;
		end;

	get_right_register is
			-- Get register for right expression
		local
			tmp_register: REGISTER;
		do
			if right_register = Void then
				!!tmp_register.make (Reference_c_type);
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
			old_unanalyze;
			set_left_register (void_register);
			set_right_register (void_register);
		end;

	free_register is
			-- Free registers used
		do
			old_free_register;
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
		do
			left.generate;
			right.generate;
			if left_register /= Void then
				basic_i ?= context.real_type (left.type);
				basic_i.metamorphose
					(left_register, left, generated_file, context.workbench_mode);
				generated_file.putchar (';');
				generated_file.new_line;
			end;
			if right_register /= Void then
				basic_i ?= context.real_type (right.type);
				basic_i.metamorphose
					(right_register, right, generated_file, context.workbench_mode);
				generated_file.putchar (';');
				generated_file.new_line;
			end;
		end;

	print_register is
			-- Print expression value
		local
			left_type: TYPE_I;
			right_type: TYPE_I;
		do
			left_type := context.real_type (left.type);
			right_type := context.real_type (right.type);
			
			if
				(left_type.is_none and right_type.is_basic) or
				(left_type.is_basic and right_type.is_none)
			then
					-- Simple type can never be Void
				generate_boolean_constant;
			elseif left_type.is_expanded or right_type.is_expanded or
				left_register /= Void or right_register /= Void
			then
				generate_equal;
			elseif left_type.is_bit or right_type.is_bit then
				generate_bit_equal
			else
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
			end;
		end;

feature -- Byte code generation

	operator_constant: CHARACTER is
			-- Byte code constant associated to current binary
			-- operation
		deferred
		end;

	make_bit_eq_test (ba: BYTE_ARRAY) is
			-- Make byte code for current bit equality
		deferred
		end;

	make_expanded_eq_test (ba: BYTE_ARRAY) is
			-- Make byte code for current expaned equality
		deferred
		end;

	obvious_operator_constant: CHARACTER is 
			-- Byte code operator associated to an obvious false
			-- comparison
		deferred
		end;

	is_built_in: BOOLEAN is
			-- Is the current binary operator a built-in one ?
		do
			Result := True;
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for an equality test
		local
			lt, rt: TYPE_I;
			basic_type: BASIC_I;
			flag: BOOLEAN;
		do
			lt := context.real_type (left.type);
			rt := context.real_type (right.type);

			left.make_byte_code (ba);
			if (lt.is_basic and then rt.is_reference) then
				basic_type ?= lt;
				ba.append (Bc_metamorphose);
				flag := True;
			end;

			right.make_byte_code (ba);
			if (lt.is_reference and then rt.is_basic) then
				basic_type ?= rt;
				ba.append (Bc_metamorphose);
				flag := true;
			end;

			if 	(lt.is_expanded or else rt.is_expanded)
				or else
				flag
			then
					-- Standard equality
				make_expanded_eq_test (ba);
			elseif (lt.is_bit and then rt.is_bit) then
					-- Bit equality
				make_bit_eq_test (ba)	
			elseif	(lt.is_basic and then rt.is_none)
					or else
					(lt.is_none and then rt.is_basic)
			then
					-- A basic type is neither Void
				ba.append (obvious_operator_constant);
			else
				ba.append (operator_constant);
			end;
		end;

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
