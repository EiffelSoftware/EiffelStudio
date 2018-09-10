note
	description: "[
		Basic Boogie types: bool, int, real.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	IV_BASIC_TYPE

inherit
	IV_TYPE
		redefine
			default_value,
			is_boolean,
			is_integer,
			is_real,
			is_equal,
			has_rank,
			rank_leq
		end

create
	make_boolean,
	make_integer,
	make_real

feature {NONE} -- Initialization

	make_boolean
			-- Make this a boolean type.
		do
			is_boolean := True
		ensure
			is_boolean: is_boolean
		end

	make_integer
			-- Make this an integer type.
		do
			is_integer := True
		ensure
			is_integer: is_integer
		end

	make_real
			-- Make this a real type.
		do
			is_real := True
		ensure
			is_real: is_real
		end

feature -- Access

	default_value: IV_EXPRESSION
			-- Default value of the type, if defined.
		do
			if is_boolean then
				Result := factory.false_
			elseif is_integer then
				Result := factory.int_value (0)
			else
				check is_real end
				Result := factory.real_value (0.0)
			end
		end

feature -- Status report

	is_boolean: BOOLEAN
			-- Is this the boolean type?

	is_integer: BOOLEAN
			-- Is this the integer type?

	is_real: BOOLEAN
			-- Is this the real type?

feature -- Visitor

	process (a_visitor: IV_TYPE_VISITOR)
			-- <Precursor>
		do
			if is_boolean then
				a_visitor.process_boolean_type (Current)
			elseif is_integer then
				a_visitor.process_integer_type (Current)
			elseif is_real then
				a_visitor.process_real_type (Current)
			else
				check False end
			end
		end

feature -- Equality

	is_equal (a_other: like Current): BOOLEAN
			-- Is `a_other' same type as this?
		do
			if is_boolean then
				Result := a_other.is_boolean
			elseif is_integer then
				Result := a_other.is_integer
			elseif is_real then
				Result := a_other.is_real
			else
				Result := False
			end
		end

feature -- Termination

	has_rank: BOOLEAN
			-- <Precursor>
		do
			Result := is_boolean or is_integer
		end

	rank_leq (e1, e2: IV_EXPRESSION): IV_EXPRESSION
			-- <Precursor>	
		do
			if is_boolean then
				Result := factory.implies_ (e1, e2)
			else
				check is_integer end
				Result := factory.less_equal (e1, e2)
			end
		end

end
