class DEFERRED_AS

inherit

	ROUT_BODY_AS
		redefine
			is_deferred, simple_format, has_instruction, index_of_instruction
		end

feature -- Intialization

	set is
			-- Yacc initialization
		do
			-- Do nothing
		end;

feature -- Conveniences

	is_deferred: BOOLEAN is
			-- Is the current routine body a defferred one ?
		do
			Result := True;
		end;

	has_instruction (i: INSTRUCTION_AS): BOOLEAN is
			-- Has the current routine body an instruction `i'?
		do
			Result := False;
		end;

	index_of_instruction (i: INSTRUCTION_AS): INTEGER is
			-- Index of `i' in this deferred feature.
			-- Result is `0'.
		do
			Result := 0
		end;

feature -- Formatting

	simple_format (ctxt: FORMAT_CONTEXT) is
		do
			ctxt.always_succeed;
			ctxt.put_text_item (ti_Deferred_keyword);
		end;
end
