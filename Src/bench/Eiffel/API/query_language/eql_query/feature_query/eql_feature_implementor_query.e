indexing
	description: "Object that represents an EQL query for implementors of a feature"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQL_FEATURE_IMPLEMENTOR_QUERY

inherit
	EQL_QUERY
		redefine
			last_result
		end

feature -- Result

	last_result: EQL_SCOPE_RESULT [EQL_FEATURE]
			-- Last Result

feature{NONE} -- Implementation

	execute_over_single_scope (a_single_scope: EQL_SINGLE_SCOPE; a_criterion: EQL_CRITERION) is
			-- Execute over `a_single_scope' with `a_criterion'.
			-- If successful, store result in `last_result'.
		local
			l_feature: EQL_FEATURE
			written_cl: CLASS_C;
			written_in: INTEGER
			l_descendant_qry: EQL_CLASS_DESCENDANT_QUERY
			l_descendants: EQL_SCOPE_RESULT [EQL_CLASS]
			classes: PART_SORTED_TWO_WAY_LIST [CLASS_C]
			precursors: LIST [CLASS_C]
			rout_id_set: ROUT_ID_SET
			rout_id: INTEGER
			rc: INTEGER
			i: INTEGER
			c: CLASS_C
			feat: E_FEATURE
			l_itr: EQL_ITERATOR [EQL_CLASS]
			l_ctxt: EQL_CONTEXT
		do
			if a_single_scope.is_feature_scope then
				l_feature ?= a_single_scope
				written_cl := l_feature.e_feature.written_class
				create l_descendant_qry
				l_descendant_qry.execute (create{EQL_CLASS}.make_with_class_c (l_feature.e_feature.associated_class))
				l_itr := l_descendant_qry.last_result.distinct_itr
				create classes.make
				from
					l_itr.start
				until
					l_itr.after
				loop
					classes.extend (l_itr.item.class_c)
					l_itr.forth
				end
				precursors := l_feature.e_feature.precursors
				if precursors /= Void then
					classes.append (precursors)
				end
				rout_id_set := l_feature.e_feature.rout_id_set
				create l_ctxt
				from
					rc := rout_id_set.count
					i := 1
				until
					i > rc
				loop
					rout_id := rout_id_set.item (i)
					from
						classes.start
					until
						classes.after
					loop
						c := classes.item
						written_in := c.class_id
						if c.has_feature_table then
							feat := c.feature_with_rout_id (rout_id)
							if feat /= Void and then feat.written_in = written_in then
								l_ctxt.set_e_feature (feat)
								if a_criterion.evaluate (l_ctxt) then
									last_result.extend (create{EQL_TREE_NODE [EQL_FEATURE]}.make_with_data (last_result, create{EQL_FEATURE}.make_with_feature (feat)))
								end
							end
						end
						classes.forth
					end
					i := i + 1
				end
			end
		end

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
