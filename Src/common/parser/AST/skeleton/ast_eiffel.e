indexing
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

feature -- Visitor

	process (v: AST_VISITOR) is
			-- Visitor feature.
		deferred
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		require
			arg_non_void: other /= Void
			same_type: same_type (other)
		deferred
		end

	frozen equivalent (o1, o2: AST_EIFFEL): BOOLEAN is
			-- Are `o1' and `o2' equivalent ?
			-- this feature is similar to `deep_equal'
			-- but ARRAYs and STRINGs are processed correctly
			-- (`deep_equal' will compare the size of the `area')
		do
			if o1 = Void then
				Result := o2 = Void
			else
				Result := o2 /= Void and then o2.same_type (o1) and then
					o1.is_equivalent (o2)
			end
		end

feature -- Access

	number_of_breakpoint_slots: INTEGER is
			-- Number of stop points for AST (body only)
		do
			-- Return 0 by default
		end

feature -- Location

	frozen start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			Result := first_token (Void)
			if Result = Void then
				Result := null_location
			end
		ensure
			start_location_not_void: Result /= Void
		end

	frozen end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			Result := last_token (Void)
			if Result = Void then
				Result := null_location
			end
		ensure
			end_location_not_void: Result /= Void
		end

	frozen start_position: INTEGER is
			-- Starting position for current construct.
		do
			Result := start_location.position
		ensure
			start_position_non_negative: Result >= 0
		end

	frozen end_position: INTEGER is
			-- End position for current construct
		do
			Result := end_location.final_position
		ensure
			end_position_non_negative: Result >= 0
		end

feature -- Roundtrip/Location

	frozen complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
			-- Absolute start location for current construct
		require
			a_list_not_void: a_list /= Void
		do
			Result := first_token (a_list)
			if Result = Void then
				Result := null_location
			end
		ensure
			result_not_void: Result /= Void
		end

	frozen complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
			-- Absolute end location for current construct
		require
			a_list_not_void: a_list /= Void
		do
			Result := last_token (a_list)
			if Result = Void then
				Result := null_location
			end
		ensure
			result_not_void: Result /= Void
		end

	frozen complete_start_position (a_list: LEAF_AS_LIST): INTEGER is
			-- Absolute start position for current construct
		require
			a_list_not_void: a_list /= Void
		do
			Result := complete_start_location (a_list).position
		end

	frozen complete_end_position (a_list: LEAF_AS_LIST): INTEGER is
			-- Absolute end position for current construct
		require
			a_list_not_void: a_list /= Void
		do
			Result := complete_end_location (a_list).final_position
		end

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
			-- First token in current AST node
		deferred
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
			-- Last token in current AST node
		deferred
		end

	token_region (a_list: LEAF_AS_LIST): ERT_TOKEN_REGION is
			-- Token region of current AST node
		require
			a_list_not_void: a_list /= Void
			first_token_exists: first_token (a_list) /= Void
			last_token_exists: last_token (a_list) /= Void
		do
			create Result.make (first_token (a_list).index, last_token (a_list).index)
		end

feature -- Roundtrip/Text modification

	can_append_text (a_list: LEAF_AS_LIST): BOOLEAN is
			-- Can some text be appended to current AST node?
		require
			a_list_not_void: a_list /= Void
		do
			Result := a_list.valid_append_region (token_region (a_list))
		end

	can_prepend_text (a_list: LEAF_AS_LIST): BOOLEAN is
			-- Can some text be prepended to current AST node?
		require
			a_list_not_void: a_list /= Void
		do
			Result := a_list.valid_prepend_region (token_region (a_list))
		end

	can_replace_text (a_list: LEAF_AS_LIST): BOOLEAN is
			-- Can text of current AST node be replaced by some other text?
		require
			a_list_not_void: a_list /= Void
		do
			Result := a_list.valid_replace_region (token_region (a_list))
		end

	can_remove_text (a_list: LEAF_AS_LIST): BOOLEAN is
			-- Can text of current AST node be removed?
		require
			a_list_not_void: a_list /= Void
		do
			Result := a_list.valid_remove_region (token_region (a_list))
		end

	is_text_available (a_list: LEAF_AS_LIST): BOOLEAN is
			-- Is text of current AST node available?
		require
			a_list_not_void: a_list /= Void
		do
			Result := a_list.valid_text_region (token_region (a_list))
		end

	is_text_modified (a_list: LEAF_AS_LIST): BOOLEAN is
			-- Has text of current AST node been modified?
		require
			a_list_not_void: a_list /= Void
		do
			Result :=  a_list.is_text_modified (token_region (a_list))
		end

feature -- Roundtrip/Text modification

	prepend_text (a_text: STRING; a_list: LEAF_AS_LIST) is
			-- Prepend `a_text' to current AST node.
		require
			a_list_not_void: a_list /= Void
			a_text_not_void: a_text /= Void
			text_prependable: can_prepend_text (a_list)
		do
			a_list.prepend_region (token_region (a_list), a_text)
		end

	append_text (a_text: STRING; a_list: LEAF_AS_LIST) is
			-- Append `a_text' to current AST node.
		require
			a_list_not_void: a_list /= Void
			a_text_not_void: a_text /= Void
			text_appendable: can_append_text (a_list)
		do
			a_list.append_region (token_region (a_list), a_text)
		end

	remove_text (a_list: LEAF_AS_LIST) is
			-- Remove current AST node.
		require
			a_list_not_void: a_list /= Void
			text_removable: can_remove_text (a_list)
		do
			a_list.remove_region (token_region (a_list))
		end

	replace_text (a_text: STRING; a_list: LEAF_AS_LIST) is
			-- Replace text of current AST node by `a_text'.
		require
			a_list_not_void: a_list /= Void
			a_text_not_void: a_text /= Void
			text_replaceable: can_replace_text (a_list)
		do
			a_list.replace_region (token_region (a_list), a_text)
		end

	replace_subtext (old_str, new_str: STRING; is_case_sensitive:BOOLEAN; a_list: LEAF_AS_LIST) is
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
			l_str := a_list.text (a_region)
			l_text := l_str.twin
			if not is_case_sensitive then
				l_str.to_lower
				l_old_str := old_str.as_lower
			else
				l_old_str := old_str
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

	original_text (a_list: LEAF_AS_LIST): STRING is
			-- Original text of current AST structure
		require
			a_list_not_void: a_list /= Void
		do
			Result := a_list.original_text (token_region (a_list))
		ensure
			Result_not_void: Result /= Void
		end

	original_text_count (a_list: LEAF_AS_LIST): INTEGER is
			-- Count in bytes of original text of current AST structure
		require
			a_list_not_void: a_list /= Void
		do
			Result := a_list.original_text_count (token_region (a_list))
		end

	text (a_list: LEAF_AS_LIST): STRING is
			-- Text (with modification, if any, applied) of current AST structure
		require
			a_list_not_void: a_list /= Void
			valid_text_region: is_text_available (a_list)
		do
			Result := a_list.text (token_region (a_list))
		ensure
			Result_not_void: Result /= Void
		end

	text_count (a_list: LEAF_AS_LIST): INTEGER is
			-- Count in bytes of text (with all modification, if any, applied)
		require
			a_list_not_void: a_list /= Void
		do
			Result := a_list.text_count (token_region (a_list))
		end

feature -- Roundtrip/Separator

	has_leading_separator (a_list: LEAF_AS_LIST): BOOLEAN is
			-- Does any separator structure (break or semicolon) appear before current AST node?
		require
			a_list_not_void: a_list /= Void
			token_region_not_void: token_region (a_list) /= Void
		do
			Result := a_list.has_leading_separator (token_region (a_list))
		end

	has_trailing_separator (a_list: LEAF_AS_LIST): BOOLEAN is
			-- Does any separator structure (break or semicolon) appear after current AST node?
		require
			a_list_not_void: a_list /= Void
			token_region_not_void: token_region (a_list) /= Void
		do
			Result := a_list.has_trailing_separator (token_region (a_list))
		end

feature {NONE} -- Constants

	null_location: LOCATION_AS is
			-- Null location
		once
			create Result.make_null
		ensure
			null_location_not_void: Result /= Void and then Result.is_null
		end

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
