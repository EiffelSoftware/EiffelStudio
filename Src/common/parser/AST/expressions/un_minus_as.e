indexing
	description: "AST represenation of a unary `-' operation."
	date: "$Date$"
	revision: "$Revision $"

class
	UN_MINUS_AS

inherit
	UNARY_AS

feature -- Properties

	prefix_feature_name: STRING is "_prefix_minus"
			-- Internal name of the prefixed feature

	operator_name: STRING is "-"

end -- class UN_MINUS_AS
