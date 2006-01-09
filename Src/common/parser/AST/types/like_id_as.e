indexing
	description: "Abstract description for `like id' type."
	date: "$Date$"
	revision: "$Revision$"

class
	LIKE_ID_AS

inherit
	TYPE_AS
		redefine
			has_like, is_loose
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (a: like anchor; l_as: like like_keyword) is
			-- Create a new LIKE_ID AST node.
		require
			a_not_void: a /= Void
		do
			anchor := a
			like_keyword := l_as
		ensure
			anchor_set: anchor = a
			like_keyword_set: like_keyword = l_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_like_id_as (Current)
		end

feature -- Roundtrip

	like_keyword: KEYWORD_AS
		-- Keyword "like" associated with this structure


feature -- Attributes

	anchor: ID_AS
			-- Anchor name

feature -- Roundtrip/Location

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if a_list = Void then
				Result := anchor.complete_start_location (a_list)
			else
				Result := like_keyword.complete_start_location (a_list)
			end
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			Result := anchor.complete_end_location (a_list)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (anchor, other.anchor)
		end

feature -- Access

	has_like: BOOLEAN is True
			-- Has the type anchored type in its definition ?

	is_loose: BOOLEAN is True
			-- Does type depend on formal generic parameters and/or anchors?

feature -- Output

	dump: STRING is
			-- Dump string
		do
			create Result.make (5 + anchor.count)
			Result.append ("like ")
			Result.append (anchor)
		end

feature {LIKE_ID_AS} -- Replication

	set_anchor (a: like anchor) is
		do
			anchor := a
		end

end -- class LIKE_ID_AS
