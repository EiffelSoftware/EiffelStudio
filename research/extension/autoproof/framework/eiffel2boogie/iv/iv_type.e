note
	description: "[
		Boogie types.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IV_TYPE

inherit
	IV_SHARED_FACTORY

feature -- Access

	default_value: IV_EXPRESSION
			-- Default value of the type, if defined.
		do
			-- Void by default.
		ensure
			correct_type: Result = Void or else Result.type ~ Current
		end

	type_inv (a_expr: IV_EXPRESSION): IV_EXPRESSION
			-- Invariant of this type applied to `a_expr'.
		require
			correct_type: attached a_expr and then a_expr.type ~ Current
		do
			-- Void by default
		end

feature -- Status report

	is_boolean: BOOLEAN
			-- Is this the boolean type?
		do
		end

	is_integer: BOOLEAN
			-- Is this the integer type?
		do
		end

	is_real: BOOLEAN
			-- Is this the real type?
		do
		end

feature -- Visitor

	process (a_visitor: IV_TYPE_VISITOR)
			-- Process type.
		deferred
		end

feature -- Termination

	has_rank: BOOLEAN
			-- Is a well-founded order defined on this type?
		do
			Result := False
		end

	rank_leq (e1, e2: IV_EXPRESSION): IV_EXPRESSION
			-- Expression "e1 <= e2" in terms of the well-founded order of this type.
		require
			has_rank: has_rank
			e1_right_type: e1 /= Void and then e1.type ~ Current
			e2_right_type: e2 /= Void and then e2.type ~ Current
		do
			-- Void by default
		ensure
			result_boolean: Result /= Void and then Result.type.is_boolean
		end

end
