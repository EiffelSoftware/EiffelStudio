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

	initialize (i: like id_list; o: KEYWORD_AS) is
			-- Create a new UN_STRIP AST node.
		require
			i_not_void: i /= Void
		do
			id_list := i
			strip_keyword := o
		ensure
			id_list_set: id_list = i
			strip_keyword_set: strip_keyword = o
		end

feature -- Roundtrip

	strip_keyword: AST_EIFFEL
			-- Keyword "strip"

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_un_strip_as (Current)
		end

feature -- Attributes

	id_list: CONSTRUCT_LIST [INTEGER]
			-- Attribute list

feature -- Roundtrip/Location

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if a_list = Void then
				Result := null_location
			else
				Result := strip_keyword.complete_start_location (a_list)
			end
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		local
			l_id_list: IDENTIFIER_LIST
		do
			if a_list = Void then
				Result := null_location
			else
				l_id_list ?= id_list
				Result := l_id_list.id_list.complete_end_location (a_list)
			end
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
