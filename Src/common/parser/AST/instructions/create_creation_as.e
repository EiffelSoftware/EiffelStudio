indexing
	description: "Object that represents a creation structure (using keyword create)"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CREATE_CREATION_AS

inherit
	CREATION_AS
		redefine
			process
		end

create
	make

feature{NONE} -- Initialization

	make (tp: like type; tg: like target; c: like call; k_as: like create_keyword) is
			-- Create new CREATE_CREATION AST node.
		do
			initialize (tp, tg, c)
			create_keyword := k_as
		ensure
			create_keyword_set: create_keyword = k_as
		end

feature -- Roundtrip

	create_keyword: KEYWORD_AS
			-- Keyword "create" associated with this structure

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_create_creation_as (Current)
		end

end
