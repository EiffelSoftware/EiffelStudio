class TUPLE_AS_B

inherit

	TUPLE_AS
		redefine
			expressions
		end

	ATOMIC_AS_B
		redefine
			type_check, byte_node, 
			fill_calls_list, replicate
		end

feature -- Attributes

	expressions: EIFFEL_LIST_B [EXPR_AS_B]
			-- Expression list symbolizing the manifest tuple

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
				!!generics.make (1, nb)
			until
				i < 1
			loop
				generics.put (context.item, i)
				context.pop (1)
				i := i - 1
			end
				-- Update type stack
			!!tuple_type
			tuple_type.set_generics (generics)
			tuple_type.set_base_class_id (System.tuple_id)

			context.replace (tuple_type)
				-- Update the tuple type stack
			tuple_line.insert (tuple_type)
		end

	byte_node: TUPLE_CONST_B is
			-- Byte code for a manifest tuple
		do
			!!Result
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

end -- class TUPLE_AS_B
