indexing
	description: "[
					Object that represents a criterion to decide whether or not a feature is descendant of another feature
					
					This criterion will use `data' attribute in every QL_FEATURE candidate object.
					IF a QL_FEATURE candidate is satisfied by this criterion. it's `data' attribute will
					be set with branch id (of type INTEGER)					
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_FEATURE_DESCENDANT_RELATION_CRI

inherit
	QL_FEATURE_HIERARCHY_CRI

create
	make

feature{NONE} -- Implementation

	find_result is
			-- Find ancestors of feature `descendant_feature'.
		local
			classes: ARRAYED_LIST [CLASS_C]
			rout_id_set: ROUT_ID_SET
			i: INTEGER
			other_feature: E_FEATURE
			e_class: CLASS_C
			l_ancestor_list: like feature_list
			l_branch_id_list: like user_data_list
			l_feature_domain: like features_from_domain
			l_ql_feature: QL_FEATURE
		do
			l_feature_domain := features_from_domain (criterion_domain)
			if not l_feature_domain.is_empty then
				l_ancestor_list := feature_list
				l_branch_id_list := user_data_list
				from
					l_feature_domain.start
				until
					l_feature_domain.after
				loop
					l_ql_feature := l_feature_domain.item
					if l_ql_feature.is_real_feature then
						create classes.make (20)
						record_descendants (classes, l_ql_feature.e_feature.associated_class)
						rout_id_set := l_ql_feature.e_feature.rout_id_set
						from
							i := 1
						until
							i > rout_id_set.count
						loop
							from
								classes.start
							until
								classes.after
							loop
								e_class := classes.item
								if e_class.has_feature_table then
									other_feature := e_class.feature_with_rout_id (rout_id_set.item (i))
									if other_feature /= Void then
										l_ancestor_list.extend (other_feature)
										l_branch_id_list.extend (i)
									end
								end
								classes.forth
							end
							i := i + 1
						end
					end
					l_feature_domain.forth
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
