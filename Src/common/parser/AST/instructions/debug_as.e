indexing

	description: "Abstract description of a debug clause";
	date: "$Date$";
	revision: "$Revision$"

class DEBUG_AS

inherit

	INSTRUCTION_AS

feature -- Attributes

	compound: EIFFEL_LIST [INSTRUCTION_AS];
			-- Compound to debug

	keys: EIFFEL_LIST [STRING_AS];
			-- Debug keys

feature -- Initialization

	set is
			-- Yacc initialization
		do
			keys ?= yacc_arg (0);
			compound ?= yacc_arg (1);

				-- Debug keys are not case sensitive
			if keys /= Void then
				from
					keys.start
				until
					keys.after
				loop
					keys.item.value.to_lower;
					keys.forth
				end;
			end;
		end;

feature -- Equivalence

	is_equiv (other: INSTRUCTION_AS): BOOLEAN is
			-- Is `other' instruction equivalent to Current?
		local
			debug_as: DEBUG_AS
		do
			debug_as ?= other
			if debug_as /= Void then
				-- May be equivalent
				Result := equiv (debug_as)
			else
				-- NOT equivalent
				Result := False
			end
		end;

	equiv (other: like Current): BOOLEAN is
			-- Is `other' debug_as equivalent to Current?
		do
			Result := deep_equal (keys, other.keys)
			if Result then
				-- May be equal
				Result := deep_equal (compound, other.compound)
			end
		end;

feature -- Simple formatting

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_breakable;
			ctxt.put_text_item (ti_Debug_keyword);
			ctxt.put_space;
			if keys /= void and then not keys.empty then
				ctxt.put_text_item_without_tabs (ti_L_parenthesis);
				ctxt.set_separator (ti_Comma);
				ctxt.set_no_new_line_between_tokens;
				ctxt.format_ast (keys);
				ctxt.put_text_item_without_tabs (ti_R_parenthesis)
			end;
			if compound /= void then
				ctxt.indent;
				ctxt.new_line;
				ctxt.set_separator (ti_Semi_colon);
				ctxt.set_new_line_between_tokens;
				ctxt.format_ast (compound);
				ctxt.exdent;
			end;
			ctxt.new_line;
			ctxt.put_breakable;
			ctxt.put_text_item (ti_End_keyword);
		end;

feature {DEBUG_AS} -- Replication

	set_compound (c: like compound) is
		do
			compound := c
		end;

end -- class DEBUG_AS
