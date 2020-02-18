note
	description: "[
					RULE #30: Unnecessary sign operator
		
				All unary sign operators for numbers are unnecessary, except for a single minus sign.
				They should be removed or the instruction should be checked for errors.
	]"
	author: "Paolo Antonucci"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_UNNECESSARY_SIGN_OPERATOR_RULE

inherit

	CA_STANDARD_RULE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			make_with_defaults
			severity := severity_hint
		end

feature {NONE} -- Activation

	register_actions (a_checker: CA_ALL_RULES_CHECKER)
			-- <Precursor>
		do
			a_checker.add_unary_pre_action (agent process_unary)

				-- Simple unary expressions like "+3" or "-2" are directly parsed as numerical
				-- constants by the compiler, and process_unary is not invoked at all. It is only invoked for expressions with at least
				-- two consecutive signs or for simple unary expressions where the operand is *not* a constant (in that case, the
				-- unnecessary plus operator can be detected). For this reason, we need to handle integer and real expressions separately.
			a_checker.add_integer_pre_action (agent process_int)
			a_checker.add_real_pre_action (agent process_real)
		end

feature {NONE} -- Rule checking


	is_sign_redundant (a_expr: UNARY_AS): BOOLEAN
			-- Is the sign of `a_expr' redundant?
		local
			l_internal_expr: EXPR_AS
		do
				-- Sample violations:
				-- +-2
				-- - -4
				-- -+4
				-- +(4)
				-- -(-7)
				-- -(0)
				--
				-- However NOT:
				-- +(-(-2 - 1)) -- as the parenthesis contain a complex expression
				-- +l_int -- this rule only applies to literals

			Result := False
			if attached {UN_PLUS_AS} a_expr then
					-- The unary plus is always redudant is applied on a basic type
				Result := is_or_wraps_basic_type (a_expr)
			elseif attached {UN_MINUS_AS} a_expr as l_minus_expr then
					-- This is fine, but if the operand of this expression is another
					-- plus or minus unary expression, then this sign is redundant.

				l_internal_expr := unwrapped (l_minus_expr.expr)
				if attached {UN_PLUS_AS} l_internal_expr or attached {UN_MINUS_AS} l_internal_expr then
					Result := True
				elseif attached {INTEGER_AS} l_internal_expr as l_int_as then
						-- No sign is necessary for zero
						-- Also, if the integer already has a sign, the current sign is redundant.
					Result := l_int_as.integer_64_value = 0 or l_int_as.sign_symbol (current_context.matchlist) /= Void
				elseif attached {REAL_AS} l_internal_expr as l_real_as then
						-- If the real already has a sign, the current sign is redundant.
						-- Note that 0.0 and -0.0 are not the same (e.g. "1 / -0.0" yields -Infinity).
					Result := l_real_as.sign_symbol (current_context.matchlist) /= Void
				end
			end
		end

	unwrapped (a_expr: EXPR_AS): EXPR_AS
			-- If `a_expr' is of type `PARAN_AS', then the wrapped expression.
			-- Otherwise `a_expr' itself.
		do
			if attached {PARAN_AS} a_expr as l_expr then
				Result := unwrapped (l_expr.expr)
			else
				Result := a_expr
			end
		end

	is_or_wraps_basic_type (a_expr: EXPR_AS): BOOLEAN
			-- Is the expression wrapped by `a_expr' (by zero or more layers of parentheses and/or unary operators)
			-- a constant of a basic type? (INTEGER or REAL)
		local
			l_expr: like a_expr
			l_stop: BOOLEAN
		do
			from
				l_expr := a_expr
			until
				l_stop
			loop
				if attached {PARAN_AS} l_expr as l_paran_as then
					l_expr := l_paran_as.expr
				elseif attached {UN_PLUS_AS} l_expr as l_paran_as then
					l_expr := l_paran_as.expr
				elseif attached {UN_MINUS_AS} l_expr as l_paran_as then
					l_expr := l_paran_as.expr
				else
					l_stop := true
					Result := attached {INTEGER_AS} l_expr or attached {REAL_AS} l_expr
				end
			end
		end

	process_unary (a_expr: UNARY_AS)
			-- Process `a_expr'.
		do
			if is_sign_redundant (a_expr) then
				add_violation (a_expr.start_location, a_expr.text_32 (current_context.matchlist))
			end
		end

	process_int (a_integer: INTEGER_AS)
			-- Process `a_integer'.
		do
				-- Sample violations:
				--	+3
				--	-0
			if
				attached a_integer.sign_symbol (current_context.matchlist) as l_sign and then
				(l_sign.is_plus or a_integer.is_zero)
			then
				add_violation (l_sign.start_location, a_integer.text_32 (current_context.matchlist))
			end
		end

	process_real (a_real: REAL_AS)
			-- Process `a_real'.
		do
				-- Sample violation:
				--  +3.7
				-- We do not check for the case (sign.is_minus and a_real.value.to_real_64 = 0)
				-- as 0.0 and -0.0 are not the same (e.g. "1 / -0.0" yields -Infinity).
			if
				attached a_real.sign_symbol (current_context.matchlist) as l_sign and then
				l_sign.is_plus
			then
				add_violation (l_sign.start_location, a_real.text_32 (current_context.matchlist))
			end
		end

	add_violation (a_location: LOCATION_AS; a_text: READABLE_STRING_32)
			-- Creates and adds to the violations list a new violation
			-- with location `a_location' and text `a_text'.
		local
			l_viol: CA_RULE_VIOLATION
		do
			create l_viol.make_with_rule (Current)
			l_viol.set_location (a_location)
			l_viol.long_description_info.extend (a_text)
			violations.extend (l_viol)
		end

feature -- Properties

	name: STRING = "unnecessary_sign"
			-- <Precursor>

	title: STRING_32
			-- <Precursor>
		do
			Result := ca_names.unnecessary_sign_operator_title
		end

	id: STRING_32 = "CA030"
			-- <Precursor>

	description: STRING_32
			-- <Precursor>
		do
			Result := ca_names.unnecessary_sign_operator_description
		end

	format_violation_description (a_violation: CA_RULE_VIOLATION; a_formatter: TEXT_FORMATTER)
			-- <Precursor>
		do
			a_formatter.add (ca_messages.unnecessary_sign_operator_violation_1)
			check
				attached {READABLE_STRING_GENERAL} a_violation.long_description_info.first
			end
			if attached {READABLE_STRING_GENERAL} a_violation.long_description_info.first as l_text then
				a_formatter.add_quoted_text (l_text)
			end
			a_formatter.add (ca_messages.unnecessary_sign_operator_violation_2)
		end

end
