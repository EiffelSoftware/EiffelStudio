-- Abstract description of a tagged expression

class TAGGED_AS

inherit

	EXPR_AS
		redefine
			type_check, byte_node, format,
			fill_calls_list, replicate
		end

feature -- Attributes

	tag: ID_AS;
			-- Expression tag

	expr: EXPR_AS;
			-- Expression

feature -- Initialization

	set is
			-- Yacc initialization
		do
			tag ?= yacc_arg (0);
			expr ?= yacc_arg (1);
		ensure then
			expr_exists: expr /= Void;
		end;

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check on the expression
		local
			current_context: TYPE_A;
			vwbe3: VWBE3;
		do
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

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.begin;
			if tag /= void then
				ctxt.put_string(tag);
				ctxt.put_text_item (ti_Colon);
				ctxt.put_space
			end;
			ctxt.new_expression;
			expr.format (ctxt);
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

feature {TAGGED_AS}	-- Replication

	set_expr (e: like expr) is
		require
			valid_arg: e /= Void
		do
			expr := e;
		end

feature -- Case Storage

	storage_info (ctxt: FORMAT_CONTEXT): S_ASSERTION_DATA is
		require
			valid_context: ctxt /= Void;
			empty_text: ctxt.text.empty
		local
			txt: STRING
		do
			expr.format (ctxt);
			if tag = Void then
				!! Result.make (Void, ctxt.text.image);
			else
				!! Result.make (tag.string_value, ctxt.text.image);
			end;
			ctxt.text.wipe_out;
		end;
	
end
