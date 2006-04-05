indexing
	description: "A stub for symbol in `match_list'"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end
