-- Abstract description of a check clause

class CHECK_AS

inherit

	INSTRUCTION_AS
		redefine
			type_check, byte_node, format,
			fill_calls_list, replicate
		end

feature -- Attributes

	check_list: EIFFEL_LIST [TAGGED_AS];
			-- List of tagged boolean expression

feature -- Initialization

	set is
			-- Yacc initialization
		do
			check_list ?= yacc_arg (0);
		end;

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check on check clause
		do
			if check_list /= Void then
				check_list.type_check;
			end;
		end;

	byte_node: CHECK_B is
			-- Associated byte code
		do
			!!Result;
			if check_list /= Void then
				Result.set_check_list (check_list.byte_node);
			end;
		end;

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute Text
		do
			ctxt.begin;
			ctxt.put_breakable;
			ctxt.put_text_item (ti_check_keyword);
			if check_list /= void then
				ctxt.indent_one_more;
				ctxt.next_line;
				check_list.format (ctxt);
				ctxt.indent_one_less;
				ctxt.next_line;
			end;
			ctxt.put_text_item (ti_End_keyword);
			ctxt.commit;
		end;

feature -- Replication

	fill_calls_list (l: CALLS_LIST) is
			-- Find calls to Current
		do
			if check_list /= void then
				check_list.fill_calls_list (l);
			end
		end;

	replicate (ctxt: REP_CONTEXT): like Current is
			-- Adapt to replication
		do
			Result := clone (Current);
			if check_list /= void then
				Result.set_check_list(
					check_list.replicate (ctxt));
			end
		end;

feature {CHECK_AS}	-- Replication
	
	set_check_list (c: like check_list) is
		do
			check_list := c
		end;

end
