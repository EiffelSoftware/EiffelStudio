indexing
	description: "AST represenation of a unary `-' operation."
	date: "$Date$"
	revision: "$Revision$"

class UN_MINUS_AS

inherit
	UNARY_AS

feature -- Properties

	operator_name: STRING is "-"

feature -- Type check

	internal_byte_node: UN_MINUS_B is
			-- Associated byte code
		do
			create Result
		end

end -- class UN_MINUS_AS
