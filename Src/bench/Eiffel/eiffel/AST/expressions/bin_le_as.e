indexing
	description: "AST representation of binary `<=' operation."
	date: "$Date$"
	revision: "$Revision$"

class BIN_LE_AS

inherit
	COMPARISON_AS

	PREFIX_INFIX_NAMES
		rename
			le_infix as infix_function_name
		end

feature -- Properties

	byte_anchor: BIN_LE_B is
			-- Byte code type
		do
			!! Result
		end

end -- class BIN_LE_AS
