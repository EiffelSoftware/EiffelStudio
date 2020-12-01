note

	description: "Abstract node for Iteration part of a loop."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class ITERATION_AS

inherit
	AST_EIFFEL

create
	make_keyword,
	make_symbolic

feature {NONE} -- Initialization

	make_keyword (a: like across_keyword; e: like expression; b: like as_keyword; i: like identifier; r: BOOLEAN)
			-- Create a new ITERATION AST node for an iteration part of a loop in the form
			-- "across `e` as `i`" -- when `not r`;
			-- "across `e` is `i`" -- when `r`.
		require
			e_attached: e /= Void
			i_attached: i /= Void
		do
			if a /= Void then
				across_keyword_or_bar_symbol_index := a.index
			end
			if b /= Void then
				as_keyword_or_in_symbol_index := b.index
			end
			make (e, i, r)
		ensure
			across_keyword_set: a /= Void implies across_keyword_or_bar_symbol_index = a.index
			expression_set: expression = e
			as_keyword_set: b /= Void implies as_keyword_or_in_symbol_index = b.index
			identifier_set: identifier = i
			is_restricted_set: is_restricted = r
		end

	make_symbolic (i: like identifier; a: like in_symbol; e: like expression; b: like bar_symbol)
			-- Create a new ITERATION AST node for an iteration part of a loop in the form
			-- "`i` ∈ `e` |".
		require
			e_attached: e /= Void
			i_attached: i /= Void
		do
			if attached a then
				as_keyword_or_in_symbol_index := a.index
			end
			if attached b then
				across_keyword_or_bar_symbol_index := b.index
			end
			make (e, i, True)
			is_symbolic := True
		ensure
			identifier_set: identifier = i
			in_symbol_set: attached a implies as_keyword_or_in_symbol_index = a.index
			expression_set: expression = e
			bar_symbol_set: attached b implies across_keyword_or_bar_symbol_index = b.index
		end

	make (e: like expression; i: like identifier; r: BOOLEAN)
			-- Initialize a new ITERATION AST node for an iteration part of a loop in the form
			-- "across `e` as `i`" -- when `not r`;
			-- "across `e` is `i`"  or "∀ `i`: `e` ¦" -- when `r`.
		require
			e_attached: e /= Void
			i_attached: i /= Void
		do
			expression := e
			identifier := i
				-- Build initialization code in the form
				--    `identifier'.start
			create {INSTR_CALL_AS} initialization.initialize (
				create {NESTED_EXPR_AS}.initialize (
					create {EXPR_CALL_AS}.initialize (create {ACCESS_ID_AS}.make_inline_local (i)),
					create_access_feat_as ("start", i),
					Void
			))
				-- Build exit condition in the form
				--    `identifier'.after
			create {EXPR_CALL_AS} exit_condition.initialize (
				create {NESTED_EXPR_AS}.initialize (
					create {EXPR_CALL_AS}.initialize (create {ACCESS_ID_AS}.make_inline_local (i)),
					create_access_feat_as ("after", i),
					Void
			))
				-- Build advance code in the form
				--    `identifier'.forth
			create {INSTR_CALL_AS} advance.initialize (
				create {NESTED_EXPR_AS}.initialize (
					create {EXPR_CALL_AS}.initialize (create {ACCESS_ID_AS}.make_inline_local (i)),
					create_access_feat_as ("forth", i),
					Void
			))
			if r then
					-- Build advance code in the form
					--    `identifier'.item
				create {EXPR_CALL_AS} item.initialize (
				create {NESTED_EXPR_AS}.initialize (
					create {EXPR_CALL_AS}.initialize (create {ACCESS_ID_AS}.make_inline_local (i)),
						create_access_feat_as ("item", i),
						Void
				))
			end
		ensure
			expression_set: expression = e
			identifier_set: identifier = i
		end

feature -- Access

	create_access_feat_as (n: STRING; i: like identifier): ACCESS_FEAT_AS
			-- Create a new node for a feature call of name `n'
			-- using the given ID `i' for location information.
		require
			i_attached: attached i
		local
			f: like identifier
		do
			f := i.twin
			f.set_name (n)
			create Result.initialize (f, Void)
		ensure
			result_attached: attached Result
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- Process current element.
		do
			v.process_iteration_as (Current)
		end

feature -- Roundtrip

	is_symbolic: BOOLEAN
			-- Is symbolic form of the iteration used?

	across_keyword_or_bar_symbol_index, as_keyword_or_in_symbol_index: INTEGER
			-- Index of keyword "across" and "as" associated with this structure.

	across_keyword (a_list: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Keyword "across" associated with this structure.
		require
			not is_symbolic
			a_list_attached: a_list /= Void
		local
			i: INTEGER
		do
			i := across_keyword_or_bar_symbol_index
			if a_list.valid_index (i) then
				Result := {KEYWORD_AS} / a_list [i]
			end
		end

	bar_symbol (a_list: LEAF_AS_LIST): detachable SYMBOL_AS
			-- Symbol "¦" associated with this structure.
		require
			is_symbolic
			a_list_attached: a_list /= Void
		local
			i: INTEGER
		do
			i := across_keyword_or_bar_symbol_index
			if a_list.valid_index (i) then
				Result := {SYMBOL_AS} / a_list [i]
			end
		end

	as_keyword (a_list: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Keyword "as" associated with this structure.
		require
			not is_symbolic
			a_list_attached: a_list /= Void
		local
			i: INTEGER
		do
			i := as_keyword_or_in_symbol_index
			if a_list.valid_index (i) then
				Result := {KEYWORD_AS} / a_list [i]
			end
		end

	in_symbol (a_list: LEAF_AS_LIST): detachable SYMBOL_AS
			-- Symbol ":" associated with this structure.
		require
			is_symbolic
			a_list_attached: a_list /= Void
		local
			i: INTEGER
		do
			i := as_keyword_or_in_symbol_index
			if a_list.valid_index (i) then
				Result := {SYMBOL_AS} / a_list [i]
			end
		end

	index: INTEGER
			-- <Precursor>
		do
			Result := across_keyword_or_bar_symbol_index
		end

feature -- Attributes

	expression: EXPR_AS
			-- Expression of iteration.

	identifier: ID_AS
			-- Cursor of iteration.

	is_restricted: BOOLEAN
			-- Does the iteration use a restricted form for an iteration variable?
			-- (I.e. the iteration uses "is" instead of "as".)
		do
			Result := attached item
		end

feature -- AST used during code generation

	initialization: INSTRUCTION_AS
			-- Instruction to initialize iteration.
			-- (Generated automatically to allow for subsequent checks in inherited code
			-- that refers to the original class and routine IDs.)

	exit_condition: EXPR_AS
			-- Exit condition for the iteration part only.
			-- (Generated automatically to allow for subsequent checks in inherited code
			-- that refers to the original class and routine IDs.)

	advance: INSTRUCTION_AS
			-- Instruction to advance the loop.
			-- (Generated automatically to allow for subsequent checks in inherited code
			-- that refers to the original class and routine IDs.)

	item: detachable EXPR_AS
			-- Access to an item for a restricted form of a loop.
			-- See `is_restricted`.
			-- (Generated automatically to allow for subsequent checks in inherited code
			-- that refers to the original class and routine IDs.)

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if is_symbolic then
				Result := identifier.first_token (a_list)
			else
				if attached a_list then
					Result := across_keyword (a_list)
				end
				if not attached Result then
					Result := expression.first_token (a_list)
				end
			end
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if is_symbolic then
				if attached a_list then
					Result := bar_symbol (a_list)
				end
				if not attached Result then
					Result := expression.last_token (a_list)
				end
			else
				Result := identifier.last_token (a_list)
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object?
		do
			Result := equivalent (expression, other.expression) and then
				equivalent (identifier, other.identifier) and then
				is_symbolic = other.is_symbolic and then
				is_restricted = other.is_restricted
		end

invariant
	expression_attached: expression /= Void
	identifier_attached: identifier /= Void
	initialization_attached: initialization /= Void
	exit_condition_attached: exit_condition /= Void
	advance_attached: advance /= Void
	item_attached_if_restricted: attached item = is_restricted
	restricted_if_symbolic: is_symbolic implies is_restricted

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
