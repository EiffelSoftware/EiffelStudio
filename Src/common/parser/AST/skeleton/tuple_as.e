indexing
	description: "AST representation of manifest tuple."
	date: "$Date$"
	revision: "$Revision$"

class TUPLE_AS

inherit
	EXPR_AS
		redefine
			is_equivalent
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (exp: like expressions; l_as, r_as: like lbracket) is
			-- Create a new Manifest TUPLE AST node.
		require
			exp_not_void: exp /= Void
		do
			expressions := exp
			lbracket:= l_as
			rbracket := r_as
		ensure
			expressions_set: expressions = exp
			lbracket_set: lbracket = l_as
			rbracket_set: rbracket = r_as
		end

feature -- Attributes

	expressions: EIFFEL_LIST [EXPR_AS]
			-- Expression list symbolizing the manifest tuple

feature -- Roundtrip/Location

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if a_list = Void then
				Result := expressions.complete_start_location (a_list)
			else
				Result := lbracket.complete_start_location (a_list)
			end
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if a_list = Void then
				Result := expressions.complete_end_location (a_list)
			else
				Result := rbracket.complete_end_location (a_list)
			end
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_tuple_as (Current)
		end

feature -- Roundtrip

feature -- Roundtrip

	lbracket, rbracket: SYMBOL_AS
			-- Symbol "[" and "]" associated with this structure

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (expressions, other.expressions)
		end

feature {AST_EIFFEL} -- Output

	string_value: STRING is ""

invariant
	expressions_not_void: expressions /= Void

end -- class TUPLE_AS

