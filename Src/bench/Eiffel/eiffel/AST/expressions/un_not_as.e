indexing
	description: "AST represenation of a unary `not' operation."
	date: "$Date$"
	revision: "$Revision$"

class UN_NOT_AS

inherit
	UNARY_AS
		redefine
			operator_is_keyword
		end

	PREFIX_INFIX_NAMES
		rename
			not_prefix as prefix_feature_name
		end
feature -- Properties

	operator_name: STRING is "not"
	
	operator_is_keyword: BOOLEAN is True

feature -- Type check

	internal_byte_node: UN_NOT_B is
			-- Associated byte code
		do
			create Result
		end

end -- class UN_NOT_AS
