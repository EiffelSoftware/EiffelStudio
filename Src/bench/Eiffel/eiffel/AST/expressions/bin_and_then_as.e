indexing
	description: "AST representation of binary `and then' operation."
	date: "$Date$"
	revision: "$Revision$"

class
	BIN_AND_THEN_AS

inherit
	BINARY_AS

	PREFIX_INFIX_NAMES
		rename
			and_then_infix as infix_function_name
		end


feature -- Properties

	byte_anchor: B_AND_THEN_B is
			-- Byte code type
		do
			!! Result
		end

end -- class BIN_AND_THEN_AS
