note
	description: "Base class for undoable actions."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	COMPOSER_ACTION

feature {NONE} -- Initialization

	make
		do

		end

feature -- Basic operations

	reset
		do
			last_error_message := Void
			succeed := False
		end

	execute
			-- Execute the composer action.	
		require
			last_error_message = Void
		deferred
		end

	report_error (m: READABLE_STRING_GENERAL)
		do
			last_error_message := m
			succeed := False
		end

feature -- Error

	last_error_message: detachable READABLE_STRING_GENERAL

	succeed: BOOLEAN

feature -- Helper

	create_insert_position (ctm: ES_CLASS_TEXT_AST_MODIFIER): detachable TUPLE [begin_position, end_position: INTEGER; exists: BOOLEAN]
		local
			class_as: CLASS_AS
			match_list: LEAF_AS_LIST
			insertion_position: INTEGER
		do
			class_as := ctm.ast
			match_list := ctm.ast_match_list
			if
				attached class_as.creators as l_creators and then
				attached l_creators.last as l_creator
			then
				insertion_position := l_creator.end_position + 1
				Result := [l_creator.start_position, insertion_position, True]
			elseif
				attached class_as.convertors as l_convertors and then
				attached l_convertors as l_convertor
			then
				insertion_position := l_convertor.start_position
			elseif
				attached class_as.features as l_features and then
				attached l_features.first as l_feature
			then
				insertion_position := l_feature.start_position
			else
				insertion_position := class_as.feature_clause_insert_position
			end
			if Result = Void and insertion_position > 0 then
				Result := [insertion_position, insertion_position, False]
			end
		end

	feature_clause_position (ctm: ES_CLASS_TEXT_AST_MODIFIER; a_export, a_comment: READABLE_STRING_GENERAL; a_created_if_not_found: BOOLEAN): detachable TUPLE [begin_position, end_position: INTEGER; is_new: BOOLEAN]
		local
			class_as: CLASS_AS
			match_list: LEAF_AS_LIST
			exp,
			e: STRING_32
			c: STRING_32
			l_comments: EIFFEL_COMMENTS
			insertion_position: INTEGER
			fcl, sel_fcl, nxt_fcl: FEATURE_CLAUSE_AS
			l_first_feature_clause_position: INTEGER
		do
			class_as := ctm.ast
			match_list := ctm.ast_match_list
				-- Check if specified clause is present.
			if
				attached class_as.features as lst
			then
				exp := a_export.as_string_32.as_lower
				if exp.same_string_general ("any") then
					exp := ""
				end
				from
					lst.start
				until
					(sel_fcl /= Void and nxt_fcl /= Void) or else lst.after
				loop
					fcl := lst.item
					if l_first_feature_clause_position = 0 then
						l_first_feature_clause_position := fcl.feature_keyword.start_position
					end
					if sel_fcl /= Void then
						nxt_fcl := fcl
					else
						if fcl.clients /= Void then
							e := fcl.clients.dump.as_lower
						else
							e := ""
						end
						if e.same_string_general ("any") then
							e := ""
						end
						l_comments := fcl.comment (match_list)
						if l_comments = Void or else l_comments.is_empty then
							c := ""
						else
							c := l_comments.first.content_32
							if not c.is_equal (" ") then
								c.left_adjust
							end
						end
						c.prune_all_trailing ('%R')
						if
							e.same_string_general (exp) and
						 	c.same_string_general (a_comment)
						then
						 	sel_fcl := fcl
						end
					end
					lst.forth
				end
				if sel_fcl /= Void then
					if nxt_fcl /= Void then
						insertion_position := nxt_fcl.start_position - 1
						Result := [insertion_position, insertion_position, False]
					else
						insertion_position := feature_insert_position (ctm, sel_fcl)
						Result := [sel_fcl.start_position, insertion_position, False]
					end
				end

					-- If no insert position set, feature clause is not
					-- present. Find position based on feature clause order.
				if sel_fcl = Void and a_created_if_not_found then
					if a_comment.is_case_insensitive_equal ({FEATURE_CLAUSE_NAMES}.fc_Initialization) then
						insertion_position := l_first_feature_clause_position
					else
						insertion_position := class_as.feature_clause_insert_position
					end
					if attached insert_feature_clause (ctm, a_export, a_comment, insertion_position) as res then
						Result := [res.begin_position, res.end_position, True]
					end
				end
			end
		end

	insert_feature_clause (ctm: ES_CLASS_TEXT_AST_MODIFIER; a_export, a_comment: STRING_32; insertion_position: INTEGER): TUPLE [begin_position, end_position: INTEGER]
			-- Insert in `insertion_position' a new empty feature clause with
			-- `a_export' and `a_comment'.
		require
			a_export_not_void: a_export /= Void
			a_comment_not_void: a_comment /= Void
		local
			s, up: STRING_32
		do
			create s.make (20)
			s.append_string_general ("feature")
			if not a_export.is_empty and not a_export.is_case_insensitive_equal_general ("any") then
				s.append_string_general (" {")
				up := a_export.as_upper
				s.append (up)
				s.extend ('}')
			end
			if not a_comment.is_empty then
				s.append_string_general (" -- ")
				s.append (a_comment)
			end
			s.append_string_general ("%N")
			ctm.insert_code (insertion_position, s)
			Result := [insertion_position, insertion_position + s.count] -- FIXME: check ..
		end

	feature_insert_position (ctm: ES_CLASS_TEXT_AST_MODIFIER; f: FEATURE_CLAUSE_AS): INTEGER
			-- Insertion position for `f'.
		local
			txt: STRING_32
		do
			txt := ctm.text
			Result := f.end_position + 1
			if Result <= txt.count + 1 then
				Result := txt.index_of ('%N', Result) + 1
			end
		end

note
	copyright:	"Copyright (c) 1984-2024, Eiffel Software"
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
