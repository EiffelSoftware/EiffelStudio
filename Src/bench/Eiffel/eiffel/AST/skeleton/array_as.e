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
			multi_type: MULTI_TYPE_A
		do
			context.begin_expression
				-- Type check expression list
			expressions.type_check
				-- Creation of a multi type
			from
				nb := expressions.count
				i := nb
				!!multi_type.make (nb)
			until
				i < 1
			loop
				multi_type.put (context.item, i)
				context.pop (1)
				i := i - 1
			end
				-- Update type stack
			context.replace (multi_type)
				-- Update the multi type stack
			multi_line.insert (multi_type)
		end

	byte_node: ARRAY_CONST_B is
			-- Byte code for a manifest array
		do
			!!Result
			Result.set_expressions (expressions.byte_node)
			Result.set_type (multi_line.item.type_i)
				-- Update the multi_type stack
			multi_line.forth
		end

	multi_line: LINE [MULTI_TYPE_A] is
			-- Mutli type stack
		once
			Result := context.multi_line
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
			ctxt.put_text_item (ti_L_array)
			ctxt.set_separator (ti_Comma)
			ctxt.set_space_between_tokens
			ctxt.format_ast (expressions)
			ctxt.put_text_item_without_tabs (ti_R_array)
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
