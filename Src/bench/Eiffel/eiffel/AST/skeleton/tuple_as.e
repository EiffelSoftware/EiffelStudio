indexing
	description: "AST representation of manifest tuple."
	date: "$Date$"
	revision: "$Revision$"

class TUPLE_AS

inherit
	ATOMIC_AS
		redefine
			type_check, byte_node, 
			fill_calls_list, replicate,
			is_equivalent
		end

feature {AST_FACTORY} -- Initialization

	initialize (exp: like expressions) is
			-- Create a new Manifest TUPLE AST node.
		require
			exp_not_void: exp /= Void
		do
			expressions := exp
		ensure
			expressions_set: expressions = exp
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			expressions ?= yacc_arg (0)
			if expressions = Void then
					-- Create empty list
				!! expressions.make_filled (0)
			end
		ensure then
			expressions_exists: expressions /= Void
		end

feature -- Attributes

	expressions: EIFFEL_LIST [EXPR_AS]
			-- Expression list symbolizing the manifest tuple

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (expressions, other.expressions)
		end

feature -- Type check, byte code, dead code removal and formatter

	type_check is
			-- Type check a manifest tuple
		local
			i, nb: INTEGER
			tuple_type: TUPLE_TYPE_A
			generics : ARRAY [TYPE_A]
		do
			context.begin_expression
				-- Type check expression list
			expressions.type_check
				-- Creation of a tuple type
			from
				nb := expressions.count
				i := nb
				!! generics.make (1, nb)
			until
				i < 1
			loop
				generics.put (context.item, i)
				context.pop (1)
				i := i - 1
			end
				-- Update type stack
			!! tuple_type
			tuple_type.set_base_class_id (System.tuple_id)
			tuple_type.set_generics (generics)

			context.replace (tuple_type)
				-- Update the tuple type stack
			tuple_line.insert (tuple_type)
		end

	byte_node: TUPLE_CONST_B is
			-- Byte code for a manifest tuple
		do
			!! Result
			Result.set_expressions (expressions.byte_node)
			Result.set_type (tuple_line.item.type_i)
				-- Update the tuple_type stack
			tuple_line.forth
		end

	tuple_line: LINE [TUPLE_TYPE_A] is
			-- Tuple type stack
		once
			Result := context.tuple_line
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

feature {TUPLE_AS, ROUTINE_CREATION_AS} 

	set_expressions (e: like expressions) is
		require
			valid_arg: e /= Void
		do
			expressions := e
		end

end -- class TUPLE_AS

