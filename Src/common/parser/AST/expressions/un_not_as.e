indexing
	description: "AST represenation of a unary `not' operation."
	date: "$Date$"
	revision: "$Revision $"

class
	UN_NOT_AS

inherit
	UNARY_AS
		redefine
			operator_is_keyword
		end

feature -- Properties

	prefix_feature_name: STRING is "_prefix_not"
			-- Internal name of the prefixed feature

	operator_name: STRING is "not"
	
	operator_is_keyword: BOOLEAN is True

end -- class UN_NOT_AS
