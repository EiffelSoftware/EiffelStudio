indexing

	description: 
		"AST representation of an assignment";
	date: "$Date$";
	revision: "$Revision$"

class ASSIGN_AS

inherit

	INSTRUCTION_AS

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			target ?= yacc_arg (0);
			source ?= yacc_arg (1);
		ensure then
			target_exists: target /= Void;
			source_exists: source /= Void;
		end;

feature -- Properties

	target: ACCESS_AS;
			-- Target of the assignment

	source: EXPR_AS;
			-- Source of the assignment

feature -- Comparison

	is_equiv (other: INSTRUCTION_AS): BOOLEAN is
			-- Is `other' instruction equivalent to Current?
		local
			assign_as: ASSIGN_AS
		do
			assign_as ?= other
			if assign_as /= Void then
				-- May be equivalent
				Result := equiv (assign_as)
			else
				-- NOT equivalent
				Result := False
			end
		end;

	equiv (other: like Current): BOOLEAN is
				-- Is `other' assign_as equivalent to Current?
			do
				-- Don't mix up assignment and reversed assignment!
				Result := deep_equal (assign_symbol, other.assign_symbol)
				if Result then
					-- May be equivalent
					Result := deep_equal (target, other.target)
					if Result then
						-- May be equivalent
						Result := deep_equal (source, other.source)
					end
				end
			end;

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconsitute text.
		do
			ctxt.put_breakable;
			ctxt.new_expression;
			ctxt.format_ast (target);
			ctxt.put_space;
			ctxt.put_text_item_without_tabs (assign_symbol);
			ctxt.put_space;
			ctxt.new_expression;
			ctxt.format_ast (source);
		end;

feature {ASSIGN_AS} -- Formatter

	assign_symbol: TEXT_ITEM is
		do
			Result := ti_Assign
		end;
		
feature {ASSIGN_AS}	-- Replication
		
	set_target (t: like target) is
		require
			valid_arg: t /= Void
		do
			target := t
		end;

	set_source (s: like source) is
		require
			valid_arg: s /= Void
		do
			source := s
		end;

end -- class ASSIGN_AS
