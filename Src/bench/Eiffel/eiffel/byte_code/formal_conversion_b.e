indexing
	description: "Conversion if needed of an expanded to its associated reference type %
		%in assignment of a formal to a type whose formal type's constraint conforms."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FORMAL_CONVERSION_B

inherit
	EXPR_B
		redefine
			generate_il, analyze, unanalyze, register,
			set_register, print_register, generate, enlarged,
			make_byte_code, pre_inlined_code
		end

create
	make
	
feature {NONE} -- Initialization

	make (an_expr: EXPR_B; a_type: like type; a_is_boxing: BOOLEAN) is
			-- New BOX_B instance which converts value of `an_expr' into
			-- a box version of `a_type'.
		require
			an_expr_not_void: an_expr /= Void
			a_type_not_void: a_type /= Void
		do
			expr := an_expr
			type := a_type
			is_boxing := a_is_boxing
		ensure
			expr_set: expr = an_expr
			type_set: type = a_type
			is_boxing_set: is_boxing = a_is_boxing
		end
		
feature -- Access

	expr: EXPR_B
			-- Associated expression whose result is boxed

	type: TYPE_I
			-- Type to which expression should be converted if needed
			
	is_boxing: BOOLEAN
			-- Does conversion if needed requires boxing?

feature -- Status report

	used (r: REGISTRABLE): BOOLEAN is
			-- Is register `r' used in local or forthcomming dot calls ?
		do
			Result := expr.used (r)
		ensure then
			not_used: not Result
		end

feature -- IL code generation

	generate_il is
			-- Generate IL code for Void value.
		local
			l_type: TYPE_I
			l_expr_type: TYPE_I
		do
				-- Generate expression
			expr.generate_il

				-- Check if conversion expanded -> reference is needed in
				-- case we assign an expression whose type is a formal generic
				-- parameter of the current class to a reference type whose
				-- formal's constraint conforms to.
			l_type := context.real_type (type)
			l_expr_type := context.real_type (expr.type)

			if is_conversion_needed (l_expr_type, l_type) then
				if is_boxing then
					il_generator.generate_metamorphose (l_expr_type)
				else
						-- FIXME: We only handle metamorphose of basic types here.
					if l_expr_type.is_basic then
						generate_il_eiffel_metamorphose (l_expr_type)
					else
					end
				end
			end
		end
		
feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for expression `expr'.
		local
			l_type, l_expr_type: TYPE_I
		do
			expr.make_byte_code (ba)
			
			l_type := context.real_type (type)
			l_expr_type := context.real_type (expr.type)
			if is_conversion_needed (l_expr_type, l_type) then
				if l_expr_type.is_basic then
					ba.append (bc_metamorphose)
				else
					ba.append (bc_clone)
				end
			end
		end

feature -- C code generation

	register: REGISTRABLE
			-- Register used to store metamorphosed value

	set_register (r: REGISTRABLE) is
			-- Assign `r' to `register'
		do
			register := r
		end

	analyze is
			-- Analyze expression
		do
			expr.analyze
			if
				is_conversion_needed (context.real_type (expr.type),
					context.real_type (type))
			then
				get_register
			end
		end
	
	unanalyze is
			-- Undo the analysis of the expression
		do
			expr.unanalyze
			register := Void
		end

	enlarged: like Current is
			-- Enlarge current
		do
			expr := expr.enlarged
			Result := Current
		end
		
	generate is
			-- Generate expression
		local
			l_type, l_expr_type: TYPE_I
			basic_i: BASIC_I
			buf: GENERATION_BUFFER
		do
			expr.generate

			l_type := context.real_type (type)
			l_expr_type := context.real_type (expr.type)
			if is_conversion_needed (l_expr_type, l_type) then
					-- Conversion is needed.
				buf := buffer
				if l_expr_type.is_true_expanded then
						-- Expanded objects are cloned
					register.print_register
					buf.put_string (" = ")
					buf.put_string ("RTCL(")
					expr.print_register
					buf.put_character(')')
				else
						-- Simple type objects are metamorphosed
					basic_i ?= l_expr_type		-- Cannot fail
					basic_i.metamorphose
						(register, expr, buf, context.workbench_mode)
				end
				buf.put_character(';')
				buf.put_new_line
			end
		end
		
	print_register is
			-- Print expression value
		do
			if
				is_conversion_needed (context.real_type (expr.type),
					context.real_type (type))
			then
				register.print_register
			else
				expr.print_register
			end
		end

feature -- Inlining

	pre_inlined_code: FORMAL_CONVERSION_B is
			-- Modified byte code for inlining.
		do
			create Result.make (expr.pre_inlined_code, context.real_type (type), is_boxing)
		end

feature {NONE} -- Convenience

	is_conversion_needed (a_source, a_target: TYPE_I): BOOLEAN is
			-- Is conversion needed from `a_source' to `a_target'?
		require
			a_source_not_void: a_source /= Void
			a_target_not_void: a_target /= Void
		do
			Result := a_source.is_expanded and a_target.is_reference
		end

invariant
	expr_not_void: expr /= Void
	type_not_void: type /= Void

end -- class FORMAL_CONVERSION_B
