-- Abstract description of a multi_branch instruction

class INSPECT_AS

inherit

	INSTRUCTION_AS
		redefine
			type_check, byte_node,
			find_breakable, format,
			fill_calls_list, replicate
		end;
	SHARED_INSPECT

feature -- Attributes

	switch: EXPR_AS;
			-- Expression to inspect

	case_list: EIFFEL_LIST [CASE_AS];
			-- Alternatives

	else_part: EIFFEL_LIST [INSTRUCTION_AS];
			-- Else part

feature -- Initialization

	set is
			-- Yacc alternatives
		do
			switch ?= yacc_arg (0);
			case_list ?= yacc_arg (1);
			else_part ?= yacc_arg (2);
		ensure then
			switch_exists: switch /= Void
		end;

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check a multi-branch instruction
		local
			current_item: TYPE_A;
			vomb1: VOMB1;
		do
			switch.type_check;

				-- Initialization of the multi-branch controler
			Inspect_control.wipe_out;
			Inspect_control.set_node (Current);
			Inspect_control.set_feature_table (context.a_class.feature_table);

				-- Type check if it is an expression conform either to
				-- and integer or to a character
			current_item := context.item;
			if current_item.conform_to (Integer_type) then		
				Inspect_control.set_integer_type;
			elseif	current_item.conform_to (Character_type) then
				Inspect_control.set_character_type;
			else
					-- Error
				!!vomb1;
				context.init_error (vomb1);
				vomb1.set_type (current_item);
				Error_handler.insert_error (vomb1);
					-- Cannot go on here
				Error_handler.raise_error;
			end;

				-- Update type stack
			context.pop (1);

			if case_list /= Void then
				case_list.type_check;
			end;

			if else_part /= Void then
				else_part.type_check;
			end;
		end;

	byte_node: INSPECT_B is
			-- Associated byte code
		do
			!!Result;
			Result.set_switch (switch.byte_node);
			if case_list /= Void then
				Result.set_case_list (case_list.byte_node);
			end;
			if else_part /= Void then
				Result.set_else_part (else_part.byte_node);
			end;
		end;

feature -- Debugger

	find_breakable is
			-- Look for breakable instructions.
		do
			if case_list /= Void then
				case_list.find_breakable;
			end;
			if else_part /= Void then
				else_part.find_breakable;
			end;
			record_break_node
		end;

feature -- Formatter

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.begin;
			ctxt.put_keyword ("inspect");
			ctxt.indent_one_more;
			switch.format (ctxt);
			ctxt.indent_one_less;
			ctxt.next_line;
			if case_list /= void then
				ctxt.set_separator("");
				ctxt.separator_is_normal;
				ctxt.new_line_between_tokens;
				case_list.format (ctxt);
				ctxt.next_line;
			end;
			if else_part /= void then
				ctxt.put_keyword("else");
				ctxt.indent_one_more;
				ctxt.separator_is_special;
				ctxt.set_separator(";");
				ctxt.new_line_between_tokens;
				else_part.format(ctxt);
				ctxt.indent_one_less;
				ctxt.next_line;
			end;
			ctxt.put_keyword("end");
			ctxt.put_breakable;	
			ctxt.commit;
		end;

feature -- Replication

	fill_calls_list (l: CALLS_LIST) is
			-- find calls to Current
		local
			new_list: like l;
		do
			!!new_list.make;
			switch.fill_calls_list (new_list);
			l.merge (new_list);
			if case_list /= void then
				case_list.fill_calls_list (l);
			end;
			if else_part /= void then
				else_part.fill_calls_list (l);
			end;
		end;

	replicate (ctxt: REP_CONTEXT): like Current is
			-- Adapt to replication
		do
			Result := twin;
			Result.set_switch (switch.replicate (ctxt));
			if case_list /= void then
				Result.set_case_list (
					case_list.replicate (ctxt));
			end;
			if else_part /= void then
				Result.set_else_part (
					else_part.replicate (ctxt));
			end;
		end;

feature {INSPECT_AS} -- Replication

	set_switch (s: like switch) is
		require
			valid_arg: s /= Void
		do
			switch := s
		end;

	set_case_list (c: like case_list) is
		do
			case_list := c
		end;

	set_else_part (e: like else_part) is
		do
			else_part := e
		end;
end
