-- Abstract description of a debug clause

class DEBUG_AS

inherit

	INSTRUCTION_AS
		redefine
			simple_format
		end

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

feature -- simple_Formatter

    simple_format (ctxt: FORMAT_CONTEXT) is
            -- Reconstitute text.
        do
            ctxt.begin;
 		   ctxt.put_breakable;
 	       ctxt.put_text_item (ti_Debug_keyword);
            ctxt.put_space;
 		   if keys /= void and then not keys.empty then
                ctxt.put_text_item (ti_L_parenthesis);
                ctxt.set_separator (ti_Comma);
                ctxt.no_new_line_between_tokens;
                keys.simple_format (ctxt);
                ctxt.put_text_item (ti_R_parenthesis)
            end;
        	if compound /= void then
                ctxt.indent_one_more;
                ctxt.next_line;
 		       ctxt.set_separator (ti_Semi_colon);
                ctxt.new_line_between_tokens;
                compound.simple_format (ctxt);
                ctxt.put_breakable;
 	           ctxt.indent_one_less;
            end;
        	ctxt.next_line;
 		   ctxt.put_text_item (ti_End_keyword);
            ctxt.commit;
		end;

feature {DEBUG_AS}    -- Replication

    set_compound (c: like compound) is
        do
            compound := c
   	 end;

end
