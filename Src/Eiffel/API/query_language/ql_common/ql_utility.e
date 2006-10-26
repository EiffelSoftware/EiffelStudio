indexing
	description: "Eiffel Query Language utilities"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_UTILITY

inherit
	COMPILER_EXPORTER

feature -- Status report

	is_class_compiled (a_conf_class: CONF_CLASS): BOOLEAN is
			-- Does `a_conf_class' represent a compiled class?
		local
			l_class_i: CLASS_I
		do
			if not (a_conf_class.is_overriden or a_conf_class.does_override) then
				Result := a_conf_class.is_compiled
			else
				l_class_i ?= a_conf_class
				Result := l_class_i.compiled_representation /= Void
			end
		end

feature -- Access

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
			result_valid: Result.is_valid_domain_item
		end

	query_class_item_from_class_c (a_class_c: CLASS_C): QL_CLASS is
			-- Given a CLASS_C object, return a QL_CLASS object representing it.
		require
			a_class_c_attached: a_class_c /= Void
		do
			Result := query_class_item_from_class_i (a_class_c.lace_class)
		ensure
			result_attached: Result /= Void
			result_valid: Result.is_valid_domain_item
		end

	query_class_item_from_class_i (a_class_i: CLASS_I): QL_CLASS is
			-- Given a CLASS_I object, return a QL_CLASS object representing it.
		require
			a_class_i_attached: a_class_i /= Void
		do
			Result := query_class_item_from_conf_class (a_class_i.config_class)
		ensure
			result_attached: Result /= Void
			result_valid: Result.is_valid_domain_item
		end

	query_class_item_from_conf_class (a_conf_class: CONF_CLASS): QL_CLASS is
			-- Given a CONF_CLASS object, return a QL_CLASS object representing it.
		require
			a_conf_class_attached: a_conf_class /= Void
		local
			l_group: CONF_GROUP
			l_path: LINKED_LIST [QL_ITEM]
		do
			l_group := a_conf_class.group
			create l_path.make
			find_path_from_conf_group (l_path, l_group)
			check l_path.count >= 2 end
			set_parents (l_path)
			create Result.make_with_parent (a_conf_class, l_path.last)
		ensure
			result_attached: Result /= Void
			result_valid: Result.is_valid_domain_item
		end

	query_group_item_from_conf_group (a_group: CONF_GROUP): QL_GROUP is
			-- Given a CONF_GROUP object, return a QL_GROUP object representing it.
		require
			a_group_attached: a_group /= Void
		local
			l_list: LINKED_LIST [QL_ITEM]
		do
			create l_list.make
			find_path_from_conf_group (l_list, a_group)
			set_parents (l_list)
			Result ?= l_list.last
		ensure
			result_attached: Result /= Void
			result_valid: Result.is_valid_domain_item
		end

	query_target_item_from_conf_target (a_target: CONF_TARGET): QL_TARGET is
			-- Given a CONF_TARGET object, return a QL_TARGET object representing it.
		require
			a_target_attached: a_target /= Void
		local
			l_path: ARRAYED_LIST [QL_ITEM]
			l_target: CONF_TARGET
			l_is_application_target_reached: BOOLEAN
		do
			create l_path.make (10)
			from
				l_target := a_target
			until
				l_is_application_target_reached
			loop
				l_path.put_front (create {QL_TARGET}.make (l_target))
				if l_target.system = l_target.system.application_target.system then
					l_target := l_target.system.application_target
					l_is_application_target_reached := True
				else
					check
						library_target: l_target.system.library_target /= Void
					end
					l_target := l_target.system.library_target
				end
				if not l_is_application_target_reached then
					check l_target.system.lowest_used_in_library /= Void end
					l_path.put_front (create {QL_GROUP}.make (l_target.system.lowest_used_in_library))
					l_target := l_target.system.lowest_used_in_library.target
				end
			end
			set_parents (l_path)
			Result ?= l_path.last
		ensure
			result_attached: Result /= Void
			result_valid: Result.is_valid_domain_item
		end

feature -- Type

	actual_type_from_type_a (a_class: CLASS_C; a_type: TYPE_A): CLASS_C is
			-- Actual type from `a_type' in context of `a_class'
		require
			a_class_attached: a_class /= Void
			a_type_attached: a_type /= Void
		local
			l_type: TYPE_A
		do
			l_type := a_type
			if l_type.is_loose then
				l_type := l_type.actual_type
				l_type := constrained_type (a_class, l_type)
			end
			Result := l_type.associated_class
		ensure
			result_attached: Result /= Void
		end

feature{NONE} -- Implementation

	find_path_from_conf_group (a_list: LINKED_LIST [QL_ITEM]; a_group: CONF_GROUP) is
			-- Find a path from `a_group' to current system target, and
			-- save this path in `a_list'.
		require
			a_list_attached: a_list /= Void
			a_group_attached: a_group /= Void
		local
			l_cluster: CONF_CLUSTER
			l_lib: CONF_LIBRARY
			l_target: CONF_TARGET
			l_is_application_target_reached: BOOLEAN
		do
			if a_list.is_empty then
				a_list.extend (create{QL_GROUP}.make (a_group))
			else
				a_list.put_front (create{QL_GROUP}.make (a_group))
			end
			if a_group.is_cluster then
				l_cluster ?= a_group
				if l_cluster.parent /= Void then
					find_path_from_conf_group (a_list, l_cluster.parent)
				else
					l_target := a_group.target
					if l_target.system = l_target.system.application_target.system then
						l_target := l_target.system.application_target
						l_is_application_target_reached := True
					else
						check
							library_target: l_target.system.library_target /= Void
						end
						l_target := l_target.system.library_target
					end
					a_list.put_front (create{QL_TARGET}.make (l_target))
					if not l_is_application_target_reached then
						l_lib := l_target.system.lowest_used_in_library
						if l_lib /= Void  then
							find_path_from_conf_group (a_list, l_lib)
						end
					end
				end
			elseif a_group.is_library or a_group.is_assembly or a_group.is_physical_assembly then
				l_target := a_group.target
				if l_target.system = l_target.system.application_target.system then
					l_target := l_target.system.application_target
				else
					check
						library_target: l_target.system.library_target /= Void
					end
					l_target := l_target.system.library_target
				end
				a_list.put_front (create{QL_TARGET}.make (l_target))
				l_lib := l_target.system.lowest_used_in_library
				if l_lib /= Void  then
					find_path_from_conf_group (a_list, l_lib)
				end
			end
		end

	set_parents (a_list: LIST [QL_ITEM]) is
			-- Set parent of every item in `a_list'.
		require
			a_list_attached: a_list /= Void
		local
			l_last_item: QL_ITEM
		do
			if a_list.count >= 2 then
				from
					a_list.start
					l_last_item := a_list.item
					a_list.forth
				until
					a_list.after
				loop
					a_list.item.set_parent (l_last_item)
					l_last_item := a_list.item
					a_list.forth
				end
			end
		end

feature{NONE} -- Implementation

	constrained_type (a_class_c: CLASS_C; a_type: TYPE_A): TYPE_A is
			-- Constrained type of `a_type'.
		require
			a_class_c_attached: a_class_c /= Void
			a_type_not_void: a_type /= Void
		local
			l_formal_type: FORMAL_A
		do
			if a_type.is_formal then
				l_formal_type ?= a_type
				Result := a_class_c.constraint (l_formal_type.position)
			else
				Result := a_type
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
