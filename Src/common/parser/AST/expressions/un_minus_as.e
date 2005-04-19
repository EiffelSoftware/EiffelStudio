indexing
	description: "AST represenation of a unary `-' operation."
	date: "$Date$"
	revision: "$Revision$"

class UN_MINUS_AS

inherit
	UNARY_AS
		redefine
			is_minus
		end

create
	initialize

feature -- Properties

	operator_name: STRING is "-"

	is_minus: BOOLEAN is True
			-- Is current prefix "-"?

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_un_minus_as (Current)
		end

end -- class UN_MINUS_AS
