indexing
	description: "[
		Used for extracting comments from a routine and displaying inherited comments, when appropriate.
		
		Current there is a comment specification for injecting inherited comments into an existing feature's comment:
		
		Using the comment <Original> will inject the first matched redefined feature's comment, from a parent declaration.
		To be more specific, you can use <Original {CLASS_NAME}> where CLASS_NAME is the name of the class where the
		feature is redefined from. Multiple <Original> comments can be used, with class name, to allow for comments from multiple
		classes.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	COMMENT_EXTRACTOR

feature -- Query

	feature_comments (a_feature: !E_FEATURE): ?EIFFEL_COMMENTS
			-- Retrieve's the feature comments from a given compiled feature.
			--
			-- `a_feature': The feature to show comments for.
			-- `Result': A list of tokens or Void if no comments were found.
		do
			Result := feature_comments_ex (a_feature, False)
		end

	feature_comments_ex (a_feature: !E_FEATURE; a_show_impl: BOOLEAN): ?EIFFEL_COMMENTS is
			-- Retrieve's the feature comments from a given compiled feature, with the option to include implementation comments
			--
			-- `a_feature': The feature to show comments for.
			-- `a_show_impl': True if the feature's implmentation comments should be displayed; False otherwise.
			-- `Result': A list of tokens or Void if no comments were found.
		local
			l_parent_comments: like feature_inherited_comments
			l_comments: EIFFEL_COMMENTS
			l_comment: EIFFEL_COMMENT_LINE
			l_string: STRING_8
			l_leaf: LEAF_AS_LIST
			l_stop: BOOLEAN
			l_comments_emitted: BOOLEAN
		do
			create Result.make

			if {l_mls: !MATCH_LIST_SERVER} a_feature.system.match_list_server then
				l_leaf := l_mls.item (a_feature.written_class.class_id)
				if l_leaf /= Void then
					l_comments := a_feature.ast.comment (l_leaf)
					if l_comments /= Void and then not l_comments.is_empty then
						from
							l_comments.start
						until
							l_comments.after
						loop
							l_comment := l_comments.item
							if a_show_impl or else not l_comment.is_implementation then
									-- Add only actual comments, because implementation comments should not be shown (unless requested)
								l_string := l_comment.content
								if not l_string.is_empty and then l_string.occurrences (' ') + l_string.occurrences ('%T') /= l_string.count then
										-- Non blank comments
									l_comments_emitted := True

										-- Determine if inherited comments should be used
									original_comment_reg_ex.match (l_string)
									if original_comment_reg_ex.has_matched then
											-- The comment is actually a inherited comment reference
										if original_comment_reg_ex.match_count = 3 then
												-- The comment contains a inherited type specifier, take the comment from a particular type.
											l_parent_comments := feature_inherited_comments (a_feature, original_comment_reg_ex.captured_substring (2))
										else
											l_parent_comments := feature_inherited_comments (a_feature, Void)
										end

										if l_parent_comments /= Void and then not l_parent_comments.is_empty then
												-- Add parent comments and re-adjust the cursor index to skip the parent comments.
											Result.append (l_parent_comments)
										end
									else
											-- Recreate the line to remove all stored position information.
										Result.extend (create {EIFFEL_COMMENT_LINE}.make_from_string (l_comment.content))
									end
								elseif l_comments_emitted then
										-- Allows blank lines to be included in the comments, only if real comments have been added first.
									Result.extend (create {EIFFEL_COMMENT_LINE}.make_from_string (""))
								end
							end

							l_comments.forth
						end
					else
							-- There are no comments, try the parent
						l_parent_comments := feature_inherited_comments (a_feature, Void)
						if l_parent_comments /= Void and then not l_parent_comments.is_empty then
							Result.append (l_parent_comments)
						end
					end

					if not Result.is_empty then
							-- Trim empty lines from the end of comment list
						from
							l_stop := False
							Result.finish
						until
							Result.before or l_stop
						loop
							l_comment := Result.item
							l_string := l_comment.content
							if l_string.is_empty or else l_string.occurrences (' ') + l_string.occurrences ('%T') = l_string.count then
								if Result.isfirst then
									Result.remove
								else
									Result.back
									Result.remove_right
								end
							else
								l_stop := True
							end
						end
					end
				end
			end

			if Result.is_empty then
				Result := Void
			end
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
			result_contains_attached_items: Result /= Void implies not Result.has (Void)
		end

feature {NONE} -- Query

	feature_inherited_comments (a_feature: !E_FEATURE; a_parent_name: ?STRING_8): ?EIFFEL_COMMENTS
			-- Attempts to extract the inherited comments from a given feature
			--
			-- `a_feature': The feature to extract the comments from.
			-- `a_parent_name': An optional parent class name to use when extracting inherited comments.
			-- `Result': A list of tokens or Void if not comments were located.
		require
			not_a_parent_name_is_empty: a_parent_name /= Void implies not a_parent_name.is_empty
		local
			l_parents: LIST [CLASS_C]
			l_parent_class: CLASS_C
			l_rout_id_set: ROUT_ID_SET
			l_count, i: INTEGER
			l_parent_feature: E_FEATURE
		do
			l_parents := a_feature.precursors
			if l_parents /= Void and then not l_parents.is_empty then
					-- Iterate throught parents to locate a matching routine id
				l_rout_id_set := a_feature.rout_id_set
				from
					l_parents.start
				until
					l_parents.after or
					(Result /= Void and then not Result.is_empty)
				loop
					l_parent_class := l_parents.item
					if l_parent_class /= Void then
						if (a_parent_name = Void or else l_parent_class.name_in_upper.is_equal (a_parent_name)) then
							from
								l_parent_feature := Void
								l_count := l_rout_id_set.count
								i := 1
							until
								i > l_count or l_parent_feature /= Void
							loop
									-- Attempt to locate a parent feature and extract the comments for them.
								l_parent_feature := l_parent_class.feature_with_rout_id (l_rout_id_set.item (i))
								if {l_feature: !E_FEATURE} l_parent_feature then
									Result := feature_comments_ex (l_feature, False)
								end
								i := i + 1
							end
						end
					end
					l_parents.forth
				end

				if a_parent_name /= Void and then l_parent_feature = Void then
						-- The comment specification used a incorrect class name, so the redefined feature could not be located.
					create Result.make
					Result.extend (create {EIFFEL_COMMENT_LINE}.make_from_string (" Unable to retrieve the comments from redefinition of {" + a_parent_name.as_upper + "}."))
				end
			end
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
			result_contains_attached_items: Result /= Void implies not Result.has (Void)
		end

feature {NONE} -- Regular expressions

	original_comment_reg_ex: RX_PCRE_MATCHER
			-- Pattern to match a original comment specification with an optional precursor class name
		once
			create Result.make
			Result.compile ("^[\ \t]*<[\ \t]*[Oo][Rr][Ii][Gg][Ii][Nn][Aa][Ll][\ \t]*({([A-Z][A-Z_0-9]*)\}[\ \t]*>|>)[ \t]*$")
		ensure
			result_is_compiled: Result.is_compiled
		end

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
