indexing
	description: "AST representation of binary `/=' operation."
	date: "$Date$"
	revision: "$Revision$"

class
	BIN_NE_AS

inherit
	BIN_EQ_AS
		redefine
			op_name,
			process
		end

	PREFIX_INFIX_NAMES

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_bin_ne_as (Current)
		end

feature -- Properties

	op_name: STRING is "/="

end -- class BIN_NE_AS
