-- Abstract description of an assignment

class ASSIGN_AS

inherit

	INSTRUCTION_AS
		redefine
			simple_format
		end

feature -- Attributes

	target: ACCESS_AS;
			-- Target of the assignment

	source: EXPR_AS;
			-- Source of the assignment

feature -- Initialization

	set is
			-- Yacc initialization
		do
			target ?= yacc_arg (0);
			source ?= yacc_arg (1);
		ensure then
			target_exists: target /= Void;
			source_exists: source /= Void;
		end;

feature -- Equivalence

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

feature -- Formatter

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconsitute text.
		do
			ctxt.begin;
			ctxt.put_breakable;
			ctxt.new_expression;
			target.simple_format (ctxt);
			ctxt.put_space;
			ctxt.put_text_item (assign_symbol);
			ctxt.put_space;
			ctxt.new_expression;
			source.simple_format (ctxt);
			ctxt.commit;
		end;

--feature {ASSIGN_AS} -- Formatter
feature

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

end
