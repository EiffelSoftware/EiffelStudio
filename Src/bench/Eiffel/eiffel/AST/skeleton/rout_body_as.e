indexing
	description: "Abstract notion of a routine body."
	date: "$Date$"
	revision: "$Revision$"

deferred class ROUT_BODY_AS

inherit
	AST_EIFFEL
		redefine
			byte_node
		end

feature -- Properties

	is_once: BOOLEAN is
			-- Is the routine body a once one ?
		do
			-- Do nothing
		end

	is_deferred: BOOLEAN is
			-- Is the routine body a deferred one ?
		do
			-- Do nothing
		end

	is_external: BOOLEAN is
			-- Is the routine body an external one ?
		do
			-- Do nothing
		end

feature -- Access

	has_instruction (i: INSTRUCTION_AS): BOOLEAN is
			-- Has current routine body instruction `i'?
		do
			-- Do nothing
		end

	index_of_instruction (i: INSTRUCTION_AS): INTEGER is
			-- Index of `i'.
		do
			-- Do nothing
		end
feature -- Byte code

	byte_node: BYTE_CODE is
			-- Byte associated to the routine body (compound)
		do
			-- Do nothing
		end

feature -- test for empty body

	is_empty : BOOLEAN is
			-- Is body empty?
		do
			Result := True  -- redefined in INTERNAL_AS
		end

end -- class ROUT_BODY_AS
