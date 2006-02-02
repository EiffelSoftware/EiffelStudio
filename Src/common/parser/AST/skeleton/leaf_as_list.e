indexing
	description: "[
					AST leaf list for roundtrip parser.
				    It is a list to store terminals (or leaves) in a source file. When a file gets parsed, every token
				    is stored in this list, so it is a tokenized source file.

					Storage:
					    There are two kinds of terminals:
						 1. terminals that are not attached in AST: breaks (including comments, spaces and new-line characters and semicolons
						 2. terminals that are attached in AST: all other terminals, like keywords, identifiers and symbols except semicolons

						For every symbol terminal (both attached and non-attached), a `SYMBOL_STUB_AS' object is stored in list,
						For every other attached terminal, a `LEAF_STUB_AS' object is stored in list.
						For a break, a `BREAK_AS' object is stored in list.
				  ]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LEAF_AS_LIST

inherit

	IDABLE
		rename
			id as class_id,
			set_id as set_class_id
		end

create
	make

feature
	make (a_trunk_number: INTEGER) is
			-- Initialize
		require
			a_trunk_number_positive: a_trunk_number > 0
		do
			create trunks.make (a_trunk_number)
			create current_trunk.make (trunk_size)
			trunks.extend (current_trunk)
			count := 0
			in_trunk_count := 0
			modifier_applied := True
		end

feature -- Element change

	extend (a_leaf: LEAF_AS) is
			-- Extend `a_leaf' into current list.
		require
			a_leaf_not_void: a_leaf /= Void
			a_leaf_index_positive: a_leaf.index > 0
		do
			if in_trunk_count = trunk_size then
				create current_trunk.make (trunk_size)
				trunks.extend (current_trunk)
				in_trunk_count := 0
			end
			current_trunk.put (a_leaf, in_trunk_count)
			in_trunk_count := in_trunk_count + 1
			count := count + 1
		end

feature -- Access

	i_th alias "[]", infix "@" (i: INTEGER): LEAF_AS is
			-- Entry at index `i', if in index interval
		require
			i_valid: valid_index (i)
		local
			j: INTEGER
		do
			j := i - 1
			Result := trunks.i_th (j // trunk_size + 1).item (j \\ trunk_size)
		end

	first: LEAF_AS is
			-- First element in list
		require
			list_not_empty: count > 0
		do
			Result := trunks.i_th (1).item (0)
		end

	last: LEAF_AS is
			-- Last element in list
		require
			list_not_empty: count > 0
		do
			Result := current_trunk.item (in_trunk_count - 1)
		end

feature -- Status reporting

	valid_index (i: INTEGER): BOOLEAN is
			-- Is `i' a valid index?
		do
			Result := (1 <= i) and (i <= count)
		end

	count: INTEGER
			-- Number of items in current list

	capacity: INTEGER is
			-- Capacity of current
		do
			Result := trunk_count * trunk_size
		ensure
			Result_set: Result = trunk_count * trunk_size
		end

feature -- Status reporting

	current_trunk: SPECIAL [LEAF_AS]
			-- Current trunk

	trunk_count: INTEGER is
			-- Count of trunks
		do
			Result := trunks.count
		end

	in_trunk_count: INTEGER
			-- Count in `current_trunk'

feature{NONE} -- Implementation

	trunks: ARRAYED_LIST [like current_trunk]
			-- List of trunks of tokens

	trunk_size: INTEGER is 1000
			-- Initial size of every trunk

	initial_trunk_number: INTEGER is 10
			-- Initial number of trunks

feature -- Status

	generated: INTEGER
			-- Timestamp when this matchlist was generated.

feature -- Status update

	set_generated (a_timestamp: INTEGER) is
			-- Set the timestamp when this matchlist was generated.
		do
			generated := a_timestamp
		end


feature -- Item searching

	item_by_start_position (start_pos: INTEGER): LEAF_AS is
			-- Item in `Current' whose `start_position' equals to `start_pos'
			-- Return Void if no item in `Current' satisfies.
		local
			l_left, l_right, l_middle: INTEGER
			done: BOOLEAN
			l_pos: INTEGER
		do
			l_left := 1
			l_right := count
			from

			until
				l_left > l_right or done
			loop
				l_middle := (l_left + l_right) // 2
				l_pos := i_th (l_middle).complete_start_position (Current)
				if l_pos = start_pos then
					Result := i_th (l_middle)
					done := True
				elseif start_pos > l_pos then
					l_left := l_middle + 1
				else
					l_right := l_middle - 1
				end
			end
		end

	item_by_end_position (end_pos: INTEGER): LEAF_AS is
			-- Item in `Current' whose `end_position' equals to `end_pos'
			-- Return Void if no item in `Current' satisfies.
		local
			l_left, l_right, l_middle: INTEGER
			done: BOOLEAN
			l_pos: INTEGER
		do
			l_left := 1
			l_right := count
			from

			until
				l_left > l_right or done
			loop
				l_middle := (l_left + l_right) // 2
				l_pos := i_th (l_middle).complete_end_position (Current)
				if l_pos = end_pos then
					Result := i_th (l_middle)
					done := True
				elseif end_pos > l_pos then
					l_left := l_middle + 1
				else
					l_right := l_middle - 1
				end
			end
		end

	item_by_position (a_pos: INTEGER): LEAF_AS is
			-- Item in `Current' between which `a_pos' is located
			-- Return Void if no item in `Current' satisfies.
		local
			l_left, l_right, l_middle: INTEGER
			done: BOOLEAN
			l_start_pos: INTEGER
			l_end_pos: INTEGER
		do
			l_left := 1
			l_right := count
			from

			until
				l_left > l_right or done
			loop
				l_middle := (l_left + l_right) // 2
				l_start_pos := i_th (l_middle).complete_start_position (Current)
				l_end_pos := i_th (l_middle).complete_end_position (Current)

				if a_pos >= l_start_pos and a_pos <= l_end_pos then
					Result := i_th (l_middle)
					done := True
				elseif a_pos > l_end_pos then
					l_left := l_middle + 1
				else
					l_right := l_middle - 1
				end
			end
		end

feature -- Region validity

	valid_region (a_region: ERT_TOKEN_REGION):BOOLEAN is
			-- Is `a_region' valid?
		require
			a_region_not_void: a_region /= Void
		do
			Result := a_region.start_index > 0 and a_region.end_index >= a_region.start_index and a_region.end_index <= count
		end

	valid_text_region (a_region: ERT_TOKEN_REGION):BOOLEAN is
			-- Is `a_region' valid to get text?
		require
			a_region_not_void: a_region /= Void
			valid_region: valid_region (a_region)
		local
			l_list: like active_modifier_list
		do
			l_list := active_modifier_list
			if l_list.is_empty then
				Result := True
			else
				Result := l_list.for_all (agent {ERT_REGION_MODIFIER}.is_text_available (a_region))
			end
		end

	valid_append_region (a_region: ERT_TOKEN_REGION):BOOLEAN is
			-- Is `a_region' valid to append some text to?
		require
			a_region_not_void: a_region /= Void
			valid_region: valid_region (a_region)
		local
			l_list: like active_modifier_list
		do
			l_list := active_modifier_list
			if l_list.is_empty then
				Result := True
			else
				Result := l_list.for_all (agent {ERT_REGION_MODIFIER}.can_append (a_region))
			end
		end

	valid_prepend_region (a_region: ERT_TOKEN_REGION):BOOLEAN is
			-- Is `a_region' valid to prepend some text to?
		require
			a_region_not_void: a_region /= Void
			valid_region: valid_region (a_region)
		local
			l_list: like active_modifier_list
		do
			l_list := active_modifier_list
			if l_list.is_empty then
				Result := True
			else
				Result := l_list.for_all (agent {ERT_REGION_MODIFIER}.can_prepend (a_region))
			end
		end

	valid_replace_region (a_region: ERT_TOKEN_REGION):BOOLEAN is
			-- Is `a_region' valid to be replaced by some other text?
		require
			a_region_not_void: a_region /= Void
			valid_region: valid_region (a_region)
		local
			l_list: like active_modifier_list
		do
			l_list := active_modifier_list
			if l_list.is_empty then
				Result := True
			else
				Result := l_list.for_all (agent {ERT_REGION_MODIFIER}.can_replace (a_region))
			end
		end

	valid_remove_region (a_region: ERT_TOKEN_REGION):BOOLEAN is
			-- Is `a_region' valid to be removed?
		require
			a_region_not_void: a_region /= Void
			valid_region: valid_region (a_region)
		local
			l_list: like active_modifier_list
		do
			l_list := active_modifier_list
			if l_list.is_empty then
				Result := True
			else
				Result := l_list.for_all (agent {ERT_REGION_MODIFIER}.can_remove (a_region))
			end
		end

feature -- Text modification

	prepend_region (a_region: ERT_TOKEN_REGION; a_text: STRING) is
			-- Prepend `a_text' to `a_region'.
			-- A prepend modifier will be registered.
		require
			a_region_not_void: a_region /= Void
			valid_region: valid_region (a_region)
			valid_prepend_region: valid_prepend_region (a_region)
			all_existing_modifiers_applied: modifier_applied
		local
			l_modifier: ERT_PREPEND_REGION_MODIFIER
		do
			create l_modifier.make (modifier_list.count + 1, a_region, a_text)
			register_modifier (l_modifier)
			l_modifier.apply (Current)
		end

	append_region (a_region: ERT_TOKEN_REGION; a_text: STRING) is
			-- Append `a_text' to `a_region'.
			-- An append modifier will be registered.			
		require
			a_region_not_void: a_region /= Void
			valid_region: valid_region (a_region)
			valid_append_region: valid_append_region (a_region)
			all_existing_modifiers_applied: modifier_applied
		local
			l_modifier: ERT_APPEND_REGION_MODIFIER
		do
			create l_modifier.make (modifier_list.count + 1, a_region, a_text)
			register_modifier (l_modifier)
			l_modifier.apply (Current)
		end

	replace_region (a_region: ERT_TOKEN_REGION; a_text: STRING) is
			-- Prepend `a_region' by `a_text'.
			-- A replace modifier will be registered.			
		require
			a_region_not_void: a_region /= Void
			valid_region: valid_region (a_region)
			valid_replace_region: valid_replace_region (a_region)
			all_existing_modifiers_applied: modifier_applied
		local
			l_modifier: ERT_REPLACE_REGION_MODIFIER
		do
			create l_modifier.make (modifier_list.count + 1, a_region, a_text)
			register_modifier (l_modifier)
			l_modifier.apply (Current)
		end

	remove_region (a_region: ERT_TOKEN_REGION) is
			-- Remove `a_region'.
			-- A remove modifier will be registered.			
		require
			a_region_not_void: a_region /= Void
			valid_region: valid_region (a_region)
			valid_remove_region: valid_remove_region (a_region)
			all_existing_modifiers_applied: modifier_applied
		local
			l_modifier: ERT_REMOVE_REGION_MODIFIER
		do
			create l_modifier.make (modifier_list.count + 1, a_region)
			register_modifier (l_modifier)
			l_modifier.apply (Current)
		end

feature -- Text status

	is_text_modified (a_region: ERT_TOKEN_REGION): BOOLEAN is
			-- Has text in `a_region' been modified?
		require
			a_region_not_void: a_region /= Void
			valid_region: valid_region (a_region)
		do
			Result := active_modifier_list.for_all (agent {ERT_REGION_MODIFIER}.is_region_disjoint (a_region))
		end

feature -- Text

	original_text (a_region: ERT_TOKEN_REGION): STRING is
			-- Original text of `a_region'
		require
			a_region_not_void: a_region /= Void
			valid_region: valid_region (a_region)
		local
			i: INTEGER
		do
			create Result.make (256)
			from
				i := a_region.start_index
			until
				i > a_region.end_index
			loop
				Result.append (i_th (i).literal_text (Void))
				i := i + 1
			end
		end

	original_text_count (a_region: ERT_TOKEN_REGION): INTEGER is
			-- Original text count of `a_region'
		require
			a_region_not_void: a_region /= Void
			valid_region: valid_region (a_region)
		local
			i: INTEGER
		do
			from
				i := a_region.start_index
				Result := 0
			until
				i > a_region.end_index
			loop
				Result := Result + i_th (i).literal_text (Void).count
				i := i + 1
			end
		end

	text (a_region: ERT_TOKEN_REGION): STRING is
			-- Text (with all modifications, if any, applied) of `a_region'
		require
			a_region_not_void: a_region /= Void
			valid_region: valid_region (a_region)
			valid_text_region: valid_text_region (a_region)
		local
			i: INTEGER
			l_end: INTEGER
			l_str: STRING
		do
			create Result.make (256)
			from
				i := a_region.start_index
				l_end := a_region.end_index
			until
				i > l_end
			loop
				l_str := final_token_text (i)
				if not l_str.is_empty then
					Result.append (l_str)
				end
				i := i + 1
			end
		ensure
			Result_not_void: Result /= Void
		end

	text_count (a_region: ERT_TOKEN_REGION): INTEGER is
			-- Text (with all modifications, if any, applied) count of `a_region'
		require
			a_region_not_void: a_region /= Void
			valid_region: valid_region (a_region)
			valid_text_region: valid_text_region (a_region)
		do
			Result := text (a_region).count
		ensure
			Result_non_negative: Result >= 0
		end

feature -- Text/Separator

	has_leading_separator (a_region: ERT_TOKEN_REGION): BOOLEAN is
			-- Is there any separator structure (break or semicolon) appears before `a_region'?
		require
			a_region_not_void: a_region /= Void
			valid_region: valid_region (a_region)
		do
			if a_region.start_index > 1 then
				Result := i_th (a_region.start_index - 1).is_separator
			else
				Result := False
			end
		end

	has_trailing_separator (a_region: ERT_TOKEN_REGION): BOOLEAN is
			-- Is there any separator structure (break or semicolon) appears after `a_region'?
		require
			a_region_not_void: a_region /= Void
			valid_region: valid_region (a_region)
		do
			if a_region.end_index < count then
				Result := i_th (a_region.end_index + 1).is_separator
			else
				Result := False
			end
		end

	has_comment (a_region: ERT_TOKEN_REGION): BOOLEAN is
			-- Is there any comment within `a_region'?
		require
			a_region_not_void: a_region /= Void
			valid_region: valid_region (a_region)
		local
			i: INTEGER
			l_cnt: INTEGER
			l_break: BREAK_AS
		do
			from
				i := a_region.start_index
				l_cnt := a_region.end_index
				Result := False
			until
				i > l_cnt or Result
			loop
				l_break ?= i_th (i)
				if l_break /= Void then
					Result := l_break.has_comment
				end
				i := i + 1
			end
		end

feature -- Modifier operation

	modifier_count: INTEGER is
			-- Count of registered modifiers
		do
			Result := modifier_list.count
		ensure
			Result_non_negative: Result >= 0
		end

	modifier (i: INTEGER): ERT_REGION_MODIFIER is
			-- `i'-th registered modifier
		require
			valid_i: i >0 and i <= modifier_count
		do
			Result := modifier_list.i_th (i)
		ensure
			Result_set: Result = modifier_list.i_th (i)
		end


	remove_last_modifier is
			-- Remove last registered modifier.
		require
			modifiers_not_applied: not modifier_applied
		do
			if not modifier_list.is_empty then
				modifier_list.finish
				modifier_list.remove
			end
		end

	undo_modifications is
			-- Undo all applied modifications to text.
		require
			all_existing_modifiers_applied: modifier_applied
		do
			active_modifier_list.wipe_out
			active_prepend_modifier_list.wipe_out
			active_append_modifier_list.wipe_out
			token_text_table.clear_all
			if not modifier_list.is_empty then
				modifier_list.do_all (agent {ERT_REGION_MODIFIER}.reset_applied)
			end
			modifier_applied := False
		ensure
			active_modifier_list_set: active_modifier_list.is_empty
			active_prepend_modifier_list_set: active_prepend_modifier_list.is_empty
			active_append_modifier_list_set: active_append_modifier_list.is_empty
			modifier_not_applied: not modifier_applied
		end

	redo_modifications is
			-- Redo all registered modifications to text.
		require
			modifiers_not_applied: not modifier_applied
		do
			if not modifier_list.is_empty then
				modifier_list.do_all (agent {ERT_REGION_MODIFIER}.apply (Current))
			end
			modifier_applied := True
		ensure
			modifier_applied: modifier_applied
		end

	modifier_applied: BOOLEAN
			-- Have all modifiers been applied to current?

	is_modifier_registered (a_modifier: ERT_REGION_MODIFIER): BOOLEAN is
			-- Is `a_modifier' registered?
		require
			a_modifier_not_void: a_modifier /= Void
		do
			Result := modifier_list.has (a_modifier)
		end

feature -- Comment extraction

	extract_comment (a_region: ERT_TOKEN_REGION): EIFFEL_COMMENTS is
			-- Extract all comments from `a_region'.
			-- Only comments in `original_text' will be extracted.
		require
			a_region_not_void: a_region /= Void
			valid_region: valid_region (a_region)
		local
			i: INTEGER
			n: INTEGER
			l_break: BREAK_AS
			l_cmt_list: EIFFEL_COMMENTS
		do
			create Result.make
			from
				i := a_region.start_index
				n := a_region.end_index
			until
				i > n
			loop
				l_break ?= i_th (i)
				if l_break /= Void then
					l_cmt_list := l_break.extract_comment
					if not l_cmt_list.is_empty then
						Result.finish
						Result.merge_right (l_cmt_list)
					end
				end
				i := i + 1
			end
		end

feature -- Status reporting

	if_all_in_region (a_region: ERT_TOKEN_REGION; test: FUNCTION [ANY, TUPLE [LEAF_AS], BOOLEAN]): BOOLEAN is
			-- Do all tokens in `a_region' satisfy `test'?
		require
			a_region_not_void: a_region /= Void
			valid_region: valid_region (a_region)
		local
			l_start_index: INTEGER
			l_end_index: INTEGER
		do
			from
				l_start_index := a_region.start_index
				l_end_index := a_region.end_index
				Result := True
			until
				l_start_index > l_end_index or not Result
			loop
				test.call ([i_th (l_start_index)])
				Result := test.last_result
				l_start_index := l_start_index + 1
			end
		end

	if_any_in_region (a_region: ERT_TOKEN_REGION; test: FUNCTION [ANY, TUPLE [LEAF_AS], BOOLEAN]): BOOLEAN is
			-- Does any token in `a_region' satisfy `test'?
		require
			a_region_not_void: a_region /= Void
			valid_region: valid_region (a_region)
		local
			l_start_index: INTEGER
			l_end_index: INTEGER
		do
			from
				l_start_index := a_region.start_index
				l_end_index := a_region.end_index
				Result := False
			until
				l_start_index > l_end_index or Result
			loop
				test.call ([i_th (l_start_index)])
				Result := test.last_result
				l_start_index := l_start_index + 1
			end
		end

feature{NONE} -- Implementation

	modifier_list: LINKED_LIST [ERT_REGION_MODIFIER] is
			-- List of modifiers
		do
			if internal_modifier_list = Void then
				create internal_modifier_list.make
			end
			Result := internal_modifier_list
		ensure
			Result_not_void: Result /= Void
		end

	register_modifier (a_modifier: ERT_REGION_MODIFIER) is
			-- Register `a_modifier' in current.
		require
			a_modifier_not_void: a_modifier /= Void
		do
			check
				not modifier_list.has (a_modifier)
			end
			modifier_list.extend (a_modifier)
		end

feature{ERT_REGION_MODIFIER} -- Implementation

	active_modifier_list: like modifier_list is
			-- List of active modifiers
		do
			if internal_active_modifier_list = Void then
				create internal_active_modifier_list.make
			end
			Result := internal_active_modifier_list
		ensure
			Result_not_void: Result /= Void
		end

	active_prepend_modifier_list: SORTED_TWO_WAY_LIST [ERT_PREPEND_REGION_MODIFIER] is
			-- List of active prepend modifiers
		do
			if internal_prepend_modifier_list = Void then
				create internal_prepend_modifier_list.make
			end
			Result := internal_prepend_modifier_list
		ensure
			Result_not_void: Result /= Void
		end

	active_append_modifier_list: SORTED_TWO_WAY_LIST [ERT_APPEND_REGION_MODIFIER] is
			-- List of active prepend modifiers
		do
			if internal_append_modifier_list = Void then
				create internal_append_modifier_list.make
			end
			Result := internal_append_modifier_list
		ensure
			Result_not_void: Result /= Void
		end

	set_token_text (a_index: INTEGER; a_text: STRING) is
			-- Set text of `a_index'-th token with `a_text'.
		require
			valid_index: valid_index (a_index)
			a_text_not_void: a_text /= Void
		do
			token_text_table.force (a_text, a_index)
		ensure
			token_text_set: token_text_table.has (a_index) and token_text_table.item (a_index).is_equal (a_text)
		end

feature{NONE} -- Implementation

	final_token_text (a_index: INTEGER): STRING is
			-- Final text of a token specified by `a_index' with all modification applied, if any.
		require
			valid_index: valid_index (a_index)
		local
			l_prepended, l_appended: STRING
		do
			create Result.make (100)
			l_prepended := prepended_token_text (a_index)
			if not l_prepended.is_empty then
				Result.append (l_prepended)
			end
			if token_text_table.has (a_index) then
				Result.append (token_text_table.item (a_index))
			else
				Result.append (i_th (a_index).literal_text (Void))
			end
			l_appended := appended_token_text (a_index)
			if not l_appended.is_empty then
				Result.append (l_appended)
			end
		ensure
			Result_not_void: Result /= Void
		end

	prepended_token_text (a_index: INTEGER): STRING is
			--	All prepended text of token specified by `a_index'
		require
			valid_index: valid_index (a_index)
		local
			l_list: like active_prepend_modifier_list
		do
			l_list := active_prepend_modifier_list
			if l_list.is_empty or else l_list.first.start_index > a_index then
				Result := ""
			else
				from
					l_list.start
					create Result.make (100)
				until
					l_list.after or l_list.item.start_index > a_index
				loop
					if l_list.item.is_prepended_to (a_index) then
						Result.append (l_list.item.text)
					end
					l_list.forth
				end
			end
		end

	appended_token_text (a_index: INTEGER): STRING is
			--	All appended text of token specified by `a_index'
		require
			valid_index: valid_index (a_index)
		local
			l_list: like active_append_modifier_list
		do
			l_list := active_append_modifier_list
			if l_list.is_empty or else l_list.first.end_index > a_index then
				Result := ""
			else
				from
					l_list.start
					create Result.make (100)
				until
					l_list.after or l_list.item.end_index > a_index
				loop
					if l_list.item.is_appended_to (a_index) then
						Result.append (l_list.item.text)
					end
					l_list.forth
				end
			end
		end

feature{NONE} -- Implementation

	internal_modifier_list: like modifier_list
			-- List of modifiers

	internal_active_modifier_list: like active_modifier_list
			-- List of active modifiers

	internal_token_text_table: like token_text_table
			-- Hashtable to store all tokens whose text has been changed

	internal_prepend_modifier_list: like active_prepend_modifier_list
			-- List of active prepend modifiers

	internal_append_modifier_list: like active_append_modifier_list
			-- List of active append modifiers

	token_text_table: HASH_TABLE [STRING, INTEGER] is
			-- Hashtable to store all tokens whose text has been changed
		do
			if internal_token_text_table = Void then
				create internal_token_text_table.make (100)
			end
			Result := internal_token_text_table
		ensure
			Result_not_void: Result /= Void
		end

invariant
	trunks_not_void: trunks /= Void
	trunks_not_empty: not trunks.is_empty

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
