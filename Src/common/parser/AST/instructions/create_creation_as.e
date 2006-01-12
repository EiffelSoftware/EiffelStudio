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

	set_create_keyword (a_keyword: KEYWORD_AS) is
			-- Set `create_keyword' with `a_keyword'.
		do
			create_keyword := a_keyword
		ensure
			create_keyword_set: create_keyword = a_keyword
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_create_creation_as (Current)
		end

feature -- Roundtrip/Location

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if a_list = Void then
				if type /= Void then
					Result := type.complete_start_location (a_list)
				else
					Result := target.complete_start_location (a_list)
				end
			else
				Result := create_keyword.complete_start_location (a_list)
			end
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if call /= Void then
				Result := call.complete_end_location (a_list)
			else
				Result := target.complete_end_location (a_list)
			end
		end

end
