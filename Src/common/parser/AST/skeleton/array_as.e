indexing
	description: "AST representation of manifest array."
	date: "$Date$"
	revision: "$Revision $"

class ARRAY_AS

inherit
	EXPR_AS
		redefine
			is_equivalent
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (exp: like expressions; l_as, r_as: like larray) is
			-- Create a new Manifest ARRAY AST node.
		require
			exp_not_void: exp /= Void
		do
			expressions := exp
			larray := l_as
			rarray := r_as
		ensure
			expressions_set: expressions = exp
			larray_set: larray = l_as
			rarray_set: rarray = r_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_array_as (Current)
		end

feature -- Roundtrip

	larray, rarray: SYMBOL_AS
			-- Symbol "<<" and ">>" associated with this structure

feature -- Attributes

	expressions: EIFFEL_LIST [EXPR_AS]
			-- Expression list symbolizing the manifest array

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			Result := expressions.start_location
		end

	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			Result := expressions.end_location
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (expressions, other.expressions)
		end

feature {AST_EIFFEL} -- Output

	string_value: STRING is ""

feature {ARRAY_AS}	-- Replication

	set_expressions (e: like expressions) is
		require
			valid_arg: e /= Void
		do
			expressions := e
		end

invariant
	expressions_not_void: expressions /= Void

end -- class ARRAY_AS
