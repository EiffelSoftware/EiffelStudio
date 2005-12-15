indexing
	description: "AST leaf list for roundtrip parser"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LEAF_AS_LIST

inherit
	ARRAYED_LIST [LEAF_AS]
		export
			{ANY}grow
		end

create
	make
end
