class ARRAY_AS

inherit

	ATOMIC_AS
		redefine
			type_check, byte_node, format
		end

feature -- Attributes

	expressions: EIFFEL_LIST [EXPR_AS];
			-- Expression list symbolizing the manifest array

feature -- Initialization

	set is
			-- Yacc initialization
		do
			expressions ?= yacc_arg (0);
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
			context.change_item (multi_type);
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
			ctxt.put_special ("<<");
			ctxt.set_separator (", ");
			ctxt.separator_is_special;
			ctxt.abort_on_failure;
			ctxt.no_new_line_between_tokens;
			expressions.format (ctxt);
			if ctxt.last_was_printed then
				ctxt.put_special(">>");
				ctxt.commit
			else
				ctxt.rollback;
			end;
		end;	

			
			
end
