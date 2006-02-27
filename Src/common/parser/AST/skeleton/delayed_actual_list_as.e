indexing
	description: "Object that represents a list of delayed actuals"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DELAYED_ACTUAL_LIST_AS

inherit
	PARAN_LIST_AS [EIFFEL_LIST [OPERAND_AS]]
		rename
			content as operands
		end

create
	make

feature -- Visitor

	process (v: AST_VISITOR) is
			-- Visitor feature.
		do
			v.process_delayed_actual_list_as (Current)
		end

end
