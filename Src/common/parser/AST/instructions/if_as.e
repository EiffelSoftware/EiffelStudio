indexing

	description: 
		"AST representation of a conditional instruction";
	date: "$Date$";
	revision: "$Revision$"

class IF_AS

inherit
	
	INSTRUCTION_AS

feature -- Properties

	condition: EXPR_AS;
			-- Conditional expression

	compound: EIFFEL_LIST [INSTRUCTION_AS];
			-- Compound

	elsif_list: EIFFEL_LIST [ELSIF_AS];
			-- Elsif list

	else_part: EIFFEL_LIST [INSTRUCTION_AS];
			-- Else part

feature {NONE} -- Initialization

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

feature -- Comparison 

	is_equiv (other: INSTRUCTION_AS): BOOLEAN is
			-- Is `other' instruction equivalent with Current?
		local
			if_as: IF_AS
		do
			if_as ?= Other
			if if_as /= Void then
				-- May be equivalent
				Result := equiv (if_as)
			else
				-- NOT equivalent
				Result := False
			end
		end;

	equiv (other: like Current): BOOLEAN is
			-- Is `other' if_as equivalent with Current?
		do
			Result := deep_equal (condition, other.condition)
			if Result then
				-- May be equivalent
				Result := deep_equal (compound, other.compound)
				if Result then
					-- May be equivalent
					Result := deep_equal (elsif_list, other.elsif_list)
					if Result then
						-- May be equivalent
						Result := deep_equal (else_part, other.else_part)
					end
				end
			end
 	   end;

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
				ctxt.set_separator (Void);
				ctxt.set_no_new_line_between_tokens;
				ctxt.format_ast (elsif_list);
				ctxt.set_separator (ti_Semi_colon);
			end;
			if else_part /= void then
				ctxt.put_text_item (ti_Else_keyword);
				ctxt.indent;
				ctxt.new_line;
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
