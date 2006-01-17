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
			Result := complete_start_location (Void)
		ensure
			start_location_not_void: Result /= Void
		end

	frozen end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			Result := complete_end_location (Void)
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

feature -- Roundtrip

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
			-- Absolute start location for current construct
		deferred
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
			-- Absolute end location for current construct
		deferred
		end

	frozen complete_start_position (a_list: LEAF_AS_LIST): INTEGER is
			-- Absolute start position for current construct
		do
			Result := complete_start_location (a_list).position
		end

	frozen complete_end_position (a_list: LEAF_AS_LIST): INTEGER is
			-- Absolute end position for current construct
		do
			Result := complete_end_location (a_list).final_position
		end

	original_text (a_list: LEAF_AS_LIST): STRING is
			-- Original text of `Current' AST structure
		require
			a_list_not_void: a_list /= Void
		do
			Result := a_list.original_text (complete_start_position (a_list), complete_end_position (a_list))
		ensure
			Result_not_void: Result /= Void
		end

	original_text_count (a_list: LEAF_AS_LIST): INTEGER is
			-- Count in bytes of original text of `Current' AST structure
		require
			a_list_not_void: a_list /= Void
		do
			Result := complete_end_position (a_list) - complete_start_position (a_list) + 1
		end

	text (a_list: LEAF_AS_LIST): STRING is
			-- Text (with modification applied, if any) of `Current' AST structure
		require
			a_list_not_void: a_list /= Void
		do
			Result := a_list.text (complete_start_position (a_list), complete_end_position (a_list))
		ensure
			Result_not_void: Result /= Void
		end

	text_count (a_list: LEAF_AS_LIST): INTEGER is
			-- Count in bytes of text (with all modification, if any, applied to)
		require
			a_list_not_void: a_list /= Void
		do
			Result := text (a_list).count
		end

	can_add_text (a_pos: INTEGER; a_list: LEAF_AS_LIST): BOOLEAN is
			-- Can `a_text' be added at `a_pos' of `Current' AST structure?
		require
			a_list_not_void: a_list /= Void
		do
			Result := a_pos >= 1 and a_pos <= original_text_count (a_list) and
					 a_list.valid_add_position (complete_start_position (a_list) + a_pos - 1)
		end

	add_text (a_text: STRING; a_pos: INTEGER; a_list: LEAF_AS_LIST) is
			-- Add `a_text' at `a_pos' position from start of `Current' AST structure.
		require
			a_list_not_void: a_list /= Void
			a_text_not_void: a_text /= Void
			can_add_text: can_add_text (a_pos, a_list)
		do
			a_list.put_add (complete_start_position (a_list) + a_pos - 1,  a_text)
		end

	can_remove_text (start_pos, end_pos: INTEGER; a_list: LEAF_AS_LIST): BOOLEAN is
			-- Can text from `start_pos' to `end_pos' be removed?
		require
			a_list_not_void: a_list /= Void
		local
			l_start_pos: INTEGER
		do
			l_start_pos := complete_start_position (a_list)
			Result := start_pos >=1 and end_pos >=1 and end_pos <= original_text_count (a_list) and
					 a_list.valid_del_position (l_start_pos + start_pos - 1, l_start_pos + end_pos - 1)
		end

	can_remove_all_text (a_list: LEAF_AS_LIST): BOOLEAN is
			-- Can all text of `Current' node be removed?
		require
			a_list_not_void: a_list /= Void
		do
			Result := can_remove_text (1, original_text_count (a_list), a_list)
		end

	remove_text (start_pos, end_pos: INTEGER; a_list: LEAF_AS_LIST) is
			-- Remove text of `current' AST node from `start_pos' to `end_pos'.
		require
			a_list_not_void: a_list /= Void
			position_valid: can_remove_text (start_pos, end_pos, a_list)
		local
			l_start_pos: INTEGER
		do
			l_start_pos := complete_start_position (a_list)
			a_list.put_del (l_start_pos + start_pos - 1, l_start_pos + end_pos - 1)
		end

	remove_all_text (a_list: LEAF_AS_LIST) is
			-- Remove all text of `currnt' AST node.
		require
			a_list_not_void: a_list /= Void
			can_remove: can_remove_text (1, original_text_count (a_list), a_list)
		do
			remove_text (1, original_text_count (a_list), a_list)
		end

	can_replace_text (start_pos, end_pos: INTEGER; a_list: LEAF_AS_LIST): BOOLEAN is
			-- Can text from `start_pos' to `end_pos' of `current' AST node be replaced by some other text?
		require
			a_list_not_void: a_list /= Void
		do
			Result :=  can_add_text (start_pos, a_list) and can_remove_text (start_pos, end_pos, a_list)
		end

	can_replace_all_text (a_list: LEAF_AS_LIST): BOOLEAN is
			-- Can all text of `Current' node be replaced by some other text?
		require
			a_list_not_void: a_list /= Void
		do
			Result := can_replace_text (1, original_text_count (a_list), a_list)
		end

	replace_text (a_text: STRING; start_pos, end_pos: INTEGER; a_list: LEAF_AS_LIST) is
			-- Replace text from `start_pos' to `end_pos' of `current' AST node by `a_text'.
		require
			a_text_not_void: a_text /= Void
			position_valid: can_replace_text (start_pos, end_pos, a_list)
		local
			l_start_pos: INTEGER
		do
			l_start_pos := complete_start_position (a_list)
			a_list.put_replace (l_start_pos + start_pos - 1, l_start_pos + end_pos - 1, a_text)
		end

	replace_all_text (a_text: STRING; a_list: LEAF_AS_LIST) is
			-- Replace all text of current node with `a_text'.
		require
			a_text_not_void: a_text /= Void
			a_list_not_void: a_list /= Void
			can_replace: can_replace_text (1, original_text_count (a_list), a_list)
		do
			replace_text (a_text, 1, original_text_count (a_list), a_list)
		end

	sub_text (start_pos, end_pos: INTEGER; a_list: LEAF_AS_LIST): STRING is
			-- Text from `start_pos' to `end_pos' of `current' AST node
		require
			a_list_not_void: a_list /= Void
			position_valid: start_pos >= 1 and end_pos <= original_text_count (a_list) and start_pos <= end_pos
		local
			l_start_pos: INTEGER
		do
			l_start_pos := complete_start_position (a_list)
			Result := a_list.text (l_start_pos + start_pos -1, l_start_pos + end_pos - 1)
		end

	sub_original_text (start_pos, end_pos: INTEGER; a_list: LEAF_AS_LIST): STRING is
			-- Original text from `start_pos' to `end_pos' of `current' AST node
		require
			a_list_not_void: a_list /= Void
			position_valid: start_pos >= 1 and end_pos <= original_text_count (a_list) and start_pos <= end_pos
		local
			l_start_pos: INTEGER
		do
			l_start_pos := complete_start_position (a_list)
			Result := a_list.original_text (l_start_pos + start_pos - 1, l_start_pos + end_pos - 1)
		end

	can_replace_subtext (old_str: STRING; is_case_sensitive: BOOLEAN; a_list: LEAF_AS_LIST): BOOLEAN is
			-- Can all occurrances of `old_str' in original text of `current' AST node be replaced by some other string?
		require
			old_str_not_void: old_str /= Void
			old_str_not_empty: not old_str.is_empty
			a_list_not_void: a_list /= Void
		local
			l_str: STRING
			l_index: INTEGER
			l_count: INTEGER
			l_old_str: STRING
		do
			l_str := original_text (a_list)
			if not is_case_sensitive then
				l_str.to_lower
				l_old_str := old_str.as_lower
			else
				l_old_str := old_str
			end
			l_count := l_old_str.count
			from
				l_index := l_str.substring_index (l_old_str, 1)
				Result := True
			until
				l_index = 0 or not Result
			loop
				Result := can_replace_text (l_index, l_index + l_count - 1, a_list)
				l_index := l_str.substring_index (l_old_str, l_index + l_count)
			end
		end

	replace_subtext (old_str, new_str: STRING; is_case_sensitive: BOOLEAN; a_list: LEAF_AS_LIST) is
			-- Replace all `old_str' by `new_str' in original text of `current' AST node.
		require
			old_str_not_void: old_str /= Void
			old_str_not_empty: not old_str.is_empty
			a_list_not_void: a_list /= Void
			subtext_replacable: can_replace_subtext (old_str, is_case_sensitive, a_list)
		local
			l_str: STRING
			l_index: INTEGER
			l_count: INTEGER
			l_old_str: STRING
		do
			l_str := original_text (a_list)
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
				replace_text (new_str, l_index, l_index + l_count - 1, a_list)
				l_index := l_str.substring_index (l_old_str, l_index + l_count)
			end
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
