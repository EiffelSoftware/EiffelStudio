indexing
	description: "AST represenation of a unary `not' operation."
	date: "$Date$"
	revision: "$Revision$"

class UN_NOT_AS

inherit
	UNARY_AS
		redefine
			operator_is_keyword,
			byte_node
		end

feature -- Properties

	prefix_feature_name: STRING is "_prefix_not"
			-- Internal name of the prefixed feature

	operator_name: STRING is "not"
	
	operator_is_keyword: BOOLEAN is True

feature -- Type check

	byte_node: UN_NOT_B is
			-- Associated byte code
		local
			access_line: ACCESS_LINE
			feature_b: FEATURE_B
		do
			!! Result
			Result.set_expr (expr.byte_node)

			access_line := context.access_line
			feature_b ?= access_line.access
			Result.init (feature_b)
			access_line.forth
		end

end -- class UN_NOT_AS
