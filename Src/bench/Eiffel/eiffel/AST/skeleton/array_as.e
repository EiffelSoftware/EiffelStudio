class ARRAY_AS

inherit
	ATOMIC_AS
		redefine
			type_check, byte_node, fill_calls_list,
			replicate, is_equivalent
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
				
					-- Take last element in manifest array and let's suppose
					-- it is the lowest type.
				lowest_type := context.item
			until
				i < 1
			loop
					-- If ANY is the common ancestor, there is no need to search
					-- for one, we simply pop the remaining types.
				if not done then
						-- Let's try to find the type to which everyone conforms to.
						-- If not found it will be ANY.
					element_type := context.item
					if lowest_type.conform_to (element_type) then
						lowest_type := element_type
					elseif element_type.conform_to (lowest_type) then
					else
						done := True
						create cl_type_a
						cl_type_a.set_base_class_id (System.any_id)
						lowest_type := cl_type_a
					end
				end
				context.pop (1)
				i := i - 1
			end

				-- Create valid ARRAY type
			create generics.make (1, 1)
			generics.put (lowest_type, 1)
			create array_type.make (generics)
			array_type.set_base_class_id (System.array_id)

				-- Update type stack
			context.replace (array_type)
				-- Update array-line stack
			context.array_line.insert (array_type)
		end

	byte_node: ARRAY_CONST_B is
			-- Byte code for a manifest array
		local
			array_line: LINE [GEN_TYPE_A]
		do
			create Result
			Result.set_expressions (expressions.byte_node)
			
			array_line := context.array_line
			Result.set_type (array_line.item.type_i)
			
				-- Update the array-line stack
			array_line.forth
		end

feature	-- Replication

	fill_calls_list (l: CALLS_LIST) is
		do
			expressions.fill_calls_list (l)
		end

	replicate (ctxt: REP_CONTEXT): like Current is
		do
			Result := clone (Current)
			Result.set_expressions (expressions.replicate (ctxt))
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

end -- class ARRAY_AS
