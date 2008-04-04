indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	COPYRIGHT_AST_VISITOR

inherit
	AST_ROUNDTRIP_ITERATOR
		redefine
			process_class_as,
			process_eiffel_list
		end

create
	make

feature {NONE} -- Initialization

	make (a_top_index_insert_strings: HASH_TABLE [STRING, STRING]; a_bottom_index_string: STRING) is
			-- Initialization
		require
			a_top_index_insert_string_attached: a_top_index_insert_strings /= Void
			bottom_index_string_attached: a_bottom_index_string /= Void
		do
			top_insert_strings := a_top_index_insert_strings
			bottom_index_string := a_bottom_index_string
			create index_clauses.make (5)
		ensure
			top_insert_string_not_void: top_insert_strings = a_top_index_insert_strings
			bottom_index_string: bottom_index_string = a_bottom_index_string
		end

feature

	process_class_as (l_as: CLASS_AS) is
		local
			l_string: STRING
			last_as: AST_EIFFEL
			l_feature_clause: FEATURE_CLAUSE_AS
			l_feature: FEATURE_AS
		do
			if l_as.internal_top_indexes /= Void then
				processing_top_index_clause := true
				top_index_modified := true
				last_top_insert_ast := l_as.internal_top_indexes.indexing_keyword (match_list)
			else
				l_string := build_top_index
				l_as.first_token (match_list).prepend_text (l_string, match_list)
				top_index_inserted := true
			end
			safe_process (l_as.internal_top_indexes)
			insert_top_copyright_info
			processing_top_index_clause := false

			if l_as.internal_bottom_indexes = Void then
					-- Add semicolon if the last feature is an attribute.
				if l_as.internal_invariant = Void and then l_as.features /= Void and then not l_as.features.is_empty then
					l_feature_clause := l_as.features.last
					if l_feature_clause.features /= Void and then not l_feature_clause.features.is_empty then
						l_feature := l_feature_clause.features.last
						if l_feature.is_attribute then
							add_semicolon_after_feature (l_feature, l_as.end_keyword)
						elseif l_feature.body /= Void and then l_feature.body.is_constant then
							add_semicolon_after_feature (l_feature, l_as.end_keyword)
						end
					end
				end
				l_string := bottom_index_string + "%N"
				l_as.end_keyword.prepend_text (l_string, match_list)
				bottom_index_inserted := true
			else
				l_string := bottom_index_string
				l_as.internal_bottom_indexes.replace_text (l_string, match_list)
				bottom_index_replaced := true
			end

			safe_process (l_as.internal_bottom_indexes)

			if l_as.end_keyword.index < match_list.count then
				last_as := match_list.last
				l_string := last_as.text (match_list)
				if l_string.has_substring ("--|--") then
					l_string.keep_head (l_string.substring_index ("--|--", 1) - 1)
					last_as.replace_text (l_string, match_list)
					end_class_comments_removed := true
				end
			end
		end

	process_eiffel_list (l_as: EIFFEL_LIST [AST_EIFFEL]) is
		local
			i, l_count: INTEGER
			l_index_as: INDEX_AS
		do
			if processing_top_index_clause then
				if l_as.count > 0 then
					from
						l_as.start
						i := 1
						if l_as.separator_list /= Void then
							l_count := l_as.separator_list.count
						end
					until
						l_as.after
					loop
						safe_process (l_as.item)
						l_index_as ?= l_as.item
						if l_index_as /= Void then
							index_clauses.extend (l_index_as)
						end
						if i <= l_count then
							safe_process (l_as.separator_list_i_th (i, match_list))
							i := i + 1
						end
						l_as.forth
					end
				end
			else
				if l_as.count > 0 then
					from
						l_as.start
						i := 1
						if l_as.separator_list /= Void then
							l_count := l_as.separator_list.count
						end
					until
						l_as.after
					loop
						safe_process (l_as.item)
						if i <= l_count then
							safe_process (l_as.separator_list_i_th (i, match_list))
							i := i + 1
						end
						l_as.forth
					end
				end
			end
		end

feature -- Status report

	end_class_comments_removed: BOOLEAN

	bottom_index_replaced: BOOLEAN

	bottom_index_inserted: BOOLEAN

	top_index_modified: BOOLEAN

	top_index_inserted: BOOLEAN

feature {NONE} -- Flags

	processing_top_index_clause: BOOLEAN

feature {NONE} -- Implementation

	last_top_insert_ast: AST_EIFFEL

	top_insert_strings: HASH_TABLE [STRING, STRING]

	bottom_index_string: STRING

	index_clauses : ARRAYED_LIST [INDEX_AS]
		-- Found index as in top index clause.

	insert_top_copyright_info is
			--
		local
			replace_str: STRING
			l_index_as: INDEX_AS
		do
			l_index_as := search_index_as ("description")
			replace_str := ""
			if l_index_as /= Void then
				last_top_insert_ast := l_index_as
			end
			from
				top_insert_strings.start
			until
				top_insert_strings.after
			loop
				l_index_as := search_index_as (top_insert_strings.key_for_iteration)
				if l_index_as /= Void then
					replace_str := top_insert_strings.key_for_iteration + ": " + top_insert_strings.item_for_iteration
					l_index_as.replace_text (replace_str, match_list)
					last_top_insert_ast := l_index_as
				else
					if last_top_insert_ast /= Void then
						replace_str := "%N%T" +  top_insert_strings.key_for_iteration + ": " + top_insert_strings.item_for_iteration
						last_top_insert_ast.append_text (replace_str, match_list)
					end
				end
				top_insert_strings.forth
			end
		end

	search_index_as (l_key: STRING): INDEX_AS is
			--
		local
			end_loop : BOOLEAN
		do
			from
				index_clauses.start
				end_loop := false
			until
				index_clauses.after or end_loop
			loop
				if index_clauses.item.tag /= Void and then l_key.is_case_insensitive_equal (index_clauses.item.tag.name) then
					Result := index_clauses.item
					end_loop := true
				end
				index_clauses.forth
			end
		end

	build_top_index: STRING is
			--
		do
			Result := "indexing%N%T" + build_top_insert_string
		end

	build_top_insert_string: STRING is
			-- No tabs ahead, newline at the end.
		do
			create Result.make_empty
			from
				top_insert_strings.start
			until
				top_insert_strings.after
			loop
				Result.append (top_insert_strings.key_for_iteration)
				Result.append (": ")
				Result.append (top_insert_strings.item_for_iteration)
				Result.append ("%N%T")
				top_insert_strings.forth
			end
				-- Remove the last tab.
			Result.keep_head (Result.count - 1)
		end

	add_semicolon_after_feature (a_feature: FEATURE_AS; a_end_as: KEYWORD_AS) is
			-- Add semicolon after feature, if there is none between end of `a_feature' and `a_end_as'.
		local
			l_semicolon_exists: BOOLEAN
		do
			l_semicolon_exists := match_list.if_any_in_region (a_feature.trailing_break_region (match_list), agent is_semicolon_token)
			if not l_semicolon_exists then
				a_feature.set_break_included (False)
				a_feature.append_text (";", match_list)
			end
		end

	is_semicolon_token (a_leaf: LEAF_AS): BOOLEAN is
			-- Is `a_leaf' a semicolon token?
		require
			a_leaf_not_void: a_leaf /= Void
		local
			l_semicolon: SYMBOL_STUB_AS
		do
			l_semicolon ?= a_leaf
			Result := l_semicolon /= Void and then l_semicolon.is_semicolon
		end

invariant
	invariant_clause: True -- Your invariant here

indexing
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
