indexing
	description: "AST representation of binary `^' operation."
	date: "$Date$"
	revision: "$Revision$"

class
	BIN_POWER_AS

inherit
	ARITHMETIC_AS
		redefine
			balanced
		end

	PREFIX_INFIX_NAMES
		rename
			power_infix as infix_function_name
		end

feature -- Properties

	balanced: BOOLEAN is False
			-- Is the operation balanced ?

	byte_anchor: BIN_POWER_B is
			-- Byte code type
		do
			!! Result
		end

end -- class BIN_POWER_AS
