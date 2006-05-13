indexing
	description: "Eiffel Query Language utilities used in formatters"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FORMATTER_UTILITY

feature{NONE} -- Implementation

	query_feature_item_from_e_feature (a_feature: E_FEATURE): QL_FEATURE is
			-- Given a E_FEATURE object, return a QL_FEATURE object representing it.
		require
			a_feature_attached: a_feature /= Void
		local
			l_ql_class: QL_CLASS
		do
			l_ql_class := query_class_item_from_class_c (a_feature.associated_class)
			create {QL_REAL_FEATURE}Result.make_with_parent (a_feature, l_ql_class)
		ensure
			result_attached: Result /= Void
		end

	query_class_item_from_class_c (a_class_c: CLASS_C): QL_CLASS is
			-- Given a CLASS_C object, return a QL_CLASS object representing it.
		require
			a_class_c_attached: a_class_c /= Void
		local
			l_class: CONF_CLASS
			l_group: CONF_GROUP
			l_path: LINKED_LIST [QL_ITEM]
			l_last_item: QL_ITEM
		do
			l_class := a_class_c.lace_class.config_class
			l_group := l_class.group
			create l_path.make
			find_path_from_conf_group (l_path, l_group)
			check l_path.count >= 2 end
			from
				l_path.start
				l_last_item := l_path.item
				l_path.forth
			until
				l_path.after
			loop
				l_path.item.set_parent (l_last_item)
				l_last_item := l_path.item
				l_path.forth
			end
			create Result.make_with_parent (l_class, l_path.last)
		ensure
			result_attached: Result /= Void
		end

	find_path_from_conf_group (a_list: LINKED_LIST [QL_ITEM]; a_group: CONF_GROUP) is
			-- Find a path from `a_group' to current system target, and
			-- save this path in `a_list'.
		require
			a_list_attached: a_list /= Void
			a_group_attached: a_group /= Void
		local
			l_cluster: CONF_CLUSTER
			l_lib: CONF_LIBRARY
			l_name: STRING
			l_sep: BOOLEAN
			l_target: CONF_TARGET
			l_libs: ARRAYED_LIST [CONF_LIBRARY]
		do
			if a_list.is_empty then
				a_list.extend (create{QL_GROUP}.make (a_group))
			else
				a_list.put_front (create{QL_GROUP}.make (a_group))
			end
			if a_group.is_cluster then
				l_cluster ?= a_group
				a_list.put_front (create{QL_GROUP}.make (l_cluster))
				if l_cluster.parent /= Void then
					find_path_from_conf_group (a_list, l_cluster.parent)
				else
					l_target := a_group.target
					a_list.put_front (create{QL_TARGET}.make (l_target))
					l_libs := l_target.used_in_libraries
					if l_libs /= Void and then not l_libs.is_empty then
						l_lib := l_libs.first
					end
					if l_lib /= Void then
						find_path_from_conf_group (a_list, l_lib)
					end
				end
			elseif a_group.is_library or a_group.is_assembly then
				l_target := a_group.target
				a_list.put_front (create{QL_TARGET}.make (l_target))
				l_libs := l_target.used_in_libraries
				if l_libs /= Void and then not l_libs.is_empty then
					l_lib := l_libs.first
				end
				if l_lib /= Void then
					find_path_from_conf_group (a_list, l_lib)
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
