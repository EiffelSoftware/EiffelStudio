note
	description: "Objects that allows to acces a C struct of type lconv defined in locale.h"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_LOCALE_CONV

feature --Struct localeconv

	localeconv: POINTER
			-- Pointer to `struct lconv' area.
			--the C localeconv() function shall set the components of an object with
			-- the type struct lconv with the values appropriate for the formatting
			-- of numeric quantities (monetary and otherwise)
			-- according to the rules of the current locale.
		external
			"C (): EIF_POINTER| <locale.h>"
		alias
			"localeconv"
		end

feature -- Information

	lconv_structure_size: INTEGER
			-- Size of `struct tm'.
		external
			"C macro use <locale.h>"
		alias
			"sizeof(struct lconv)"
		end

feature -- Access

	decimal_point (p: POINTER): POINTER
			-- Get `p->decimal_point'
			-- The radix character used to format non-monetary quantities.
		external
			"C struct struct lconv access decimal_point use <locale.h>"
		end

	thousands_sep (p: POINTER): POINTER
			-- Get `p->thousands_sep'
			-- The character used to separate groups of digits
			-- before the decimal-point character in formatted non-monetary quantities.
		external
			"C struct struct lconv access thousands_sep use <locale.h>"
		end

	grouping (p: POINTER): POINTER
			-- Get `p->grouping'
			-- A string whose elements taken as one-byte integer values indicate
			-- the size of each group of digits in formatted non-monetary quantities.
		external
			"C struct struct lconv access grouping use <locale.h>"
		end

	int_curr_symbol (p: POINTER): POINTER
			-- Get `p->int_curr_symbol'
			-- The international currency symbol applicable to the current locale.
			-- The first three characters contain the alphabetic international currency symbol
			-- in accordance with those specified in the ISO 4217:1995 standard.
			-- The fourth character (immediately preceding the null byte) is the character
			-- used to separate the international currency symbol from the monetary quantity.
		external
			"C struct struct lconv access int_curr_symbol use <locale.h>"
		end

	currency_symbol (p: POINTER): POINTER
			-- Get `p->currency_symbol'
			-- The local currency symbol applicable to the current locale.
		external
			"C struct struct lconv access currency_symbol use <locale.h>"
		end

	mon_decimal_point (p: POINTER): POINTER
			-- Get `p->mon_decimal_point'
			--  The radix character used to format monetary quantities.
		external
			"C struct struct lconv access mon_decimal_point use <locale.h>"
		end

	mon_thousands_sep (p: POINTER): POINTER
			-- Get `p->mon_thousands_sep'
			-- The separator for groups of digits before
			-- the decimal-point in formatted monetary quantities.
		external
			"C struct struct lconv access mon_thousands_sep use <locale.h>"
		end

	mon_grouping (p: POINTER): POINTER
			-- Get `p->mon_grouping'
			-- A string whose elements taken as one-byte
			-- integer values indicate the size of each group of digits
			-- in formatted monetary quantities.	
		external
			"C struct struct lconv access mon_grouping use <locale.h>"
		end

	positive_sign (p: POINTER): POINTER
			-- Get `p->positive_sign'
			-- The string used to indicate a non-negative
			-- valued formatted monetary quantity.
		external
			"C struct struct lconv access positive_sign use <locale.h>"
		end

	negative_sign (p: POINTER): POINTER
			-- Get `p->negative_sign'
			-- The string used to indicate a negative
			-- valued formatted monetary quantity.
		external
			"C struct struct lconv access negative_sign use <locale.h>"
		end

	int_frac_digits (p: POINTER): CHARACTER
			-- Get `p->int_frac_digits'
			-- The number of fractional digits (those after the decimal-point)
			-- to be displayed in an internationally formatted monetary quantity.
			-- returnd character to be interpreted as integer
			-- NOTE: if not available in current locale, Result = {CHARACTER_8].Max_value
		external
			"C struct struct lconv access int_frac_digits use <locale.h>"
		end

	frac_digits (p: POINTER): CHARACTER
			-- Get `p->frac_digits'
			-- The number of fractional digits (those after the decimal-point)
			-- to be displayed in a formatted monetary quantity.
			-- returnd character to be interpreted as integer
			-- NOTE: if not available in current locale, Result = {CHARACTER_8].Max_value
		external
			"C struct struct lconv access frac_digits use <locale.h>"
		end

	p_cs_precedes (p: POINTER): CHARACTER
			-- Get `p->p_cs_precedes'
			-- Set to 1 if the currency_symbol precedes the value
			-- for a non-negative formatted monetary quantity.
			-- Set to 0 if the symbol succeeds the value.
			-- NOTE: if not available in current locale, Result = {CHARACTER_8].Max_value
		external
			"C struct struct lconv access p_cs_precedes use <locale.h>"
		end

	p_sep_by_space (p: POINTER): CHARACTER
			-- Get `p->p_sep_by_space'
			-- Set to a value indicating the separation of the currency_symbol,
			-- the sign string, and the value for a non-negative formatted monetary quantity.
			-- NOTE: if not available in current locale, Result = {CHARACTER_8].Max_value
		external
			"C struct struct lconv access p_sep_by_space use <locale.h>"
		end

	n_cs_precedes (p: POINTER): CHARACTER
			-- Get `p->n_cs_precedes'
			-- Set to 1 if the currency_symbol precedes the value
			-- for a negative formatted monetary quantity.
			-- Set to 0 if the symbol succeeds the value.
			-- NOTE: if not available in current locale, Result = {CHARACTER_8].Max_value
		external
			"C struct struct lconv access n_cs_precedes use <locale.h>"
		end

	n_sep_by_space (p: POINTER): CHARACTER
			-- Get `p->n_sep_by_space'
			-- Set to 1 if the currency_symbol precedes the value
			-- for a negative formatted monetary quantity.
			-- Set to 0 if the symbol succeeds the value.
			-- NOTE: if not available in current locale, Result = {CHARACTER_8].Max_value
		external
			"C struct struct lconv access n_sep_by_space use <locale.h>"
		end

	p_sign_posn (p: POINTER): CHARACTER
			-- Get `p->p_sign_posn'
			-- Set to a value indicating the positioning of the positive_sign
			-- for a non-negative formatted monetary quantity.
			-- NOTE: if not available in current locale, Result = {CHARACTER_8].Max_value
		external
			"C struct struct lconv access p_sign_posn use <locale.h>"
		end

	n_sign_posn (p: POINTER): CHARACTER
			-- Get `p->n_sign_posn'
			-- Set to a value indicating the positioning of the negative_sign
			-- for a negative formatted monetary quantity.
			-- NOTE: if not available in current locale, Result = {CHARACTER_8].Max_value
		external
			"C struct struct lconv access n_sign_posn use <locale.h>"
		end

--	int_p_cs_precedes (p: POINTER): CHARACTER is
			-- Get `p->int_p_cs_precedes'
--			-- Set to 1 or 0 if the int_curr_symbol respectively precedesor succeeds
--			-- the value for a non-negative internationally formatted monetary quantity.
--		external
--			"C struct struct lconv access int_p_cs_precedes use <locale.h>"
--		end

--	int_n_cs_precedes (p: POINTER): CHARACTER is
			-- Get `p->int_n_cs_precedes'
--			-- Set to 1 or 0 if the int_curr_symbol respectively precedes or succeeds
--			-- the value for a negative internationally formatted monetary quantity.
--		external
--			"C struct struct lconv access int_n_cs_precedes use <locale.h>"
--		end

-- 	int_p_sep_by_space (p: POINTER): CHARACTER is
			-- Get `p->int_p_sep_by_space'
-- 			-- Set to a value indicating the separation of the int_curr_symbol,
-- 			-- the sign string, and the value for a non-negative internationally formatted monetary quantity.
--		external
--			"C struct struct lconv access int_p_sep_by_space use <locale.h>"
--		end

-- 	int_n_sep_by_space (p: POINTER): CHARACTER is
			-- Get `p->int_n_sep_by_space'
--	 		-- Set to a value indicating the separation of the int_curr_symbol,
--	 		-- the sign string, and the value for a negative internationally formatted monetary quantity.
--		external
--			"C struct struct lconv access int_n_sep_by_space use <locale.h>"
--		end

-- 	int_p_sign_posn (p: POINTER): CHARACTER is
			-- Get `p->int_p_sign_posn'
-- 			-- Set to a value indicating the positioning of the positive_sign
--			-- for a non-negative internationally formatted monetary quantity.
--		external
--			"C struct struct lconv access int_p_sign_posn use <locale.h>"
--		end

--	int_n_sign_posn (p: POINTER): CHARACTER is
--			-- Get `p->int_n_sign_posn'
--			-- Set to a value indicating the positioning of the negative_sign
--			--for a negative internationally formatted monetary quantity.
--		external
--			"C struct struct lconv access int_n_sign_posn use <locale.h>"
--		end
note
	library:   "Internationalization library"
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- Class Locale Conv
