deferred class INTERNAL_AS

inherit

	ROUT_BODY_AS
		redefine
			simple_format, has_instruction, index_of_instruction
		end

feature -- Attributes

	compound: EIFFEL_LIST [INSTRUCTION_AS];
			-- Compound

feature -- Initialization

	set is
			-- Yacc initialization
		do
			compound ?= yacc_arg (0);
		end

feature -- simple_Formatter

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.begin;
			ctxt.put_text_item (begin_keyword);
			ctxt.indent_one_more

			if compound /= Void then
				ctxt.next_line
				ctxt.set_separator (ti_Semi_colon);
				ctxt.new_line_between_tokens;
				compound.simple_format(ctxt);
			end;
			ctxt.indent_one_less

			ctxt.commit;
		end;

feature -- Status report

	has_instruction (i: INSTRUCTION_AS): BOOLEAN is
			-- Does the current routine body has instruction `i'?
		do
			from
				compound.start
			until
				Result or else compound.off
			loop
				Result := compound.item.is_equiv (i)
				compound.forth
			end
		end;

	index_of_instruction (i: INSTRUCTION_AS): INTEGER is
			-- Index of `i' in this feature.
		do
			from
				compound.start
			until
				compound.off or else compound.item.is_equiv (i)
			loop
				compound.forth
			end

			if not compound.off then
				Result := compound.index
			else
				Result := 0
			end
		end;

feature {INTERNAL_AS, CMD, USER_CMD, INTERNAL_MERGER} -- Replication
	
	set_compound (c: like compound) is
		do
			compound := c;
		end;	

feature {} -- Formatter
	
	begin_keyword: TEXT_ITEM is 
		deferred
		end;
	
 
end
