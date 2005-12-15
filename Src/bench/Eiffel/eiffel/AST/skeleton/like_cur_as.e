indexing

	description: "Node for `like Current' type. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class LIKE_CUR_AS

inherit
	TYPE_AS
		redefine
			has_like, is_loose
		end

	LEAF_AS

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

feature

	actual_type: LIKE_TYPE_A is
			-- Called when `like current' is used for a formal generic parameter
			-- or when used to evaluate a type in a class that had not yet gone
			-- through DEGREE 4.
		do
			create {UNEVALUATED_LIKE_TYPE} Result.make_current
		end

feature -- Output

	dump: STRING is "like Current"
			-- Dump trace

end -- class LIKE_CUR_AS
