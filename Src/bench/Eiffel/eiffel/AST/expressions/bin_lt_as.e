indexing
	description: "AST representation of binary `<' operation."
	date: "$Date$"
	revision: "$Revision$"

class BIN_LT_AS

inherit
	COMPARISON_AS

	PREFIX_INFIX_NAMES
		rename
			lt_infix as infix_function_name
		end

feature -- Properties

	byte_anchor: BIN_LT_B is
			-- Byte code type
		do
			!! Result
		end

end -- class BIN_LT_AS
