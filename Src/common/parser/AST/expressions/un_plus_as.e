indexing
	description: "AST represenation of a unary `+' operation."
	date: "$Date$"
	revision: "$Revision$"

class UN_PLUS_AS

inherit
	UNARY_AS

create
	initialize

feature -- Properties

	operator_name: STRING is "+"

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_un_plus_as (Current)
		end

end -- class UN_PLUS_AS
