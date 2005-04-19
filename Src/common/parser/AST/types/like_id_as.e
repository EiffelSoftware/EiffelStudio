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

	initialize (a: like anchor) is
			-- Create a new LIKE_ID AST node.
		require
			a_not_void: a /= Void
		do
			anchor := a
		ensure
			anchor_set: anchor = a
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_like_id_as (Current)
		end

feature -- Attributes

	anchor: ID_AS
			-- Anchor name

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			Result := anchor.start_location
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			Result := anchor.end_location
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
