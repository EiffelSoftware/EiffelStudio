-- Abstract description of a conditional instruction

class IF_AS

inherit
	
	INSTRUCTION_AS
		redefine
			type_check, byte_node,
			find_breakable, format,
			fill_calls_list, replicate
		end

feature -- Attributes

	condition: EXPR_AS;
			-- Conditional expression

	compound: EIFFEL_LIST [INSTRUCTION_AS];
			-- Compound

	elsif_list: EIFFEL_LIST [ELSIF_AS];
			-- Elsif list

	else_part: EIFFEL_LIST [INSTRUCTION_AS];
			-- Else part

feature -- Initialization

	set is
			-- Yacc initialization
		do
			condition ?= yacc_arg (0);
			compound ?= yacc_arg (1);
			elsif_list ?= yacc_arg (2);
			else_part ?= yacc_arg (3);
		ensure then
			condition_exists: condition /= Void;
		end;

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check on conditional instruction
		local
			current_context: TYPE_A;
			vwbe1: VWBE1;
		do
				-- Type check the test
			condition.type_check;
	
				-- Check conformance to boolean
			current_context := context.item;
			if 	not current_context.is_boolean then
				!!vwbe1;
				context.init_error (vwbe1);
				vwbe1.set_type (current_context);
				Error_handler.insert_error (vwbe1);
			end;

				-- Update the type stack
			context.pop (1);

				-- Type check on compound
			if compound /= Void then
				compound.type_check;
			end;
				-- Type check on alternaltives compounds
			if elsif_list /= Void then
				elsif_list.type_check;
			end;
				-- Type check on default compound
			if else_part /= Void then
				else_part.type_check;
			end;

		end;

	byte_node: IF_B is
			-- Associated byte node
		do
			!!Result;
			Result.set_condition (condition.byte_node);
			if compound /= Void then
				Result.set_compound (compound.byte_node);
			end;
			if elsif_list /= Void then
				Result.set_elsif_list (elsif_list.byte_node);
			end;
			if else_part /= Void then
				Result.set_else_part (else_part.byte_node);
			end;
		end;
			
feature -- Debugger

	find_breakable is
			-- Look for breakable instructions
		do
			record_break_node;
			if compound /= Void then
				compound.find_breakable;
			end;
			record_break_node;
			if elsif_list /= Void then
				elsif_list.find_breakable;
			end;
			if else_part /= Void then
				else_part.find_breakable;
				record_break_node;
			end;
		end;

feature -- Formatter
		
	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute	text
		do
			ctxt.begin;
			ctxt.put_breakable;
			ctxt.put_keyword ("if ");
			ctxt.new_expression;
			condition.format (ctxt);
			ctxt.put_keyword (" then");
			if compound /= void then
				ctxt.indent_one_more;
				ctxt.next_line;
				ctxt.set_separator(";");
				ctxt.new_line_between_tokens;
				compound.format (ctxt);
				ctxt.indent_one_less;
			end;
			ctxt.next_line;
			ctxt.put_breakable;
			if elsif_list /= void then	
				ctxt.set_separator(void);
				elsif_list.format (ctxt);
				ctxt.set_separator(";");
				ctxt.next_line;
			end;
			if else_part /= void then
				ctxt.put_keyword ("else");
				ctxt.indent_one_more;
				ctxt.next_line;
				else_part.format (ctxt);
				ctxt.indent_one_less;
				ctxt.next_line;
				ctxt.put_breakable;
			end;
			ctxt.put_keyword ("end");
			ctxt.commit;
		end;

feature	-- Replication

	fill_calls_list (l: CALLS_LIST) is
			-- Find calls to Current
		local
			new_list: like l;
		do
			!!new_list.make;
			condition.fill_calls_list (new_list);
			l.merge (new_list);
			if compound /= void then
				compound.fill_calls_list (l);
			end;
			if elsif_list /= void then
				elsif_list.fill_calls_list (l);
			end;
			if else_part /= void then
				else_part.fill_calls_list (l);
			end;
		end;

	replicate (ctxt: REP_CONTEXT): like Current is
			-- Adapt to replication
		do
			Result := twin;
			Result.set_condition (condition.replicate (ctxt));
			if compound /= void then
				Result.set_compound (
					compound.replicate (ctxt));
			end;
			if elsif_list /= void then
				Result.set_elsif_list (
					elsif_list.replicate (ctxt));
			end;
			if else_part /= void then
				Result.set_else_part (
					else_part.replicate (ctxt));
			end;
		end;


feature {IF_AS}	-- Replication

	set_condition (c: like condition) is
		require
			valid_arg: c /= Void
		do
			condition := c
		end;

	set_compound (c: like compound) is
		do
			compound := c
		end;

	set_elsif_list (e: like elsif_list) is
		do
			elsif_list := e
		end;

	set_else_part (e: like else_part) is
		do
			else_part := e
		end;
end
