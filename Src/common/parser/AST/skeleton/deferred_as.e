class DEFERRED_AS

inherit

	ROUT_BODY_AS
		redefine
			is_deferred, has_instruction, index_of_instruction
		end

feature -- Initialization

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

feature -- Simple formatting

    simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
        do
            ctxt.put_text_item (ti_Deferred_keyword);
		ctxt.new_line
        end;

end -- class DEFERRED_AS
