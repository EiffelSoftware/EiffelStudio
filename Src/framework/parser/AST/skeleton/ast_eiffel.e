note
	description: "Abstract node produce by yacc. Version for Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class AST_EIFFEL

inherit
	ANY

	REFACTORING_HELPER
		export
			{NONE} all
		end

	SHARED_ENCODING_CONVERTER
		export
			{NONE} all
		end

	INTERNAL_COMPILER_STRING_EXPORTER

feature -- Visitor

	process (v: AST_VISITOR)
			-- Visitor feature.
		require
			v_not_void: v /= Void
		deferred
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		require
			arg_non_void: other /= Void
			same_type: same_type (other)
		deferred
		end

	frozen equivalent (o1, o2: detachable AST_EIFFEL): BOOLEAN
			-- Are `o1' and `o2' equivalent ?
			-- this feature is similar to `deep_equal'
			-- but ARRAYs and STRINGs are processed correctly
			-- (`deep_equal' will compare the size of the `area')
		do
			if o1 = Void then
				Result := o2 = Void
			elseif o2 /= Void then
				if o2.same_type (o1) then
					Result := o1.is_equivalent (o2)
				else
						-- Check if one of the operands is an expression that was converted and if so
						-- we use the original expression to perform the comparison.
					if attached {CONVERTED_EXPR_AS} o2 as l_converted then
						Result := equivalent (o1, l_converted.expr)
					elseif attached {CONVERTED_EXPR_AS} o1 as l_converted then
						Result := equivalent (l_converted.expr, o2)
					end
				end
			end
		end

feature -- Location

	frozen start_location: LOCATION_AS
			-- Starting point for current construct.
		do
			if attached first_token (Void) as l_token then
				Result := l_token
			else
				Result := null_location
			end
		ensure
			start_location_not_void: Result /= Void
		end

	frozen end_location: LOCATION_AS
			-- Ending point for current construct.
		do
			if attached last_token (Void) as l_token then
				Result := l_token
			else
				Result := null_location
			end
		ensure
			end_location_not_void: Result /= Void
		end

	frozen start_position: INTEGER
			-- Starting position in UTF-8 bytes for current construct.
		do
			Result := start_location.position
		ensure
			start_position_non_negative: Result >= 0
		end

	frozen end_position: INTEGER
			-- End position in UTF-8 bytes for current construct
		do
			Result := end_location.final_position
		ensure
			end_position_non_negative: Result >= 0
		end

	frozen character_start_position: INTEGER
			-- Starting position in Unicode characters for current construct.
		do
			Result := start_location.character_position
		ensure
			start_position_non_negative: Result >= 0
		end

	frozen character_end_position: INTEGER
			-- End position in Unicode characters for current construct
		do
			Result := end_location.final_character_position
		ensure
			end_position_non_negative: Result >= 0
		end

feature -- Roundtrip/Location

	frozen complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS
			-- Absolute start location for current construct
		require
			a_list_not_void: a_list /= Void
		do
			if attached first_token (a_list) as l_token then
				Result := l_token
			else
				Result := null_location
			end
		ensure
			result_not_void: Result /= Void
		end

	frozen complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS
			-- Absolute end location for current construct
		require
			a_list_not_void: a_list /= Void
		do
			if attached last_token (a_list) as l_token then
				Result := l_token
			else
				Result := null_location
			end
		ensure
			result_not_void: Result /= Void
		end

	frozen complete_start_position (a_list: LEAF_AS_LIST): INTEGER
			-- Absolute start position in UTF-8 bytes for current construct
		require
			a_list_not_void: a_list /= Void
		do
			Result := complete_start_location (a_list).position
		end

	frozen complete_end_position (a_list: LEAF_AS_LIST): INTEGER
			-- Absolute end position in UTF-8 bytes for current construct
		require
			a_list_not_void: a_list /= Void
		do
			Result := complete_end_location (a_list).final_position
		end

	frozen complete_character_start_position (a_list: LEAF_AS_LIST): INTEGER
			-- Absolute start position in Unicode characters for current construct
		require
			a_list_not_void: a_list /= Void
		do
			Result := complete_start_location (a_list).character_position
		end

	frozen complete_character_end_position (a_list: LEAF_AS_LIST): INTEGER
			-- Absolute end position in Unicode characters for current construct
		require
			a_list_not_void: a_list /= Void
		do
			Result := complete_end_location (a_list).final_character_position
		end

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
			-- First token in current AST node
			--| Note for implementors of this routine as `last_token'.
			--| Do not rely on `a_list' non-voidness to figure out the
			--| presence or absence of information. Simply check what
			--| you want to check in logical order and if one element
			--| requires `a_list' to be not void, simply states it.
			--|
			--| FIXME: most of the redefinition of this routine do not
			--| follow the above recommendation, but instead use a if then else
			--| where one branch is taken when `a_list' is void and the other branch
			--| when it is not void.
		deferred
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
			-- Last token in current AST node
			--| Note: see comment on `last_token'.
		deferred
		end

	token_region (a_list: LEAF_AS_LIST): ERT_TOKEN_REGION
			-- Token region of current AST node
		require
			a_list_not_void: a_list /= Void
			first_token_exists: first_token (a_list) /= Void
			last_token_exists: last_token (a_list) /= Void
		do
			if
				attached first_token (a_list) as l_first and then
				attached last_token (a_list) as l_last and then
				l_first.index <= l_last.index
			then
				create Result.make (l_first.index, l_last.index)
			else
				create Result.make (1, 1)
			end
		ensure
			token_region_not_void: Result /= Void
		end

	index_of_matching_leaf (a_list: LEAF_AS_LIST; a_start_index: INTEGER; a_forward_search: BOOLEAN; a_matching: FUNCTION [LEAF_AS, BOOLEAN]): INTEGER
			-- Index of the first matching leaf for `a_matching' in `a_list' starting from
			-- `a_start_index' in the direction indicated by `a_forward_search'.
		require
			a_list_not_void: a_list /= Void
			a_start_index_valid: a_list.valid_index (a_start_index)
			a_matching_not_void: a_matching /= Void
		local
			i, nb: INTEGER
		do
			if a_forward_search then
				from
					i := a_start_index
					nb := a_list.count
				until
					i > nb
				loop
					if a_matching.item ([a_list.i_th (i)]) then
						Result := i
							-- Jump out of loop
						i := nb
					end
					i := i + 1
				end
			else
				from
					i := a_start_index
					nb := a_list.count
				until
					i = 0
				loop
					if a_matching.item ([a_list.i_th (i)]) then
						Result := i
							-- Jump out of loop
						i := 1
					end
					i := i - 1
				end
			end
		end

	index: INTEGER
			-- Index of the construct in a structure to store all tokens (including breaks and comments)
			-- that can be used to associate unambigously any information with this construct.
		deferred
		end

	frozen keyword_from_index (a_list: LEAF_AS_LIST; a_index: INTEGER): detachable KEYWORD_AS
			-- Keyword at position `a_index' in `a_list'.
		do
			if a_list.valid_index (a_index) and then attached {KEYWORD_AS} a_list.i_th (a_index) as l_keyword then
				Result := l_keyword
			end
		end

	frozen symbol_from_index (a_list: LEAF_AS_LIST; a_index: INTEGER): detachable SYMBOL_AS
			-- Symbol at position `a_index' in `a_list'.
		do
			if a_list.valid_index (a_index) and then attached {SYMBOL_AS} a_list.i_th (a_index) as l_symbol then
				Result := l_symbol
			end
		end

feature -- Roundtrip/Text modification

	can_append_text (a_list: LEAF_AS_LIST): BOOLEAN
			-- Can some text be appended to current AST node?
		require
			a_list_not_void: a_list /= Void
		do
			if first_token (a_list) /= Void and then last_token (a_list) /= Void then
				Result := a_list.valid_append_region (token_region (a_list))
			end
		end

	can_prepend_text (a_list: LEAF_AS_LIST): BOOLEAN
			-- Can some text be prepended to current AST node?
		require
			a_list_not_void: a_list /= Void
		do
			if first_token (a_list) /= Void and then last_token (a_list) /= Void then
				Result := a_list.valid_prepend_region (token_region (a_list))
			end
		end

	can_replace_text (a_list: LEAF_AS_LIST): BOOLEAN
			-- Can text of current AST node be replaced by some other text?
		require
			a_list_not_void: a_list /= Void
		do
			if first_token (a_list) /= Void and then last_token (a_list) /= Void then
				Result := a_list.valid_replace_region (token_region (a_list))
			end
		end

	can_remove_text (a_list: LEAF_AS_LIST): BOOLEAN
			-- Can text of current AST node be removed?
		require
			a_list_not_void: a_list /= Void
		do
			if first_token (a_list) /= Void and then last_token (a_list) /= Void then
				Result := a_list.valid_remove_region (token_region (a_list))
			end
		end

	is_text_available (a_list: LEAF_AS_LIST): BOOLEAN
			-- Is text of current AST node available?
		require
			a_list_not_void: a_list /= Void
		local
			r: ERT_TOKEN_REGION
		do
			if first_token (a_list) /= Void and then last_token (a_list) /= Void then
				r := token_region (a_list)
				Result := a_list.valid_region (r) and then a_list.valid_text_region (r)
			end
		end

	is_text_modified (a_list: LEAF_AS_LIST): BOOLEAN
			-- Has text of current AST node been modified?
		require
			a_list_not_void: a_list /= Void
		do
			if first_token (a_list) /= Void and then last_token (a_list) /= Void then
				Result :=  a_list.is_text_modified (token_region (a_list))
			end
		end

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Roundtrip/Text modification

	prepend_text (a_text: STRING; a_list: LEAF_AS_LIST)
			-- Prepend `a_text' to current AST node.
		require
			a_list_not_void: a_list /= Void
			a_text_not_void: a_text /= Void
			text_prependable: can_prepend_text (a_list)
		do
			a_list.prepend_region (token_region (a_list), a_text)
		end

	append_text (a_text: STRING; a_list: LEAF_AS_LIST)
			-- Append `a_text' to current AST node.
		require
			a_list_not_void: a_list /= Void
			a_text_not_void: a_text /= Void
			text_appendable: can_append_text (a_list)
		do
			a_list.append_region (token_region (a_list), a_text)
		end

	remove_text (a_list: LEAF_AS_LIST)
			-- Remove current AST node.
		require
			a_list_not_void: a_list /= Void
			text_removable: can_remove_text (a_list)
		do
			a_list.remove_region (token_region (a_list))
		end

	replace_text (a_text: STRING; a_list: LEAF_AS_LIST)
			-- Replace text of current AST node by `a_text'.
		require
			a_list_not_void: a_list /= Void
			a_text_not_void: a_text /= Void
			text_replaceable: can_replace_text (a_list)
		do
			a_list.replace_region (token_region (a_list), a_text)
		end

	replace_subtext (old_str, new_str: STRING; is_case_sensitive:BOOLEAN; a_list: LEAF_AS_LIST)
			-- Replace `old_str' by `new_str' in text of current AST node.
		require
			a_list_not_void: a_list /= Void
			old_str_not_void: old_str /= Void
			new_str_not_void: new_str /= Void
			text_replaceable: can_replace_text (a_list)
		local
			l_str: STRING
			l_index: INTEGER
			l_count: INTEGER
			l_old_str: STRING
			l_text: STRING
			a_region: ERT_TOKEN_REGION
		do
			a_region := token_region (a_list)
			l_text := a_list.text (a_region)
			if is_case_sensitive then
				l_str := l_text.string
				l_old_str := old_str
			else
					-- Convert to lower case taking Unicode into account.
				l_str := {UTF_CONVERTER}.string_32_to_utf_8_string_8
					({UTF_CONVERTER}.utf_8_string_8_to_string_32 (l_text).as_lower)
				l_old_str := {UTF_CONVERTER}.string_32_to_utf_8_string_8
					({UTF_CONVERTER}.utf_8_string_8_to_string_32 (old_str).as_lower)
			end
			l_count := old_str.count
			from
				l_index := l_str.substring_index (l_old_str, 1)
			until
				l_index = 0
			loop
				l_text.replace_substring (new_str, l_index, l_index + l_count - 1)
				l_str.replace_substring (new_str, l_index, l_index + l_count - 1)
				l_index := l_str.substring_index (l_old_str, l_index + l_count)
			end
			a_list.replace_region (a_region, l_text)
		end

feature -- Roundtrip/Text

	text_32 (a_list: LEAF_AS_LIST): STRING_32
			-- Text (with modification, if any, applied) of current AST structure
		require
			a_list_not_void: a_list /= Void
			valid_text_region: is_text_available (a_list)
		do
			Result := encoding_converter.utf8_to_utf32 (text (a_list))
		ensure
			Result_not_void: Result /= Void
		end

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Roundtrip/Text

	original_text (a_list: LEAF_AS_LIST): STRING
			-- Original text of current AST structure
		require
			a_list_not_void: a_list /= Void
			first_token_exists: first_token (a_list) /= Void
			last_token_exists: last_token (a_list) /= Void
		do
			Result := a_list.original_text (token_region (a_list))
		ensure
			Result_not_void: Result /= Void
		end

	original_text_count (a_list: LEAF_AS_LIST): INTEGER
			-- Count in bytes of original text of current AST structure
		require
			a_list_not_void: a_list /= Void
			first_token_exists: first_token (a_list) /= Void
			last_token_exists: last_token (a_list) /= Void
		do
			Result := a_list.original_text_count (token_region (a_list))
		end

	text (a_list: LEAF_AS_LIST): STRING
			-- Text (with modification, if any, applied) of current AST structure
		require
			a_list_not_void: a_list /= Void
			valid_text_region: is_text_available (a_list)
		do
			Result := a_list.text (token_region (a_list))
		ensure
			Result_not_void: Result /= Void
		end

	text_count (a_list: LEAF_AS_LIST): INTEGER
			-- Count in bytes of text (with all modification, if any, applied)
		require
			a_list_not_void: a_list /= Void
			valid_text_region: is_text_available (a_list)
		do
			Result := a_list.text_count (token_region (a_list))
		end

feature -- Roundtrip/Separator

	has_leading_separator (a_list: LEAF_AS_LIST): BOOLEAN
			-- Does any separator structure (break or semicolon) appear before current AST node?
		require
			a_list_not_void: a_list /= Void
			first_token_exists: first_token (a_list) /= Void
			last_token_exists: last_token (a_list) /= Void
			token_region_not_void: token_region (a_list) /= Void
		do
			Result := a_list.has_leading_separator (token_region (a_list))
		end

	has_trailing_separator (a_list: LEAF_AS_LIST): BOOLEAN
			-- Does any separator structure (break or semicolon) appear after current AST node?
		require
			a_list_not_void: a_list /= Void
			first_token_exists: first_token (a_list) /= Void
			last_token_exists: last_token (a_list) /= Void
			token_region_not_void: token_region (a_list) /= Void
		do
			Result := a_list.has_trailing_separator (token_region (a_list))
		end

feature {NONE} -- Constants

	null_location: LOCATION_AS
			-- Null location
		once
			create Result.make_null
		ensure
			null_location_not_void: Result /= Void and then Result.is_null
		end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
