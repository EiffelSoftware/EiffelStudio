class ARRAY_AS

inherit

	ATOMIC_AS
		redefine
			type_check, byte_node, format,
			fill_calls_list, replicate, string_value
		end

feature -- Attributes

	expressions: EIFFEL_LIST [EXPR_AS];
			-- Expression list symbolizing the manifest array

feature -- Initialization

	set is
			-- Yacc initialization
		do
			expressions ?= yacc_arg (0);
			if expressions = Void then
				-- Create empty list
				!!expressions.make (0)
			end
		ensure then
			expressions_exists: expressions /= Void;
		end;

feature -- Type check, byte code, dead code removal and formatter

	type_check is
			-- Type check a manifest array
		local
			i, nb: INTEGER;
			multi_type: MULTI_TYPE_A;
		do
			context.begin_expression;
				-- Type check expression list
			expressions.type_check;
				-- Creation of a multi type
			from
				nb := expressions.count;
				i := nb;
				!!multi_type.make (nb);
			until
				i < 1
			loop
				multi_type.put (context.item, i);
				context.pop (1);
				i := i - 1;
			end;
				-- Update type stack
			context.replace (multi_type);
				-- Update the multi type stack
			multi_line.insert (multi_type);
		end;

	byte_node: ARRAY_CONST_B is
			-- Byte code for a manifest array
		do
			!!Result;
			Result.set_expressions (expressions.byte_node);
			Result.set_type (multi_line.item.type_i);
				-- Update the multi_type stack
			multi_line.forth;
		end;

	multi_line: LINE [MULTI_TYPE_A] is
			-- Mutli type stack
		once
			Result := context.multi_line;
		end;


	format(ctxt : FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.begin;
			ctxt.put_text_item (ti_L_array);
			ctxt.set_separator (ti_Comma);
			ctxt.abort_on_failure;
			ctxt.space_between_tokens;
			expressions.format (ctxt);
			ctxt.put_text_item (ti_R_array);
			ctxt.commit
		end;	

feature	-- Replication

	fill_calls_list (l: CALLS_LIST) is
		do
			expressions.fill_calls_list (l);
		end;

	replicate (ctxt: REP_CONTEXT): like Current is
		do
			Result := clone (Current);
			Result.set_expressions (expressions.replicate (ctxt));
		end;

feature {ARRAY_AS}	-- Replication

	set_expressions (e: like expressions) is
		require
			valid_arg: e /= Void
		do
			expressions := e
		end;

feature -- Case storage

	string_value: STRING is
		do
			Result := "<< >>"
		end;

end
