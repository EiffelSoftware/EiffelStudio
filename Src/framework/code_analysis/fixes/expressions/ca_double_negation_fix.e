note
	description: "Fixes violations of rule #15 ('Double negation')."
	date: "$Date$"
	revision: "$Revision$"

class
	CA_DOUBLE_NEGATION_FIX

inherit
	CA_FIX
		redefine
			execute
		end

create
	make_with_un_not

feature {NONE} -- Initialization
	make_with_un_not (a_class: attached CLASS_C; a_un_not_as: attached UN_NOT_AS)
			-- Initializes `Current' with class `a_class'. `a_un_not_as' is the unary not expression
			-- with the double negation.
		do
			make (ca_names.double_negation_fix, a_class)
			unary := a_un_not_as
		end

feature {NONE} -- Implementation

	unary: UN_NOT_AS
			-- The unary expression this fix will remove the double negation from.

	get_expression (a_expr: EXPR_AS): STRING_32
			-- Returns the expression of a double negation
		do
			if attached {PARAN_AS} a_expr as l_paran then
				Result := get_expression (l_paran.expr)
			elseif attached {UN_NOT_AS} a_expr as l_un_not then
				Result := l_un_not.expr.text_32 (match_list)
			end
		end

	execute
			-- <Precursor>
		local
			u: UTF_CONVERTER
		do
			unary.replace_text (u.string_32_to_utf_8_string_8 (get_expression(unary.expr)), match_list)
		end

end
