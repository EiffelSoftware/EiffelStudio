indexing
	description: "Object that represents a list of formal arguments"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FORMAL_ARGU_DEC_LIST_AS

inherit
	PARAN_LIST_AS [EIFFEL_LIST [TYPE_DEC_AS]]
		rename
			content as arguments
		end

create
	make

feature -- Visitor

	process (v: AST_VISITOR) is
			-- Visitor feature.
		do
			v.process_formal_argu_dec_list_as (Current)
		end

end
