indexing
	description: "Object that represents a list of debug keys"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DEBUG_KEY_LIST_AS

inherit
	PARAN_LIST_AS [EIFFEL_LIST [STRING_AS]]
		rename
			content as keys
		end

create
	make

feature -- Visitor

	process (v: AST_VISITOR) is
			-- Visitor feature.
		do
			v.process_debug_key_list_as (Current)
		end

end

