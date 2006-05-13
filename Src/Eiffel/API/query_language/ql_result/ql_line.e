indexing
	description: "Object that represents a line used in Eiffel query language"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_LINE

inherit
	QL_ITEM
		redefine
			wrapped_domain,
			is_equal
		end

	QL_SHARED_SCOPES
		undefine
			is_equal
		end

create
	make,
	make_with_text

feature{NONE} -- Initialization

	make (a_line_number: INTEGER; a_parent: like parent) is
			-- Initialize `line_number' with `a_line_number' and `parent' with `a_parent'.
		require
			a_parent_attached: a_parent /= Void
			a_parent_valid: (a_parent.is_code_structure) and then a_parent.is_valid_domain_item and then a_parent.is_compiled
			a_line_number_valid: is_line_number_valid (a_line_number, a_parent)
		do
			line_number := a_line_number
			set_parent (a_parent)
		ensure
			line_number_set: line_number = a_line_number
			parent_set: parent = a_parent
		end

	make_with_text (a_line_number: INTEGER; a_text: STRING; a_parent: like parent) is
			-- Initialize `line_number' with `a_line_number' `text' with `a_text' and `parent' with `a_parent'.
		require
			a_line_number_positive: a_line_number > 0
			a_text_attached: a_text /= Void
			a_parent_attached: a_parent /= Void
			a_parent_valid: (a_parent.is_code_structure) and then a_parent.is_valid_domain_item and then a_parent.is_compiled
		do
			line_number := a_line_number
			create internal_text.make_from_string (a_text)
			set_parent (a_parent)
		ensure
			line_number_set: line_number = a_line_number
			text_attached: text /= Void
			text_set: text.is_equal (a_text)
			parent_set: parent = a_parent
		end

feature -- Access

	name: STRING is
			-- Name of current item
		do
			Result := line_number.out
		ensure then
			good_result: Result.is_equal (line_number.out)
		end

	hash_code: INTEGER is
			-- Hash code value
		do
			if internal_hash_code = 0 then
				internal_hash_code := path.hash_code
			end
			Result := internal_hash_code
		ensure then
			good_result: Result = internal_hash_code
		end

	description: STRING is
			-- Description of current item
		do
			Result := ""
		ensure then
			no_description_attached_to_a_line: Result.is_equal ("")
		end

	wrapped_domain: QL_LINE_DOMAIN is
			-- A domain which has current as the only item
		do
			create Result.make
			Result.extend (Current)
		end

	line_number: INTEGER
			-- Line number related to `parent'
			-- If `parent' is a class, current represents the `line_number'-th line in that file,
			-- if `parent' is a feature, current represents the `line_number'-th line in that feature,

	text: STRING is
			-- Text of the line represented by current
		do
			if internal_text = Void then
				retrieve_text
				check internal_text /= Void end
			end
			Result := internal_text
		ensure
			result_attached: Result /= Void
		end

	scope: QL_SCOPE is
			-- Scope of current
		do
			Result := line_scope
		end

	line_length: INTEGER is
			-- Length in bytes of current line
		do
			Result := text.count
		ensure
			good_result: Result = text.count
		end

	path_name_marker: QL_PATH_MARKER is
			-- Marker for `path_name'
		do
			Result := line_path_marker
		ensure then
			good_result: Result = line_path_marker
		end

	line_in_file: INTEGER is
			-- Line number of current item in file
		local
			l_parent: QL_CODE_STRUCTURE_ITEM
		do
			l_parent ?= parent
			check l_parent /= Void end
			Result := l_parent.first_line + line_number - 1
		end

feature -- Status report

	is_compiled: BOOLEAN is
			-- Is Current item compiled?
		do
			Result := True
		ensure then
			good_result: Result
		end

	is_blank: BOOLEAN is
			-- Is current a blank line?
		do
			if not is_blank_calculated then
				calculate_is_blank
			end
			Result := is_blank_internal
		ensure
			good_result: Result = is_blank_internal
		end

	is_comment: BOOLEAN is
			-- Is current a comment line?
		do
			if not is_comment_calculated then
				calculate_is_comment
			end
			Result := is_comment_internal
		ensure
			good_result: Result = is_comment_internal
		end

	is_line_number_valid (a_line_number: INTEGER; a_parent: like parent): BOOLEAN is
			-- Is `a_line_number' valid according to `a_parent'?
			-- e.g., `a_line_number' is neigher too small or too large.
		require
			a_parent_attached: a_parent /= Void
			a_parent_valid: a_parent.is_valid_domain_item and then a_parent.is_code_structure
		local
			l_code_item: QL_CODE_STRUCTURE_ITEM
			l_text: STRING
			l_line_cnt: INTEGER
			l_text_cnt: INTEGER
			l_last_new_line_pos: INTEGER
		do
			if a_line_number > 0 then
				l_code_item ?= a_parent
				l_text := l_code_item.text
				l_line_cnt := l_text.occurrences ('%N')
				l_text_cnt := l_text.count
				l_last_new_line_pos := l_text.last_index_of ('%N', l_text_cnt)
				if l_last_new_line_pos < l_text_cnt then
					l_line_cnt := l_line_cnt + 1
				end
				Result := a_line_number <= l_line_cnt
			end
		end

feature -- Visit

	process (a_visitor: QL_VISITOR) is
			-- Process `a_visitor'.
		do
			a_visitor.process_line (Current)
		end

feature{NONE} -- Implementation

	internal_text: STRING
		-- Implementation of `text'

	retrieve_text is
			-- Retrieve `text' from `ast' using `line_number'
		require
			valid_line_number: is_line_number_valid (line_number, parent)
		local
			l_text: STRING
			l_code_item: QL_CODE_STRUCTURE_ITEM
			l_pos: INTEGER
			l_cnt: INTEGER
			l_new_line: CHARACTER
			l_next_new_line_pos: INTEGER
		do
			l_code_item ?= parent
			check l_code_item /= Void end
			l_text := l_code_item.text
			l_cnt := line_number - 1
			l_pos := 1
			l_new_line := '%N'
			if l_cnt > 0 then
				from
				until
					l_cnt = 0
				loop
					l_pos := l_text.index_of (l_new_line, l_pos)
					l_pos := l_pos + 1
					l_cnt := l_cnt - 1
				end
			end
			l_next_new_line_pos := l_text.index_of (l_new_line, l_pos)
			if l_next_new_line_pos = 0 then
				l_next_new_line_pos := l_text.count
			end
			create internal_text.make_from_string (l_text.substring (l_pos, l_next_new_line_pos))
		ensure
			internal_text_attached: internal_text /= Void
		end

	calculate_is_blank is
			-- Calculate value of `is_blank'
		local
			l_text: STRING
			l_cnt: INTEGER
			i: INTEGER
		do
			l_text := text
			l_cnt := l_text.count
			if l_text.item (l_cnt) = '%N' then
				l_cnt := l_cnt - 1
			end
			from
				i := 1
				is_blank_internal := True
			until
				i > l_cnt or not is_blank_internal
			loop
				is_blank_internal := l_text.item (i).is_space
				i := i + 1
			end
			is_blank_calculated := True
		ensure
			is_blank_calculated: is_blank_calculated
		end

	calculate_is_comment is
			-- Calculate value of `is_comment'
		local
			l_text: STRING
			l_minus: CHARACTER
		do
			l_text := text
			l_text.left_adjust
			if l_text.count >= 2 then
				l_minus := '-'
				is_comment_internal := l_text.item (1) = l_minus and l_text.item (2) = l_minus
			end
			is_comment_calculated := True
		ensure
			is_comment_calculated: is_comment_calculated
		end

	is_blank_internal: BOOLEAN
			-- Implementation of `is_blank'

	is_comment_internal: BOOLEAN
			-- Implementation of `is_comment'

	is_blank_calculated: BOOLEAN
			-- Has `is_blank' been calculated?

	is_comment_calculated: BOOLEAN
			-- Has `is_comment' been calculated?

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := parent.same_type (other.parent) and then
			         parent.is_equal (other.parent) and then
			         line_number = other.line_number
		ensure then
			good_result: Result implies
				(parent.same_type (other.parent) and then
				 parent.is_equal (other.parent) and then
				 line_number = other.line_number)

		end

invariant
	line_number_positive: line_number > 0
	parent_attached: parent /= Void
	parent_valid: parent.is_valid_domain_item and then parent.is_code_structure

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
