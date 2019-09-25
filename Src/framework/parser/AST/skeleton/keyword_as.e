note
	description: "Abstract description of an Eiffel keyword"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	KEYWORD_AS

inherit
	LEAF_AS

create
	make_null,
	make_with_location

create {INTERNAL_COMPILER_STRING_EXPORTER}
	make

feature{NONE} -- Initialization

	make (a_code: INTEGER; a_text: STRING; l, c, p, n, cc, cp, cn: INTEGER)
			-- Create an keyword object with `a_code' indicating which keyword it is.
			-- See `EIFFEL_TOKENS' for more information about `a_code'
			-- `a_text' is the literal text of this keyword in source code.
			-- `l', `c', `p', `s', `cc', `cp', `cs' are positions. See `make_with_location' for more information.
		require
			a_code_valid: keyword_valid (a_code)
			a_text_not_void: a_text /= Void
			a_text_not_empty: not a_text.is_empty
		do
			code := a_code
			make_with_location (l, c, p, n, cc, cp, cn)
		end

feature -- Status report

	keyword_valid (a_code: INTEGER): BOOLEAN
			-- Is `a_code' a valid keyword code?
		do
				-- FIXME: Implement this later.
			Result := True
		end

	is_agent_keyword: BOOLEAN
			-- Is current keyword 'agent'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_agent)
		end

	is_alias_keyword: BOOLEAN
			-- Is current keyword 'alias'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_alias)
		end

	is_all_keyword: BOOLEAN
			-- Is current keyword 'all'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_all)
		end

	is_and_keyword: BOOLEAN
			-- Is current keyword 'and'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_and)
		end

	is_as_keyword: BOOLEAN
			-- Is current keyword 'as'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_as)
		end

	is_assign_keyword: BOOLEAN
			-- Is current keyword 'assign'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_assign)
		end

	is_check_keyword: BOOLEAN
			-- Is current keyword 'check'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_check)
		end

	is_class_keyword: BOOLEAN
			-- Is current keyword 'class'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_class)
		end

	is_convert_keyword: BOOLEAN
			-- Is current keyword 'convert'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_convert)
		end

	is_create_keyword: BOOLEAN
			-- Is current keyword 'create'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_create)
		end

	is_creation_keyword: BOOLEAN
			-- Is current keyword 'creation'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_creation)
		end

	is_current_keyword: BOOLEAN
			-- Is current keyword 'current'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_current)
		end

	is_debug_keyword: BOOLEAN
			-- Is current keyword 'debug'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_debug)
		end

	is_deferred_keyword: BOOLEAN
			-- Is current keyword 'deferred'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_deferred)
		end

	is_do_keyword: BOOLEAN
			-- Is current keyword 'do'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_do)
		end

	is_else_keyword: BOOLEAN
			-- Is current keyword 'else'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_else)
		end

	is_elseif_keyword: BOOLEAN
			-- Is current keyword 'elseif'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_elseif)
		end

	is_end_keyword: BOOLEAN
			-- Is current keyword 'end'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_end)
		end

	is_ensure_keyword: BOOLEAN
			-- Is current keyword 'ensure'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_ensure)
		end

	is_expanded_keyword: BOOLEAN
			-- Is current keyword 'expanded'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_expanded)
		end

	is_export_keyword: BOOLEAN
			-- Is current keyword 'export'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_export)
		end

	is_external_keyword: BOOLEAN
			-- Is current keyword 'external'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_external)
		end

	is_false_keyword: BOOLEAN
			-- Is current keyword 'false'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_false)
		end

	is_feature_keyword: BOOLEAN
			-- Is current keyword 'feature'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_feature)
		end

	is_from_keyword: BOOLEAN
			-- Is current keyword 'from'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_from)
		end

	is_frozen_keyword: BOOLEAN
			-- Is current keyword 'frozen'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_frozen)
		end

	is_partial_class_keyword: BOOLEAN
			-- Is current keyword 'partial[ \n\r\t]*class'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_partial_class)
		end

	is_if_keyword: BOOLEAN
			-- Is current keyword 'if'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_if)
		end

	is_implies_keyword: BOOLEAN
			-- Is current keyword 'implies'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_implies)
		end

	is_indexing_keyword: BOOLEAN
			-- Is current keyword 'indexing'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_indexing)
		end

	is_inherit_keyword: BOOLEAN
			-- Is current keyword 'inherit'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_inherit)
		end

	is_inspect_keyword: BOOLEAN
			-- Is current keyword 'inspect'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_inspect)
		end

	is_invariant_keyword: BOOLEAN
			-- Is current keyword 'invariant'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_invariant)
		end

	is_is_keyword: BOOLEAN
			-- Is current keyword 'is'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_is)
		end

	is_like_keyword: BOOLEAN
			-- Is current keyword 'like'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_like)
		end

	is_local_keyword: BOOLEAN
			-- Is current keyword 'local'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_local)
		end

	is_loop_keyword: BOOLEAN
			-- Is current keyword 'loop'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_loop)
		end

	is_not_keyword: BOOLEAN
			-- Is current keyword 'not'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_not)
		end

	is_note_keyword: BOOLEAN
			-- Is current keyword 'note'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_note)
		end

	is_obsolete_keyword: BOOLEAN
			-- Is current keyword 'obsolete'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_obsolete)
		end

	is_old_keyword: BOOLEAN
			-- Is current keyword 'old'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_old)
		end

	is_once_keyword: BOOLEAN
			-- Is current keyword 'once'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_once)
		end

	is_or_keyword: BOOLEAN
			-- Is current keyword 'or'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_or)
		end

	is_precursor_keyword: BOOLEAN
			-- Is current keyword 'precursor'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_precursor)
		end

	is_redefine_keyword: BOOLEAN
			-- Is current keyword 'redefine'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_redefine)
		end

	is_reference_keyword: BOOLEAN
			-- Is current keyword 'reference'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_reference)
		end

	is_rename_keyword: BOOLEAN
			-- Is current keyword 'rename'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_rename)
		end

	is_require_keyword: BOOLEAN
			-- Is current keyword 'require'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_require)
		end

	is_rescue_keyword: BOOLEAN
			-- Is current keyword 'rescue'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_rescue)
		end

	is_result_keyword: BOOLEAN
			-- Is current keyword 'result'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_result)
		end

	is_retry_keyword: BOOLEAN
			-- Is current keyword 'retry'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_retry)
		end

	is_select_keyword: BOOLEAN
			-- Is current keyword 'select'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_select)
		end

	is_separate_keyword: BOOLEAN
			-- Is current keyword 'separate'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_separate)
		end

	is_strip_keyword: BOOLEAN
			-- Is current keyword 'strip'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_strip)
		end

	is_then_keyword: BOOLEAN
			-- Is current keyword 'then'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_then)
		end

	is_true_keyword: BOOLEAN
			-- Is current keyword 'true'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_true)
		end

	is_undefine_keyword: BOOLEAN
			-- Is current keyword 'undefine'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_undefine)
		end

	is_unique_keyword: BOOLEAN
			-- Is current keyword 'unique'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_unique)
		end

	is_until_keyword: BOOLEAN
			-- Is current keyword 'until'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_until)
		end

	is_variant_keyword: BOOLEAN
			-- Is current keyword 'variant'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_variant)
		end

	is_void_keyword: BOOLEAN
			-- Is current keyword 'void'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_void)
		end

	is_when_keyword: BOOLEAN
			-- Is current keyword 'when'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_when)
		end

	is_xor_keyword: BOOLEAN
			-- Is current keyword 'xor'?
		do
			Result := (code = {EIFFEL_TOKENS}.te_xor)
		end

feature -- Access

	set_code (a_code: INTEGER)
			-- Set `code' with `a_code'.
		require
			a_code_valid: keyword_valid (a_code)
		do
			code := a_code
		ensure
			code_set: code = a_code
		end

feature -- Visitor

	process (v: AST_VISITOR)
		do
			v.process_keyword_as (Current)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
		do
			Result := code = other.code
		end

feature -- Implemenation

	code: INTEGER;
		-- Keyword code	

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software"
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
