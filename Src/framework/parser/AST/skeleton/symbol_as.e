note
	description: "Abstract description of an Eiffel symbol."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SYMBOL_AS

inherit
	LEAF_AS
		redefine
			is_separator
		end

create
	make

feature {NONE} -- Initialization

	make (a_code: INTEGER; l, c, p, s, cc, cp, cs: INTEGER)
			-- Create a symbol object with `a_code' indicating which symbol it is.
			-- See `EIFFEL_TOKENS' for more information about `a_code'
			-- `l', `c', `p', `s', `cc', `cp', `cs' are positions. See `make_with_location' for more information.
			-- This initialization feature is used in non-roundtrip mode.
		require
			a_code_valid: symbol_valid (a_code)
			l_non_negative: l >= 0
			c_non_negative: c >= 0
			p_non_negative: p >= 0
			s_non_negative: s >= 0
			cc_non_negative: cc >= 0
			cp_non_negative: cp >= 0
			cs_non_negative: cs >= 0
		do
			code := a_code
			make_with_location (l, c, p, s, cc, cp, cs)
		end

feature -- Access

	number_of_breakpoint_slots: INTEGER
		do
		end

feature -- Roundtrip

	is_separator: BOOLEAN
			-- Is current leaf AST node a separator (break or semicolon)?
		do
			Result := is_semicolon
		end

feature -- Status report

	symbol_valid (a_code: INTEGER): BOOLEAN
			-- Is `a_code' a valid symbol code?
		do
				-- FIXME: Implement this later.
			Result := True
		end

	is_semicolon: BOOLEAN
			-- Is current symbol ';'?
		do
			Result := code = {EIFFEL_TOKENS}.te_semicolon
		end

	is_colon: BOOLEAN
			-- Is current symbol ':'?
		do
			Result := code = {EIFFEL_TOKENS}.te_colon
		end

	is_comma: BOOLEAN
			-- Is current symbol ','?
		do
			Result := code = {EIFFEL_TOKENS}.te_comma
		end

	is_dotdot: BOOLEAN
			-- Is current symbol '..'?
		do
			Result := code = {EIFFEL_TOKENS}.te_dotdot
		end

	is_question_mark: BOOLEAN
			-- Is current symbol '?'?
		do
			Result := code = {EIFFEL_TOKENS}.te_question
		end

	is_tilde: BOOLEAN
			-- Is current symbol '~'?
		do
			Result := code = {EIFFEL_TOKENS}.te_tilde
		end

	is_dot: BOOLEAN
			-- Is current symbol '.'?
		do
			Result := code = {EIFFEL_TOKENS}.te_dot
		end

	is_address: BOOLEAN
			-- Is current symbol '$'?
		do
			Result := code = {EIFFEL_TOKENS}.te_address
		end

	is_assignment: BOOLEAN
			-- Is current symbol ':='?
		do
			Result := code = {EIFFEL_TOKENS}.te_assignment
		end

	is_accept: BOOLEAN
			-- Is current symbol '?='?
		do
			Result := code = {EIFFEL_TOKENS}.te_accept
		end

	is_equal_symbol: BOOLEAN
			-- Is current symbol '='?
		do
			Result := code = {EIFFEL_TOKENS}.te_eq
		end

	is_lt: BOOLEAN
			-- Is current symbol '<'?
		do
			Result := code = {EIFFEL_TOKENS}.te_lt
		end

	is_gt: BOOLEAN
			-- Is current symbol '>'?
		do
			Result := code = {EIFFEL_TOKENS}.te_gt
		end

	is_le: BOOLEAN
			-- Is current symbol '<='?
		do
			Result := code = {EIFFEL_TOKENS}.te_le
		end

	is_ge: BOOLEAN
			-- Is current symbol '>='?
		do
			Result := code = {EIFFEL_TOKENS}.te_ge
		end

	is_not_equal: BOOLEAN
			-- Is current symbol '/='?
		do
			Result := code = {EIFFEL_TOKENS}.te_ne
		end

	is_left_parenthesis: BOOLEAN
			-- Is current symbol '('?
		do
			Result := code = {EIFFEL_TOKENS}.te_lparan
		end

	is_right_parenthesis: BOOLEAN
			-- Is current symbol ')'?
		do
			Result := code = {EIFFEL_TOKENS}.te_rparan
		end

	is_left_curly: BOOLEAN
			-- Is current symbol '{'?
		do
			Result := code = {EIFFEL_TOKENS}.te_lcurly
		end

	is_right_curly: BOOLEAN
			-- Is current symbol '}'?
		do
			Result := code = {EIFFEL_TOKENS}.te_rcurly
		end

	is_left_square: BOOLEAN
			-- Is current symbol '['?
		do
			Result := code = {EIFFEL_TOKENS}.te_lsqure
		end

	is_right_square: BOOLEAN
			-- Is current symbol ']'?
		do
			Result := code = {EIFFEL_TOKENS}.te_rsqure
		end

	is_plus: BOOLEAN
			-- Is current symbol '+'?
		do
			Result := code = {EIFFEL_TOKENS}.te_plus
		end

	is_minus: BOOLEAN
			-- Is current symbol '-'?
		do
			Result := code = {EIFFEL_TOKENS}.te_minus
		end

	is_star: BOOLEAN
			-- Is current symbol '*'?
		do
			Result := code = {EIFFEL_TOKENS}.te_star
		end

	is_slash: BOOLEAN
			-- Is current symbol '/'?
		do
			Result := code = {EIFFEL_TOKENS}.te_slash
		end

	is_power: BOOLEAN
			-- Is current symbol '^'?
		do
			Result := code = {EIFFEL_TOKENS}.te_power
		end

	is_constrain: BOOLEAN
			-- Is current symbol '->'?
		do
			Result := code = {EIFFEL_TOKENS}.te_constrain
		end

	is_left_array: BOOLEAN
			-- Is current symbol '<<'?
		do
			Result := code = {EIFFEL_TOKENS}.te_larray
		end

	is_right_array: BOOLEAN
			-- Is current symbol '>>'?
		do
			Result := code = {EIFFEL_TOKENS}.te_rarray
		end

	is_div: BOOLEAN
			-- Is current symbol '//'?
		do
			Result := code = {EIFFEL_TOKENS}.te_div
		end

	is_mod: BOOLEAN
			-- Is current symbol '\\'?
		do
			Result := code = {EIFFEL_TOKENS}.te_mod
		end

feature -- Visitor

	process (v: AST_VISITOR)
		do
			v.process_symbol_as (Current)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
		do
			Result := code = other.code
		end

feature -- Symbol code

	code: INTEGER;
		-- Symbol code		

note
	ca_ignore: "CA011", "CA011: too many arguments"
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
