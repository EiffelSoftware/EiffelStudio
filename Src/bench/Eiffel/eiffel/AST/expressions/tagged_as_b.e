indexing

	description:
		"Abstract description of a tagged expression. %
		%Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class TAGGED_AS_B

inherit

	TAGGED_AS
		redefine
			expr, tag
		end;

	EXPR_AS_B
		redefine
			type_check, byte_node, format,
			fill_calls_list, replicate
		end

feature -- Attributes

	tag: ID_AS_B;
			-- Expression tag

	expr: EXPR_AS_B;
			-- Expression

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check on the expression
		local
			current_context: TYPE_A;
			vwbe3: VWBE3;
		do
			Error_handler.set_error_position (start_position);
			expr.type_check;
				-- Check if the type of the expression is boolean
			current_context := context.item;
			if not current_context.is_boolean then
				!!vwbe3;
				context.init_error (vwbe3);
				vwbe3.set_type (current_context);
				Error_handler.insert_error (vwbe3);
			end;
				
				-- Update the type stack
			context.pop (1);
		end;

	byte_node: ASSERT_B is
			-- Associated byte code
		do
			!!Result;
			Result.set_tag (tag);
			Result.set_expr (expr.byte_node);
		end;

	format (ctxt: FORMAT_CONTEXT_B) is
			-- Reconstitute text.
		do
			ctxt.begin;
			simple_format (ctxt);
			if ctxt.last_was_printed then
				ctxt.commit;
			else
				ctxt.rollback;
			end;
		end;

feature	-- Replication

	fill_calls_list (l: CALLS_LIST) is
			-- find calls to Current
		local
			new_list: like l;
		do
			!!new_list.make;
			expr.fill_calls_list (new_list);
			l.merge (new_list)
		end;

	replicate (ctxt: REP_CONTEXT): like Current is
			-- adapt to replication
		do
			Result := clone (Current);
			Result.set_expr (expr.replicate (ctxt))
		end;

feature -- Case Storage

	storage_info (ctxt: FORMAT_CONTEXT): S_TAG_DATA is
		require
			valid_context: ctxt /= Void;
			empty_text: ctxt.text.empty
		local
			txt: STRING
		do
			expr.simple_format (ctxt);
			if tag = Void then
				!! Result.make (Void, ctxt.text.image);
			else
				!! Result.make (tag.string_value, ctxt.text.image);
			end;
			ctxt.text.wipe_out;
		end;
	
end -- class TAGGED_AS_B
