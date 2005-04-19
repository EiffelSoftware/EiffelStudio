indexing
	description: "AST represenation of a unary `not' operation."
	date: "$Date$"
	revision: "$Revision$"

class UN_NOT_AS

inherit
	UNARY_AS

create
	initialize

feature -- Properties

	operator_name: STRING is "not"

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_un_not_as (Current)
		end

end -- class UN_NOT_AS
