indexing
	description: "Objects that represent an automatically created NONE id"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NONE_ID_AS

inherit
	ID_AS
		redefine
			process,
			text
		end

create
	make, initialize

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_none_id_as (Current)
		end

feature -- Roundtrip

	text (a_list: LEAF_AS_LIST): STRING is
			-- Literal text of this token, which is stored in `a_list'
		do
				-- In view of roundtrip parser, text of a NONE_ID_AS is empty because this
				-- node is not in source code.
			Result := ""
		end

end
