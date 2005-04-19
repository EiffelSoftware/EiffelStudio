indexing
	description: "AST represenation of a unary `old' operation."
	date: "$Date$"
	revision: "$Revision$"

class UN_OLD_AS

inherit
	UNARY_AS
		redefine
			prefix_feature_name
		end

create
	initialize

feature -- Properties

	prefix_feature_name: STRING is
			-- Internal name of the prefixed feature
		do
		end

	operator_name: STRING is "old"

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_un_old_as (Current)
		end

end -- class UN_OLD_AS
