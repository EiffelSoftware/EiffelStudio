indexing
	description: "Abstract class for unary expression, Bench version"
	date: "$Date$"
	revision: "$Revision$"

deferred class UNARY_AS
	
inherit
	EXPR_AS

	SYNTAX_STRINGS
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	initialize (e: like expr) is
			-- Create a new UNARY AST node.
		require
			e_not_void: e /= Void
		do
			expr := e
		ensure
			expr_set: expr = e
		end

feature -- Attributes

	expr: EXPR_AS
			-- Expression

feature -- Location

	start_location: LOCATION_AS is
			-- Start location of Current
		do
			Result := expr.start_location
		end
		
	end_location: LOCATION_AS is
			-- End location of Current
		do
			Result := expr.end_location
		end
		
	operator_location: LOCATION_AS is
			-- Location of operator
		do
			fixme ("Need to store operator location")
			Result := start_location
		end

feature -- Properties

	prefix_feature_name: STRING is
			-- Internal name of the prefixed feature
		do
			Result := Prefix_str + operator_name + Quote_str
		end

	operator_name: STRING is
		deferred
		end
		
	is_minus: BOOLEAN is
			-- Is Current prefix "-"?
		do
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (expr, other.expr)
		end

feature {UNARY_AS} -- Replication

	set_expr (e: like expr) is
			-- Set `expr' with `e'.
		require
			valid_arg: e /= Void
		do
			expr := e
		ensure
			expr_set: expr = e
		end

invariant
	expr_not_void: expr /= Void

end

