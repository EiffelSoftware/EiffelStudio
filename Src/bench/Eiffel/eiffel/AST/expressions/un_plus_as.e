indexing
	description: "AST represenation of a unary `+' operation."
	date: "$Date$"
	revision: "$Revision$"

class UN_PLUS_AS

inherit
	UNARY_AS

feature -- Properties


	operator_name: STRING is "+"

feature -- Access

	internal_byte_node: UN_PLUS_B is
			-- Associated byte code
		do
			create Result
		end
	
end -- class UN_PLUS_AS
