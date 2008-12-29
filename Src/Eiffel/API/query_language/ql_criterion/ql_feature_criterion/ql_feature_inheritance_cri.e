note
	description: "Object that represents a criterion to decide whether or not a feature is ancestor/descendant of another feature"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	QL_FEATURE_INHERITANCE_CRI

inherit
	QL_FEATURE_HIERARCHY_CRI

feature{NONE} -- Evaluate

	is_satisfied_by_internal (a_item: QL_FEATURE): BOOLEAN
			-- Evaluate `a_item'.
		local
			l_user_data_list: like user_data_list
			l_feature_list: like feature_list
			l_e_feature: E_FEATURE
			l_item: QL_FEATURE
		do
			if a_item.is_real_feature then
				l_user_data_list := user_data_list
				l_feature_list := feature_list
				l_e_feature := a_item.e_feature
				check l_e_feature /= Void end
				from
					l_feature_list.start
				until
					l_feature_list.after
				loop
					if l_feature_list.item.same_as (l_e_feature) then
						if not Result then
							a_item.set_data (l_user_data_list.i_th (l_feature_list.index))
							Result := True
						else
								-- Deal with different branch versions.
								-- From source domain, when we list all features,
								-- One feature will be listed only once, features with multi-branchs
								-- are supposed to appear in result domain for several times (one branch per time).
							l_item := a_item.twin
							l_item.set_data (l_user_data_list.i_th (l_feature_list.index))
							used_in_domain_generator.on_item_satisfied_by_criterion (l_item, False)
						end
					end
					l_feature_list.forth
				end
			end
		end

note
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
