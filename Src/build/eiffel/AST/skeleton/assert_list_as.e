class ASSERT_LIST_AS

inherit

	AST_EIFFEL
		redefine
			simple_format
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

feature -- Incrementality

	reset is
		do
			if assertions /= Void then
				assertions.start
			end;
		end;

feature -- simple_Format

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text
		do
			if assertions /= void then
				ctxt.begin;
				ctxt.next_line;
				put_clause_keywords (ctxt);
				ctxt.indent_one_more; 
				ctxt.next_line;
				ctxt.set_separator (ti_Semi_colon);
				ctxt.new_line_between_tokens;
				ctxt.continue_on_failure;
				format_assertions (ctxt);
				if ctxt.last_was_printed then
					ctxt.set_first_assertion (false);
					ctxt.commit;
				end;
			end 			
		end;

	format_assertions (ctxt: FORMAT_CONTEXT) is
		local
			i, l_count: INTEGER;
			not_first: BOOLEAN
		do
			from
				ctxt.begin;
				i := 1;
				l_count := assertions.count;
			until
				i > l_count 
			loop
				ctxt.begin;
				if not_first then
					ctxt.put_separator;
				end;
				ctxt.new_expression;
				assertions.i_th(i).simple_format(ctxt);
				if ctxt.last_was_printed then
					not_first := True
					ctxt.commit;
				end;
				i := i + 1
			end;
			if not_first then
				ctxt.indent_one_less;
				ctxt.commit
			end
		end

feature -- Status report

	has_assertion (a: TAGGED_AS): BOOLEAN is
			-- Does current list have assertion `a'?
		local
			cur: CURSOR
		do
			cur := assertions.cursor
	
			from 
				assertions.start
			until
				assertions.after or else Result
			loop
				Result := assertions.item.is_equiv (a)
				assertions.forth
			end

			assertions.go_to (cur)
		end;

feature {ASSERT_LIST_AS, MERGE_INFO, REQUIRE_MERGER, ENSURE_MERGER} -- Replication

	set_assertions (l: like assertions) is
		do
			assertions := l
		end;
	
feature {NONE}
	
	clause_name (ctxt: FORMAT_CONTEXT): STRING is
			-- name of the assertion: require, require else, ensure, 
			-- ensure then, invariant
		do
		end;

	put_clause_keywords (ctxt: FORMAT_CONTEXT) is
			-- Append the assertion keywords ("require", "require else",
			-- "ensure", "ensure then" or "invariant").
		do
		end;

end
