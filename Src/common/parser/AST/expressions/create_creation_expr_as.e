indexing
	description: "Abstract description of an Eiffel creation expression call (using keyword create) "
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CREATE_CREATION_EXPR_AS

inherit
	CREATION_EXPR_AS
		redefine
			process
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

	set_create_keyword (a_keyword: KEYWORD_AS) is
			--- Set `create_keyword' with `a_keyword'.
		do
			create_keyword := a_keyword
		ensure
			create_keyword_set: create_keyword = a_keyword
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_create_creation_expr_as (Current)
		end

feature -- Roundtrip/Location

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if a_list = Void then
				Result := type.complete_start_location (a_list)
			else
				Result := create_keyword.complete_start_location (a_list)
			end
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if call /= Void then
				Result := call.complete_end_location (a_list)
			else
				Result := type.complete_end_location (a_list)
			end
		end
end
