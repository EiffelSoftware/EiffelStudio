class ARRAY_AS

inherit
	ATOMIC_AS
		redefine
			type_check, byte_node, is_equivalent
		end
		
	SHARED_INSTANTIATOR
		export
			{NONE} all
		end

feature {AST_FACTORY} -- Initialization

	initialize (exp: like expressions) is
			-- Create a new Manifest ARRAY AST node.
		require
			exp_not_void: exp /= Void
		do
			expressions := exp
		ensure
			expressions_set: expressions = exp
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_array_as (Current)
		end

feature -- Attributes

	expressions: EIFFEL_LIST [EXPR_AS]
			-- Expression list symbolizing the manifest array

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (expressions, other.expressions)
		end

feature -- Type check, byte code, dead code removal and formatter

	type_check is
			-- Type check a manifest array
		local
			i, nb: INTEGER
			array_type: GEN_TYPE_A
			multi_type: MULTI_TYPE_A
			generics: ARRAY [TYPE_A]
			lowest_type, element_type: TYPE_A
			cl_type_a: CL_TYPE_A
			done: BOOLEAN
		do
			context.begin_expression
				-- Type check expression list
			expressions.type_check
				-- Creation of a multi type
			from
				nb := expressions.count
				i := nb
				create multi_type.make (nb)
				
					-- Take last element in manifest array and let's suppose
					-- it is the lowest type.
				if nb > 0 then
					lowest_type := context.item
				else
						-- Case of an array with no elements in it.
						-- The type is by default ARRAY [ANY].
					create cl_type_a.make (System.any_id)
					lowest_type := cl_type_a
				end
				create expression_types.make (1, nb)
			until
				i < 1
			loop
				element_type := context.item
				expression_types.put (element_type, i)
				multi_type.put (element_type, i)
					-- If ANY is the common ancestor, there is no need to search
					-- for one, we simply pop the remaining types.
				if not done then
						-- Let's try to find the type to which everyone conforms to.
						-- If not found it will be ANY.
					if lowest_type.conform_to (element_type) then
						lowest_type := element_type
					elseif element_type.conform_to (lowest_type) then
					else
						done := True
						create cl_type_a.make (System.any_id)
						lowest_type := cl_type_a
					end
				end
				context.pop (1)
				i := i - 1
			end

				-- Create valid ARRAY type
			create generics.make (1, 1)
			generics.put (lowest_type, 1)
			create array_type.make (System.array_id, generics)

			multi_type.set_last_type (array_type)

			Instantiator.dispatch (array_type, Context.current_class)

				-- Update type stack
			context.replace (multi_type)
				-- Update array-line stack
			context.array_line.insert (multi_type)
		end

	byte_node: ARRAY_CONST_B is
			-- Byte code for a manifest array
		local
			array_line: LINE [MULTI_TYPE_A]
			l_array_type: GEN_TYPE_A
			l_array_element_type, l_element_type: TYPE_A
			i, nb: INTEGER
			l_expressions: BYTE_LIST [BYTE_NODE]
			l_expr: EXPR_B
		do
			l_expressions := expressions.byte_node
			
			array_line := context.array_line
			l_array_type := array_line.item.last_type
			l_array_element_type := l_array_type.generics.item (1)
			
				-- Update the array-line stack
			array_line.forth
			
				-- Special manipulation of `expressions' to take into account
				-- possible conversions.
			from
				i := 1
				nb := expression_types.count
			until
				i > nb
			loop
				l_element_type := expression_types.item (i)
				if not l_element_type.conform_to (l_array_element_type) then
					if l_element_type.convert_to (system.current_class, l_array_element_type) then
						l_expr ?= l_expressions.i_th (i)
						check
								-- Not Void, because it is actually a list of EXPR_B object.
							l_expr_not_void: l_expr /= Void
						end
						l_expressions.put_i_th (
							context.last_conversion_info.byte_node (l_expr), i)
					end
				end
				i := i + 1
			end

			create Result
			Result.set_expressions (l_expressions)
			Result.set_type (l_array_type.type_i)
			
				-- To save memory.
			expression_types := Void
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt : FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_text_item (ti_l_array)
			ctxt.set_separator (ti_comma)
			ctxt.set_space_between_tokens
			ctxt.format_ast (expressions)
			ctxt.put_text_item_without_tabs (ti_r_array)
		end

	string_value: STRING is ""

feature {ARRAY_AS}	-- Replication

	set_expressions (e: like expressions) is
		require
			valid_arg: e /= Void
		do
			expressions := e
		end

feature {NONE} -- Implementation

	expression_types: ARRAY [TYPE_A]
			-- Type of expressions

end -- class ARRAY_AS
