indexing
	description: "Object that represents a criterion to decide whether or not a feature is an implementor of another feature"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_FEATURE_IMPLEMENTORS_OF_CRI

inherit
	QL_FEATURE_HIERARCHY_CRI

create
	make

feature{NONE} -- Implementation

	find_result is
			-- Find implementors of `criterion_domain'.
		local
			classes: PART_SORTED_TWO_WAY_LIST [CLASS_C]
			rout_id_set: ROUT_ID_SET
			rout_id: INTEGER
			i: INTEGER
			written_in: INTEGER
			feat: E_FEATURE
			c: CLASS_C
			written_cl: CLASS_C
			precursors: LIST [CLASS_C]
			rc: INTEGER
			l_branch_id_list: like user_data_list
			l_implementor_list: like feature_list
			l_feature: E_FEATURE
			l_feature_domain: like features_from_domain
			l_ql_feature: QL_FEATURE
		do
			l_feature_domain := features_from_domain (criterion_domain)
			if not l_feature_domain.is_empty then
				l_branch_id_list := user_data_list
				l_implementor_list := feature_list
				from
					l_feature_domain.start
				until
					l_feature_domain.after
				loop
					l_ql_feature := l_feature_domain.item
					if l_ql_feature.is_real_feature then
						l_feature := l_ql_feature.e_feature
						written_cl := l_feature.written_class
						precursors := l_feature.precursors
						create classes.make
						record_descendants (classes, l_feature.associated_class)
						if not classes.has (l_feature.associated_class) then
							classes.extend (l_feature.associated_class)
						end
						if precursors /= Void then
							classes.append (precursors)
						end
						rout_id_set := l_feature.rout_id_set
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
										l_branch_id_list.extend (i)
										l_implementor_list.extend (feat)
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
