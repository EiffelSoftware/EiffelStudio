note
	description: "Abstract class for Eiffel types. Version for Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class TYPE_AS

inherit
	AST_EIFFEL

feature -- Roundtrip

	lcurly_symbol_index, rcurly_symbol_index: INTEGER
			-- Index in a match list for tokens.

	attachment_mark_index: INTEGER
			-- Index of attachment symbol (if any)

	variance_mark_index: INTEGER
			-- Index of variant symbol (if any)

	separate_mark_index: INTEGER
			-- Index of separate symbol (if any)

	lcurly_symbol (a_list: LEAF_AS_LIST): detachable SYMBOL_AS
			-- Left curly symbol(s) associated with this structure if any.
		require
			a_list_not_void: a_list /= Void
		do
			Result := symbol_from_index (a_list, lcurly_symbol_index)
		end

	rcurly_symbol (a_list: LEAF_AS_LIST): detachable SYMBOL_AS
			-- Right curly symbol(s) associated with this structure
			-- Maybe none, or maybe only left curly appears.
		require
			a_list_not_void: a_list /= Void
		do
			Result := symbol_from_index (a_list, rcurly_symbol_index)
		end

	attachment_mark (a_list: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Attachment mark (if any).
		local
			i: INTEGER
		do
			i := attachment_mark_index
			if a_list.valid_index (i) then
				Result := {KEYWORD_AS} / a_list.i_th (i)
			end
		end

	variance_mark (a_list: LEAF_AS_LIST): detachable LEAF_AS
			-- Variance mark (if any).
			-- Use `variance_symbol' or `variance_keyword' for specific representation.
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := variance_mark_index
			if a_list.valid_index (i) and then attached a_list [i] as m then
				Result := m
			end
		ensure
			result_attached: (attached Result) = (attached variance_symbol (a_list) or attached variance_keyword (a_list))
			result_consistent: Result = variance_symbol (a_list) or Result = variance_keyword (a_list)
		end

	variance_symbol (a_list: LEAF_AS_LIST): detachable SYMBOL_AS
			-- Variance symbol (if any).
			-- Use `variance_mark' if variance status in a form of keyword is respected.
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := variance_mark_index
			if a_list.valid_index (i) and then attached {SYMBOL_AS} a_list.i_th (i) as s then
				Result := s
			end
		end

	variance_keyword (a_list: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Variance keyword (if any).
			-- Use `variance_mark' if variance status in a form of symbol is respected.
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := variance_mark_index
			if a_list.valid_index (i) and then attached {KEYWORD_AS} a_list.i_th (i) as k then
				Result := k
			end
		end

	separate_keyword (a_list: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Separate keyword (if any).
		require
			a_list_attached: attached a_list
		local
			i: INTEGER
		do
			i := separate_mark_index
			if a_list.valid_index (i) and then attached {KEYWORD_AS} a_list.i_th (i) as k then
				Result := k
			end
		end

feature -- Settings

	set_lcurly_symbol (s_as: detachable SYMBOL_AS)
			-- Set `lcurly_symbol' with `s_as'.
		do
			if s_as /= Void then
				lcurly_symbol_index := s_as.index
			end
		ensure
			lcurly_symbol_index_set: s_as /= Void implies lcurly_symbol_index = s_as.index
		end

	set_rcurly_symbol (s_as: detachable SYMBOL_AS)
			-- Set `rcurly_symbol' with `s_as'.
		do
			if s_as /= Void then
				rcurly_symbol_index := s_as.index
			end
		ensure
			rcurly_symbol_index_set: s_as /= Void implies rcurly_symbol_index = s_as.index
		end

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if attached a_list then
				if lcurly_symbol_index /= 0 then
					Result := lcurly_symbol (a_list)
				elseif attachment_mark_index /= 0 then
					Result := attachment_mark (a_list)
				elseif variance_mark_index /= 0 then
					Result := variance_mark (a_list)
				elseif separate_mark_index /= 0 then
					Result := separate_keyword (a_list)
				end
			end
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if a_list /= Void and rcurly_symbol_index /= 0 then
				Result := rcurly_symbol (a_list)
			end
		end

feature -- Status

	has_attached_mark: BOOLEAN
			-- Is attached mark specified?

	has_detachable_mark: BOOLEAN
			-- Is detachable mark specified?

	has_new_attachment_mark_syntax: BOOLEAN
			-- Are `attached' and `detachable' keywords used?

	has_separate_mark: BOOLEAN
			-- Is separate mark specified?

	has_frozen_mark: BOOLEAN
			-- Is frozen mark specified?

	has_variant_mark: BOOLEAN
			-- Is variant mark specified?

	has_anchor: BOOLEAN
			-- Does this type involve an anchor?
		do
				-- False by default.
		end

	is_fixed: BOOLEAN
			-- Is current type fixed, i.e. does not change in any descendant class?
		do
				-- False by default.
		end

feature -- Comparison

	has_same_marks (other: TYPE_AS): BOOLEAN
			-- Are type marks of `Current' and `other' the same?
		require
			other_attached: attached other
		do
			Result :=
				other.has_attached_mark = has_attached_mark and then
				other.has_detachable_mark = has_detachable_mark and then
				other.has_separate_mark = has_separate_mark and then
				other.has_frozen_mark = has_frozen_mark and then
				other.has_variant_mark = has_variant_mark
		end

feature -- Modification

	set_attachment_mark (m: detachable LEAF_AS; a: like has_attached_mark; d: like has_detachable_mark)
		require
			correct_attachment_status: not (a and d)
			meaningfull_attachment_mark: (m /= Void) implies (a or d)
		do
			if m = Void then
				attachment_mark_index := 0
			else
				attachment_mark_index := m.index
			end
			has_attached_mark := a
			has_detachable_mark := d
		ensure
			attachment_mark_set: (m = Void implies attachment_mark_index = 0) and then (m /= Void implies attachment_mark_index = m.index)
			has_attached_mark_set: has_attached_mark = a
			has_detachable_mark_set: has_detachable_mark = d
		end

	set_variance_mark (m: detachable LEAF_AS; f: like has_frozen_mark; v: like has_variant_mark)
		require
			correct_variant_status: not (f and v)
			meaningfull_variant_mark: (m /= Void) implies (f or v)
		do
			if m = Void then
				variance_mark_index := 0
			else
				variance_mark_index := m.index
			end
			has_frozen_mark := f
			has_variant_mark := v
		ensure
			variant_mark_set: (m = Void implies variance_mark_index = 0) and then (m /= Void implies variance_mark_index = m.index)
			has_frozen_mark_set: has_frozen_mark = f
			has_variant_mark_set: has_variant_mark = v
		end

	set_separate_mark (m: detachable LEAF_AS)
		do
			if m = Void then
				separate_mark_index := 0
			else
				separate_mark_index := m.index
			end
			has_separate_mark := True
		ensure
			separate_mark_set: (m = Void implies separate_mark_index = 0) and then (m /= Void implies separate_mark_index = m.index)
			has_separate_mark_set: has_separate_mark
		end

feature -- Output

	dump: STRING
			-- Dumped trace
		deferred
		end

	dump_marks (s: STRING)
			-- Append attachment, variant and separate marks (if any) to `s'.
		require
			s_attached: attached s
		do
			if has_frozen_mark then
				s.append_string ("frozen ")
			elseif has_variant_mark then
				s.append_string ("variant ")
			end
			if has_attached_mark then
				s.append_string ("attached ")
			elseif has_detachable_mark then
				s.append_string ("detachable ")
			end
			if has_separate_mark then
				s.append_string ("separate ")
			end
		end

note
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
