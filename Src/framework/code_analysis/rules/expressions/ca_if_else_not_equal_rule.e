note
	description: "[
			RULE #46: Avoid 'not equal' in If-Else instructions
	
			Having an If-Else instruction with a
			condition that checks for inequality is not optimal for readability.
			Instead an equality comparison should be made. Refactoring by negating
			the condition and by switching the instructions solves this issue.
			
			Do not report anything if there are Elseif parts, because
				if a /= b then
					-- 1
				elseif x then
					-- 2
				else
					-- 3
				end
			would have to be changed to
				if a = b then
					if x then
						-- 2
					else
						-- 3
					end
				else
					-- 1
				end
			that is less readable due to additional nesting.
		]"
	author: "Stefan Zurfluh"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_IF_ELSE_NOT_EQUAL_RULE

inherit
	CA_STANDARD_RULE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			make_with_defaults
			default_severity_score := 30
			severity := severity_hint
		end

	register_actions (a_checker: attached CA_ALL_RULES_CHECKER)
		do
			a_checker.add_if_pre_action (agent process_if)
			a_checker.add_if_expression_pre_action (agent process_if_expression)
		end

feature {NONE} -- Rule checking	

	process_if (a: IF_AS)
			-- Checks whether `a` follows the pattern that leads to a rule violation.
		do
				-- Only look at instructions with Else part but without Elseif parts.
			if attached a.else_part and then not attached a.elsif_list then
				check_condition (a.condition)
			end
		end

	process_if_expression (a: IF_EXPRESSION_AS)
			-- Checks whether `a` follows the pattern that leads to a rule violation.
		do
				-- Only look at expressions without Elseif parts.
			if not attached a.elsif_list then
				check_condition (a.condition)
			end
		end

	check_condition (e: EXPR_AS)
			-- Check if `e` is inquality and report an issue in that case.
		do
			if
				attached {BIN_NE_AS} e as c and then
				not attached {VOID_AS} c.right
			then
					-- The if condition is of the form 'a /= b' or 'a /~ b'. Comparing to Void, however, is ignored
					-- for the sake of intuition: "if c /= Void then" is preferrable (note: the 'attached' syntax
					-- will not be discussed here and is not part of this rule).
				put_violation
					(ca_messages.locale.translation_in_context ("{1} used in if-then-else.", once "code_analyzer.violation"),
					<<agent {TEXT_FORMATTER}.process_symbol_text (c.op_name.name_32)>>,
					ca_messages.if_else_not_equal_violation,
					<<>>,
					c.operator_index)
			end
		end

feature -- Properties

	name: STRING = "inequality_in_conditional"
			-- <Precursor>

	title: STRING_32
			-- Rule title.
		do
			Result := ca_names.if_else_not_equal_title
		end

	description: STRING_32
			-- Rule description.
		do
			Result :=  ca_names.if_else_not_equal_description
		end

	id: STRING_32 = "CA046"
			-- <Precursor>

	format_violation_description (v: CA_RULE_VIOLATION; f: TEXT_FORMATTER)
			-- Ignore the old-style output.
		do
		end

end
