indexing
	description: "Byte code for an hector operator."
	date: "$Date$"
	revision: "$Revision$"

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
	make, make_with_type

feature {NONE} -- Initialization

	make (a: like expr) is
			-- Initialization
		require
			a_not_void: a /= Void
		do
			expr := a
		ensure
			expr_set: expr = a
		end
	
	make_with_type (a: like expr; t: like type) is
			-- Initialization
		require
			a_not_void: a /= Void
			t_not_void: t /= Void
		do
			expr := a
			internal_type := t
		ensure
			expr_set: expr = a
			internal_type_set: internal_type = t
		end

feature -- Access

	is_pointer: BOOLEAN is True
			-- Does Current represent a dollar expression of type POINTER?
			-- Always True in 5.4. In 5.5 it will be only True for converted
			-- expression $x to POINTER. If of type TYPED_POINTER, then it
			-- will be False.
	
	expr: ACCESS_B
			-- Access on which we do `$'.

	type: TYPE_I is
			-- Expression's type
		do
			if is_pointer then
				Result := Pointer_c_type
			else
				Result := internal_type
				if Result = Void then
					create {TYPED_POINTER_I} Result.make_typed (
						System.typed_pointer_class.compiled_class.class_id, expr.type.type_a)
					internal_type := Result
				end
			end
		ensure then
			type_not_void: type /= Void
		end

	enlarged: like Current is
			-- Enlarge the expression
		do
			expr := expr.enlarged
			Result := Current
		end

	is_hector: BOOLEAN is True
			-- The expression is an hector one.

feature -- Settings

	set_is_pointer is
			-- Set `is_pointer' to True.
		do
			 -- FIXME: Manu 09/20/2003: To remove when `is_pointer' is made
			 -- an attribute again. See comment on `is_pointer' for rational.
--			is_pointer := True
		ensure
			is_pointer_set: is_pointer
		end

feature -- Code generation

	analyze is
			-- Analyze expression
		do
			context.init_propagation
			expr.propagate (No_register)
			expr.analyze
			if expr.is_result and then (not is_pointer or else real_type (expr.type).is_basic) then
				context.mark_result_used
			end
		end

feature -- IL code generation

	il_operator_constant: INTEGER is
		do
			check False end
		end

	generate_il is
			-- Generate IL code for unprotected external call argument.
		do
			expr.generate_il_address
		end

feature -- Byte code generation

	operator_constant: CHARACTER is
			-- Byte code constant associated to current binary
			-- operation
		do
		ensure then
			False
		end

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for an unprotected external call argument
		do
			if not is_pointer or else expr.type.is_basic then
					-- Getting the address of a basic type can be done
					-- only once all the expressions have been evaluated
				ba.append (Bc_reserve)
			else
				expr.make_byte_code (ba)
				if expr.type.is_reference then
					ba.append (Bc_ref_to_ptr)
				end
			end
		end

	make_protected_byte_code (ba: BYTE_ARRAY; pos: INTEGER) is
			-- Generate byte code for an unprotected external call argument
		do
			if not is_pointer or else expr.type.is_basic then
				ba.append (Bc_object_addr)
				ba.append_uint32_integer (pos)
				expr.make_byte_code (ba)
			end
		end

	print_register is
			-- Print expression value
		local
			buf: GENERATION_BUFFER
			l_type: TYPE_I
		do
			l_type := real_type (expr.type)
			if not is_pointer or else (l_type.is_basic and not l_type.is_bit) then
				buf := buffer
				buf.putstring ("&(")
				if expr.is_attribute then
					expr.generate_access
				else
					expr.print_register
				end
				buf.putchar (')')
			else
				expr.print_register
			end
		end

	generate is
			-- Generate expression
		do
			if
				expr.is_attribute and then 
				(not is_pointer or else (expr.type.is_basic and not expr.type.is_bit))
			then
					-- We don't need to do anything now,
					-- `generate_parameters_list' from EXTERNAL_B(L/W)
					-- will generate the access on the attribute
			else
				expr.generate
			end
		end

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

feature {NONE} -- Implementation

	internal_type: TYPE_I
			-- Type associated to Current.

invariant
	expr_not_void: expr /= Void

end
