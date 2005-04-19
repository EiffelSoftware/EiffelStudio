indexing
	description: "AST represenation of a unary `strip' operation."
	date: "$Date$"
	revision: "$Revision$"

class
	UN_STRIP_AS

inherit
	EXPR_AS

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (i: like id_list) is
			-- Create a new UN_STRIP AST node.
		require
			i_not_void: i /= Void
		do
			id_list := i
		ensure
			id_list_set: id_list = i
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_un_strip_as (Current)
		end

feature -- Attributes

	id_list: CONSTRUCT_LIST [INTEGER]
			-- Attribute list

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			Result := null_location
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			Result := null_location
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equal (id_list, other.id_list)
		end

invariant
	id_list_not_void: id_list /= Void

end -- class UN_STRIP_AS
