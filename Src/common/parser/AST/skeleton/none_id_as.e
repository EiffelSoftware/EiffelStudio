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
			process
		end

create
	make, initialize

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_none_id_as (Current)
		end
end
