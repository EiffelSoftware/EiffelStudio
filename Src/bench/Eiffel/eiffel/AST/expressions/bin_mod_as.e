indexing
	description: "AST representation of binary `\' operation."
	date: "$Date$"
	revision: "$Revision$"

class BIN_MOD_AS

inherit
	ARITHMETIC_AS
		redefine
			balanced
		end

	PREFIX_INFIX_NAMES
		rename
			mod_infix as infix_function_name
		end

feature -- Properties

	balanced: BOOLEAN is False
			-- Is the bianry operation balanced ?

	byte_anchor: BIN_MOD_B is
			-- Byte code type
		do
			!! Result
		end

end -- class BIN_MOD_AS
