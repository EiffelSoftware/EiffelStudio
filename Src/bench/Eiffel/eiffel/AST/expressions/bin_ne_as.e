indexing
	description: "AST representation of binary `/=' operation."
	date: "$Date$"
	revision: "$Revision$"

class
	BIN_NE_AS

inherit
	BIN_EQ_AS
		redefine
			op_name, byte_anchor, process
		end

	PREFIX_INFIX_NAMES

create
	initialize

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_bin_ne_as (Current)
		end

feature -- Properties

	op_name: STRING is "/="

	byte_anchor: BIN_EQUAL_B is
			-- Byte code type
		do
			create {BIN_NE_B} Result
		end

end -- class BIN_NE_AS
