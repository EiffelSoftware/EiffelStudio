indexing
	description: "A stub for symbol in `match_list'"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SYMBOL_STUB_AS

inherit
	SYMBOL_AS
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
			True
		do
			inspect
				code
			 when {EIFFEL_TOKENS}.te_semicolon then Result := once ";"
			 when {EIFFEL_TOKENS}.te_colon then Result := once ":"
			 when {EIFFEL_TOKENS}.te_comma then Result := once ","
			 when {EIFFEL_TOKENS}.te_dotdot then Result := once ".."
			 when {EIFFEL_TOKENS}.te_question then Result := once "?"
			 when {EIFFEL_TOKENS}.te_tilde then Result := once "~"
			 when {EIFFEL_TOKENS}.te_curlytilde then Result := once "}~"
			 when {EIFFEL_TOKENS}.te_dot then Result := once "."
			 when {EIFFEL_TOKENS}.te_address then Result := once "$"
			 when {EIFFEL_TOKENS}.te_assignment then Result := once ":="
			 when {EIFFEL_TOKENS}.te_accept then Result := once "?="
			 when {EIFFEL_TOKENS}.te_eq then Result := once "="
			 when {EIFFEL_TOKENS}.te_lt then Result := once "<"
 			 when {EIFFEL_TOKENS}.te_gt then Result := once ">"
			 when {EIFFEL_TOKENS}.te_le then Result := once "<="
 			 when {EIFFEL_TOKENS}.te_ge then Result := once ">="
			 when {EIFFEL_TOKENS}.te_ne then Result := once "/="
			 when {EIFFEL_TOKENS}.te_lparan then Result := once "("
			 when {EIFFEL_TOKENS}.te_rparan then Result := once ")"
			 when {EIFFEL_TOKENS}.te_lcurly then Result := once "{"
 			 when {EIFFEL_TOKENS}.te_rcurly then Result := once "}"
			 when {EIFFEL_TOKENS}.te_lsqure then Result := once "["
 			 when {EIFFEL_TOKENS}.te_rsqure then Result := once "]"
			 when {EIFFEL_TOKENS}.te_plus then Result := once "+"
			 when {EIFFEL_TOKENS}.te_minus then Result := once "-"
			 when {EIFFEL_TOKENS}.te_star then Result := once "*"
			 when {EIFFEL_TOKENS}.te_slash then Result := once "/"
			 when {EIFFEL_TOKENS}.te_power then Result := once "^"
			 when {EIFFEL_TOKENS}.te_constrain then Result := once "->"
			 when {EIFFEL_TOKENS}.te_bang then Result := once "!"
			 when {EIFFEL_TOKENS}.te_larray then Result := once "<<"
			 when {EIFFEL_TOKENS}.te_rarray then Result := once ">>"
			 when {EIFFEL_TOKENS}.te_div then Result := once "//"
			 when {EIFFEL_TOKENS}.te_mod then Result := once "\\"
			end
		end

end
