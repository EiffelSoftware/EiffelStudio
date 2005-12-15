indexing
	description: "Abstract description of an Eiffel creation expression call (using keyword create) "
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CREATE_CREATION_EXPR_AS

inherit
	CREATION_EXPR_AS
		rename
			process as creation_expr_process
		end

create
	make

feature{NONE} -- Initialization
	make (t: like type; c: like call; k_as: like create_keyword)is
			-- new CREATE_CREATION_EXPR AST node.
		do
			initialize (t, c)
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
			v.process_create_creation_expr_as (Current)
		end
end
