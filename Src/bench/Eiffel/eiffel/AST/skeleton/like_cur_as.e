indexing

	description: "Node for `like Current' type. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class LIKE_CUR_AS

inherit
	TYPE
		redefine
			has_like, simple_format
		end

feature {AST_FACTORY} -- Initialization

	initialize is
			-- Create a new LIKE_CURRENT AST node.
		do
			-- Do nothing.
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
			!!Result
			Result.set_actual_type (feat_table.associated_class.actual_type)
		end

feature -- Output

	dump: STRING is "like Current"
			-- Dump trace

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_text_item_without_tabs (ti_Like_keyword)
			ctxt.put_space
			ctxt.put_text_item_without_tabs (ti_Current)
		end
		
end -- class LIKE_CUR_AS
