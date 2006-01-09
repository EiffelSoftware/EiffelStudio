indexing
	description: "Node for `like Current' type."
	date: "$Date$"
	revision: "$Revision$"

class LIKE_CUR_AS

inherit
	TYPE_AS
		redefine
			has_like, is_loose
		end

	LOCATION_AS
		rename
			make as make_with_location
		end

create
	make

feature{NONE} -- Initialization

	make (other: LOCATION_AS; l_as: KEYWORD_AS) is
			-- Create new LIKE_CURRENT AST node.
		local
			c_as: KEYWORD_AS
		do
			c_as ?= other
			like_keyword := l_as
			current_keyword := c_as
			make_from_other (other)
		ensure
			like_keyword_set: like_keyword = l_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_like_cur_as (Current)
		end

feature -- Roundtrip

	like_keyword: KEYWORD_AS
		-- Keyword "like" associated with this structure		

	current_keyword: KEYWORD_AS
		-- Keyword "current" associated with this structure		

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := True
		end

feature -- Properties

	has_like: BOOLEAN is True
			-- Does the type have anchor in its definition ?

	is_loose: BOOLEAN is True
			-- Does type depend on formal generic parameters and/or anchors?

feature -- Output

	dump: STRING is "like Current"
			-- Dump trace

feature -- Roundtrip/Location

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if a_list = Void then
				Result := Current
			else
				Result := like_keyword.complete_start_location (a_list)
			end
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			Result := current_keyword.complete_end_location (a_list)
		end


end -- class LIKE_CUR_AS
