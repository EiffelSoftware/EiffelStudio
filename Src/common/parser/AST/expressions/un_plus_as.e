indexing
	description: "AST represenation of a unary `+' operation."
	date: "$Date$"
	revision: "$Revision $"

class
	UN_PLUS_AS

inherit
	UNARY_AS

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_un_plus_as (Current)
		end

feature -- Properties

	prefix_feature_name: STRING is "_prefix_plus"
			-- Internal name of the prefixed feature

	operator_name: STRING is "+"

end -- class UN_PLUS_AS
