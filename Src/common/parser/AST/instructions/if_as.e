indexing

	description: 
		"AST representation of a conditional instruction";
	date: "$Date$";
	revision: "$Revision$"

class IF_AS

inherit
	
	INSTRUCTION_AS
		redefine
			number_of_stop_points
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			condition ?= yacc_arg (0);
			compound ?= yacc_arg (1);
			elsif_list ?= yacc_arg (2);
			else_part ?= yacc_arg (3);
			start_position := yacc_position;
			line_number    := yacc_line_number
		ensure then
			condition_exists: condition /= Void;
		end;

feature -- Properties

	condition: EXPR_AS;
			-- Conditional expression

	compound: EIFFEL_LIST [INSTRUCTION_AS];
			-- Compound

	elsif_list: EIFFEL_LIST [ELSIF_AS];
			-- Elsif list

	else_part: EIFFEL_LIST [INSTRUCTION_AS];
			-- Else part

feature -- Access

	number_of_stop_points: INTEGER is
			-- Number of stop points for AST
		do
			Result := Result + 1;
			if compound /= Void then
				Result := Result + compound.number_of_stop_points;
			end;
			Result := Result + 1;
			if elsif_list /= Void then
				Result := Result + elsif_list.number_of_stop_points;
			end;
			if else_part /= Void then
				Result := Result + else_part.number_of_stop_points;
				Result := Result + 1;
			end;
		end

feature -- Comparison 

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (compound, other.compound) and then
				equivalent (condition, other.condition) and then
				equivalent (else_part, other.else_part) and then
				equivalent (elsif_list, other.elsif_list)
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text
		do
			ctxt.put_breakable;
			ctxt.put_text_item (ti_If_keyword);
			ctxt.put_space;
			ctxt.new_expression;
			ctxt.format_ast (condition);
			ctxt.put_space;
			ctxt.put_text_item_without_tabs (ti_Then_keyword);
			if compound /= Void then
				ctxt.indent;
				ctxt.new_line;
				ctxt.set_separator (ti_Semi_colon);
				ctxt.set_new_line_between_tokens;
				ctxt.format_ast (compound);
				ctxt.exdent;
			end;
			ctxt.new_line;
			ctxt.put_breakable 
			if elsif_list /= void then
				ctxt.set_separator (ti_Empty);
				ctxt.set_no_new_line_between_tokens;
				ctxt.format_ast (elsif_list);
				ctxt.set_separator (ti_Semi_colon);
			end;
			if else_part /= void then
				ctxt.put_text_item (ti_Else_keyword);
				ctxt.indent;
				ctxt.new_line;
				ctxt.set_new_line_between_tokens;
				ctxt.format_ast (else_part);
				ctxt.exdent;
				ctxt.new_line;
				ctxt.put_breakable 
			end;
			ctxt.put_text_item (ti_End_keyword);
		end;
		 			   
feature {IF_AS} -- Replication

	set_condition (c: like condition) is
			-- Set `condition' to `c'.
		require
			valid_arg: c /= Void
		do
			condition := c
		end;

	set_compound (c: like compound) is
			-- Set `compound' to `c'.
		do
			compound := c
		end;

	set_elsif_list (e: like elsif_list) is
			-- Set `elsif_list' to `e'.
		do
			elsif_list := e
		end;

	set_else_part (e: like else_part) is
			-- Set `else_part' to `e'.
		do
			else_part := e
		end;

end -- class IF_AS
