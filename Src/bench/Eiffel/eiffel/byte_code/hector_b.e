-- Byte code for an hector operator

class HECTOR_B 

inherit

	UNARY_B
		redefine
			expr, enlarged, is_hector, type, make_byte_code,
			calls_special_features, is_unsafe, optimized_byte_node,
			pre_inlined_code, inlined_byte_code,
			analyze, print_register,
			generate, generate_operator
		end

creation

	make

feature 

	expr: ACCESS_B;

	type: TYPE_I is
			-- Expression's type
		once
			!POINTER_I!Result
		end;

	make (a: ACCESS_B) is
			-- Initialization
		require
			good_argument: a /= Void
		do
			expr := a;
		end;

	enlarged: like Current is
			-- Enlarge the expression
		do
			expr := expr.enlarged;
			Result := Current;
		end;

	is_hector: BOOLEAN is true;
			-- The expression is an hector one.

	analyze is
			-- Analyze expression
		do
			context.init_propagation;
			expr.propagate (No_register);
			expr.analyze;
			if expr.is_result and then expr.type.is_basic then
				context.mark_result_used;
			end
		end

feature -- Byte code generation

	operator_constant: CHARACTER is
			-- Byte code constant associated to current binary
            -- operation
		do
		ensure then
			False
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for an unprotected external call argument
		do
			if expr.type.is_basic then
					-- Getting the address of a basic type can be done
					-- only once all the expressions have been evaluated
				ba.append (Bc_reserve)
			else
				expr.make_byte_code (ba);
				if expr.type.is_reference then
					ba.append (Bc_ref_to_ptr);
				end;
			end
		end;

	make_protected_byte_code (ba: BYTE_ARRAY; pos: INTEGER) is
			-- Generate byte code for an unprotected external call argument
		do
			if expr.type.is_basic then
				ba.append (Bc_object_addr);
				ba.append_uint32_integer (pos);
				expr.make_byte_code (ba);
			end
		end

	generate_operator is
			-- Generate the operator
		do
			if expr.type.is_basic then
				generated_file.putstring ("(char *)&");
			end
		end

	print_register is
			-- Print expression value
		do
			if expr.type.is_basic and not expr.type.is_bit then
				generated_file.putstring ("(char *)&(");
				if expr.is_attribute then
					expr.generate_access
				else
					expr.print_register;
				end
				generated_file.putchar (')');
			else
				expr.print_register;
			end
		end

	generate is
			-- Generate expression
		do
			if
				expr.type.is_basic
			and
				not expr.type.is_bit
			and then
				expr.is_attribute
			then
					-- We don't need to do anything now,
					-- `generate_parameters_list' from EXTERNAL_B(L/W)
					-- will generate the access on the attribute
			else
				expr.generate;
			end
		end;

feature -- Array optimization

	calls_special_features (array_desc: INTEGER): BOOLEAN is
		do
		end

	is_unsafe: BOOLEAN is
		do
		end

	optimized_byte_node: like Current is
		do
			Result := Current
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
