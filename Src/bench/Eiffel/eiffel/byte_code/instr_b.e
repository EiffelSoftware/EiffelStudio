indexing
	description: "Abstract class for byte node instruction."
	date: "$Date$"
	revision: "$Revision$"

deferred class INSTR_B 

inherit
	BYTE_NODE
		redefine
			line_number, set_line_number, enlarged
		end

feature -- Enlargment

	enlarged: INSTR_B is
			-- Enlarge current node for C code generation
		do
			Result := Precursor {BYTE_NODE}
		end

feature -- Access

	line_number: INTEGER

feature -- Line number setting

	set_line_number (lnr : INTEGER) is
		do
			line_number := lnr
		ensure then
			line_number_set : line_number = lnr
		end

end
