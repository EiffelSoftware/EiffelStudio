class ASSERT_LIST_AS

inherit

	AST_EIFFEL
		redefine
			type_check, byte_node, format,
			fill_calls_list, replicate
		end

feature -- Attributes

	assertions: EIFFEL_LIST [TAGGED_AS];
			-- Assertion list

feature -- Initialization

	set is
			-- Yacc initialization
		do
			assertions ?= yacc_arg (0);
		end

feature -- Type check, byte code, dead code removal and formatter

	type_check is
			-- Type check assertion list
		do
			if assertions /= Void then
				assertions.type_check;
			end;
		end;

	byte_node: BYTE_LIST [BYTE_NODE] is
			-- Byte node associated to the assertion list
		do
			if assertions /= Void then
				Result := assertions.byte_node;
			end;
		end;

	format(ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text
		do
			ctxt.begin;
			if assertions /= void then
				ctxt.put_keyword (clause_name (ctxt));
				ctxt.indent_one_more; 
				ctxt.next_line;
				ctxt.set_separator (";");
				ctxt.new_line_between_tokens;
				ctxt.continue_on_failure;
				assertions.format (ctxt);
				if ctxt.last_was_printed then
					ctxt.set_first_assertion (false);
					ctxt.commit;
				else
					ctxt.rollback;
				end;
			else
				ctxt.rollback;
			end 			
		end;

feature	-- Replication

	fill_calls_list (l: CALLS_LIST) is
		do
			if assertions /= void then
				assertions.fill_calls_list (l)
			end
		end;

	replicate (ctxt: REP_CONTEXT): like Current is 
		do
			Result := twin;
			if assertions /= void then
				Result.set_assertions (assertions.replicate (ctxt));
			end;
		end;


feature {ASSERT_LIST_AS} -- Replication

	set_assertions (l: like assertions) is
		do
			assertions := l
		end;
	
feature {}
	
	clause_name (ctxt: FORMAT_CONTEXT): STRING is
			-- name of the assertion: require, require else, ensure, 
			-- ensure then, invariant
		do
		end;


end
