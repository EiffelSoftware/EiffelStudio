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
	make_from_other

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_like_cur_as (Current)
		end

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

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): LIKE_CURRENT is
		   -- Calcutate the effective type
		do
			create Result
			Result.set_actual_type (feat_table.associated_class.actual_type)
		end

feature -- Output

	dump: STRING is "like Current"
			-- Dump trace

end -- class LIKE_CUR_AS
