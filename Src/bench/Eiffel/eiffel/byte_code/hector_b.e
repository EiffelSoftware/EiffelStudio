-- Byte code for an hector operator

class HECTOR_B 

inherit

	UNARY_B
		redefine
			expr, enlarged, is_hector, type, make_byte_code,
			calls_special_features, is_unsafe, optimized_byte_node,
			pre_inlined_code, inlined_byte_code,
			analyze, print_register,
			generate, generate_il, size
		end

create

	make

feature 

	expr: ACCESS_B;

	type: TYPE_I is
			-- Expression's type
		once
			create {POINTER_I} Result
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

	is_hector: BOOLEAN is True;
			-- The expression is an hector one.

	analyze is
			-- Analyze expression
		do
			context.init_propagation;
			expr.propagate (No_register);
			expr.analyze;
			if expr.is_result and then real_type (expr.type).is_basic then
				context.mark_result_used;
			end
		end

feature -- IL code generation

	il_operator_constant: INTEGER is
		do
			check False end
		end

	generate_il is
			-- Generate IL code for unprotected external call argument.
		local
			l_local: LOCAL_B
			l_argument: ARGUMENT_B
			l_type: TYPE_I
			l_local_number: INTEGER
		do
			l_type := context.real_type (expr.type)
			if l_type.is_expanded then
				check
					not_current: not expr.is_current
				end
				if expr.is_predefined  then
					if expr.is_local then
						l_local ?= expr
						il_generator.generate_local_address (l_local.position)
					elseif expr.is_argument then
						l_argument ?= expr
						il_generator.generate_argument_address (l_argument.position)
					else
						check
							expr.is_result
						end
						il_generator.generate_result_address
					end
				else
					expr.generate_il
					if expr.is_attribute then
							-- We generate a read only address operator, i.e. that if
							-- the calls that receives the value write to it, it is not
							-- going to affect the original attribute value.
						context.add_local (l_type)
						l_local_number := context.local_list.count
						il_generator.put_dummy_local_info (l_type, l_local_number)
						il_generator.generate_local_assignment (l_local_number)
						il_generator.generate_local_address (l_local_number)
					end
				end
			else
				expr.generate_il
			end
			il_generator.convert_to_native_int
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

	print_register is
			-- Print expression value
		local
			buf: GENERATION_BUFFER
			l_type: TYPE_I
		do
			l_type := real_type (expr.type)
			if l_type.is_basic and not l_type.is_bit then
				buf := buffer
				buf.putstring ("&(");
				if expr.is_attribute then
					expr.generate_access
				else
					expr.print_register;
				end
				buf.putchar (')');
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
				-- We now return Current even if usually byte code contains an
				-- HECTOR_B node cannot be inlined. This is to make the manual
				-- inlining of `element_address' and `base_address' of SPECIAL
				-- possible.
			Result := Current
		end

	inlined_byte_code: like Current is
		do
			Result := Current
			expr := expr.inlined_byte_code
		end

	size: INTEGER is
		do
				-- We cannot inline a feature that contains an address
				-- computation.
			Result := 101
		end

end
