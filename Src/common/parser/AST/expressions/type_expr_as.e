indexing
	description: "Type expression"
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE_EXPR_AS

inherit
	EXPR_AS

create
	initialize

feature {NONE} -- Initialize

	initialize (t: like type) is
			-- New instance of TYPE_EXPR_AS initialized with `t'.
		require
			t_not_void: t /= Void
		do
			type := t
		ensure
			type_set: type = t
		end

feature -- Access

	type: TYPE_AS
			-- Type representing type expression

feature -- Visitor

	process (v: AST_VISITOR) is
			--
		do
			v.process_type_expr_as (Current)
		end

feature -- Roundtrip/Location

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			Result := type.complete_start_location (a_list)
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			Result := type.complete_end_location (a_list)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to `Current'?
		do
			Result := equivalent (type, other.type)
		end

invariant
	type_not_void: type /= Void

end
