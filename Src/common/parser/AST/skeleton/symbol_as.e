indexing
	description: "Abstract description of an Eiffel symbol"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SYMBOL_AS

inherit
	LEAF_AS

create
	make, make_with_data

feature -- Initialization

	make (a_code: INTEGER; a_scn: EIFFEL_SCANNER) is
			-- Create a symbol_as object with `a_code' and information included in `a_scn'.
		require
			a_code_valid: symbol_valid (a_code)
			a_scn_not_void: a_scn /= Void
		local
			l_str: STRING
		do
			l_str := a_scn.text
			set_shared_text (a_scn)
			code := a_code
			make_with_location (a_scn.line, a_scn.column, a_scn.position, l_str.count)
		end

	make_with_data (a_code: INTEGER; l, c, p, s: INTEGER) is
			-- Create a symbol object with `a_code' indicating which symbol it is.
			-- See `EIFFEL_TOKENS' for more information about `a_code'
			-- `l', `c', `p', `s' are positions. See `make_with_location' for more information.
			-- This initialization feature is used in non-roundtrip mode.
		require
			a_code_valid: symbol_valid (a_code)
			l_non_negative: l >= 0
			c_non_negative: c >= 0
			p_non_negative: p >= 0
			s_non_negative: s >= 0
		do
			--code := a_code
			make_with_location (l, c, p, s)
		end

feature -- Access

	number_of_breakpoint_slots: INTEGER is
		do
		end

feature -- Status report

	symbol_valid (a_code: INTEGER): BOOLEAN is
			-- Is `a_code' a valid symbol code?
		do
				-- FIXME: Implement this later.
			Result := True
		end

	is_semicolon: BOOLEAN is
			-- Is current symbol ';'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_semicolon)
		end

	is_colon: BOOLEAN is
			-- Is current symbol ':'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_colon)
		end

	is_comma: BOOLEAN is
			-- Is current symbol ','?
		do
			Result := (code = {EIFFEL_TOKENS}.te_comma)
		end

	is_dotdot: BOOLEAN is
			-- Is current symbol '..'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_dotdot)
		end

	is_question_mark: BOOLEAN is
			-- Is current symbol '?'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_question)
		end

	is_tilde: BOOLEAN is
			-- Is current symbol '~'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_tilde)
		end

	is_curly_tilde: BOOLEAN is
			-- Is current symbol '}~'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_curlytilde)
		end

	is_dot: BOOLEAN is
			-- Is current symbol '.'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_dot)
		end

	is_address: BOOLEAN is
			-- Is current symbol '$'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_address)
		end

	is_assignment: BOOLEAN is
			-- Is current symbol ':='?
		do
			Result := (code = {EIFFEL_TOKENS}.te_assignment)
		end

	is_accept: BOOLEAN is
			-- Is current symbol '?='?
		do
			Result := (code = {EIFFEL_TOKENS}.te_accept)
		end

	is_equal_symbol: BOOLEAN is
			-- Is current symbol '='?
		do
			Result := (code = {EIFFEL_TOKENS}.te_eq)
		end

	is_lt: BOOLEAN is
			-- Is current symbol '<'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_lt)
		end

	is_gt: BOOLEAN is
			-- Is current symbol '>'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_gt)
		end

	is_le: BOOLEAN is
			-- Is current symbol '<='?
		do
			Result := (code = {EIFFEL_TOKENS}.te_le)
		end

	is_ge: BOOLEAN is
			-- Is current symbol '>='?
		do
			Result := (code = {EIFFEL_TOKENS}.te_ge)
		end

	is_not_equal: BOOLEAN is
			-- Is current symbol '/='?
		do
			Result := (code = {EIFFEL_TOKENS}.te_ne)
		end

	is_left_parenthesis: BOOLEAN is
			-- Is current symbol '('?
		do
			Result := (code = {EIFFEL_TOKENS}.te_lparan)
		end

	is_right_parenthesis: BOOLEAN is
			-- Is current symbol ')'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_rparan)
		end

	is_left_curly: BOOLEAN is
			-- Is current symbol '{'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_lcurly)
		end

	is_right_curly: BOOLEAN is
			-- Is current symbol '}'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_rcurly)
		end

	is_left_square: BOOLEAN is
			-- Is current symbol '['?
		do
			Result := (code = {EIFFEL_TOKENS}.te_lsqure)
		end

	is_right_square: BOOLEAN is
			-- Is current symbol ']'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_rsqure)
		end

	is_plus: BOOLEAN is
			-- Is current symbol '+'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_plus)
		end

	is_minus: BOOLEAN is
			-- Is current symbol '-'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_minus)
		end

	is_star: BOOLEAN is
			-- Is current symbol '*'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_star)
		end

	is_slash: BOOLEAN is
			-- Is current symbol '/'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_slash)
		end

	is_power: BOOLEAN is
			-- Is current symbol '^'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_power)
		end

	is_constrain: BOOLEAN is
			-- Is current symbol '->'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_constrain)
		end

	is_bang: BOOLEAN is
			-- Is current symbol '!'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_bang)
		end

	is_left_array: BOOLEAN is
			-- Is current symbol '<<'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_larray)
		end

	is_right_array: BOOLEAN is
			-- Is current symbol '>>'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_rarray)
		end

	is_div: BOOLEAN is
			-- Is current symbol '//'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_div)
		end

	is_mod: BOOLEAN is
			-- Is current symbol '\\'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_mod)
		end

feature -- Visitor

	process (v: AST_VISITOR) is
		do
			v.process_symbol_as (Current)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
		do
			Result := is_equal (other)
		end

feature{NONE} -- Implementation

	code: INTEGER
		-- Symbol code		

end
