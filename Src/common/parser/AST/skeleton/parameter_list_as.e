indexing
	description: "Object that represents a list of parameters"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PARAMETER_LIST_AS

inherit
	PARAN_LIST_AS [EIFFEL_LIST [EXPR_AS]]
		rename
			make as initialize,
			content as parameters
		end

create
	initialize

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_parameter_list_as (Current)
		end

end
