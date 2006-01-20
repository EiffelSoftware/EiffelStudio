indexing
	description: "A stub for symbol in `match_list'"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SYMBOL_STUB_AS

inherit
	SYMBOL_AS
		rename
			make as symbol_make
		undefine
			literal_text, is_equivalent, number_of_breakpoint_slots
		redefine
			process
		end

	LEAF_STUB_AS
		rename
			make as leaf_stub_make
		undefine
			is_separator
		redefine
			process, literal_text
		end

create
	make

feature

	make (a_code: INTEGER; l, c, p, n: INTEGER) is
			-- New SYMBOL_STUB AST node with `a_code' and location specified in `l', `c', `p' and `n'.
		require
			a_code_valid: symbol_valid (a_code)
			l_non_negative: l >= 0
			c_non_negative: c >= 0
			p_non_negative: p >= 0
			n_non_negative: n >= 0
		do
			code := a_code
			set_position (l, c, p, n)
		end


feature -- Visitor

	process (v: AST_VISITOR) is
			-- Visitor feature.
		do
			v.process_symbol_stub_as (Current)
		end

feature -- Text

	literal_text (a_list: LEAF_AS_LIST): STRING is
			-- Literal text of this token
		require else
			a_list_can_be_void: a_list = Void
		do
			inspect
				code
			 when {EIFFEL_TOKENS}.te_semicolon then Result := ";"
			 when {EIFFEL_TOKENS}.te_colon then Result := ":"
			 when {EIFFEL_TOKENS}.te_comma then Result := ","
			 when {EIFFEL_TOKENS}.te_dotdot then Result := ".."
			 when {EIFFEL_TOKENS}.te_question then Result := "?"
			 when {EIFFEL_TOKENS}.te_tilde then Result := "~"
			 when {EIFFEL_TOKENS}.te_curlytilde then Result := "}~"
			 when {EIFFEL_TOKENS}.te_dot then Result := "."
			 when {EIFFEL_TOKENS}.te_address then Result := "$"
			 when {EIFFEL_TOKENS}.te_assignment then Result := ":="
			 when {EIFFEL_TOKENS}.te_accept then Result := "?="
			 when {EIFFEL_TOKENS}.te_eq then Result := "="
			 when {EIFFEL_TOKENS}.te_lt then Result := "<"
 			 when {EIFFEL_TOKENS}.te_gt then Result := ">"
			 when {EIFFEL_TOKENS}.te_le then Result := "<="
 			 when {EIFFEL_TOKENS}.te_ge then Result := ">="
			 when {EIFFEL_TOKENS}.te_ne then Result := "/="
			 when {EIFFEL_TOKENS}.te_lparan then Result := "("
			 when {EIFFEL_TOKENS}.te_rparan then Result := ")"
			 when {EIFFEL_TOKENS}.te_lcurly then Result := "{"
 			 when {EIFFEL_TOKENS}.te_rcurly then Result := "}"
			 when {EIFFEL_TOKENS}.te_lsqure then Result := "["
 			 when {EIFFEL_TOKENS}.te_rsqure then Result := "]"
			 when {EIFFEL_TOKENS}.te_plus then Result := "+"
			 when {EIFFEL_TOKENS}.te_minus then Result := "-"
			 when {EIFFEL_TOKENS}.te_star then Result := "*"
			 when {EIFFEL_TOKENS}.te_slash then Result := "/"
			 when {EIFFEL_TOKENS}.te_power then Result := "^"
			 when {EIFFEL_TOKENS}.te_constrain then Result := "->"
			 when {EIFFEL_TOKENS}.te_bang then Result := "!"
			 when {EIFFEL_TOKENS}.te_larray then Result := "<<"
			 when {EIFFEL_TOKENS}.te_rarray then Result := ">>"
			 when {EIFFEL_TOKENS}.te_div then Result := "//"
			 when {EIFFEL_TOKENS}.te_mod then Result := "\\"
			end
		end

end
