deferred class ROUT_BODY_AS

inherit

	AST_EIFFEL

feature -- Conveniences

	is_once: BOOLEAN is
			-- Is the routine body a once one ?
		do
			-- Do nothing
		end;

	is_deferred: BOOLEAN is
			-- Is the routine body a deferred one ?
		do
			-- Do nothing
		end;

	is_external: BOOLEAN is
			-- Is the routine body an external one ?
		do
			-- Do nothing
		end;

	has_instruction (i: INSTRUCTION_AS): BOOLEAN is
			-- Has current routine body instruction `i'?
		do
			-- Do nothing
		end;

	index_of_instruction (i: INSTRUCTION_AS): INTEGER is
			-- Index of `i'.
		do
			-- Do nothing
		end;

end -- class ROUT_BODY_AS
