note
	description: "Stone utilities"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_STONE_UTILITY

inherit
	EB_CONSTANTS

feature -- Access

	name_of_stone (a_stone: STONE): STRING_32
			-- Name of `a_stone'
		require
			a_stone_attached: a_stone /= Void
		local
			l_target_stone: TARGET_STONE
			l_cluster_stone: CLUSTER_STONE
			l_class_stone: CLASSC_STONE
			l_feature_stone: FEATURE_STONE
			l_group: CONF_GROUP
		do
			l_feature_stone ?= a_stone
			l_class_stone ?= a_stone
			l_cluster_stone ?= a_stone
			l_target_stone ?= a_stone
			create Result.make (64)
			if l_feature_stone /= Void and then l_feature_stone.is_valid then
				Result.append (interface_names.string_general_as_lower (interface_names.s_feature_stone))
				Result.append (l_feature_stone.e_feature.name)
			elseif l_class_stone /= Void and then l_class_stone.is_valid then
				Result.append (interface_names.string_general_as_lower (interface_names.s_class_stone))
				Result.append (l_class_stone.class_name)
			elseif l_cluster_stone /= Void and then l_cluster_stone.is_valid then
				if not l_cluster_stone.path.is_empty then
						-- For a folder
					Result.append (interface_names.string_general_as_lower (interface_names.s_folder_stone))
					Result.append (l_cluster_stone.folder_name)
				else
						-- For a group
					l_group := l_cluster_stone.group
					if l_group.is_library then
						Result.append (interface_names.string_general_as_lower (interface_names.s_library_stone))
					elseif l_group.is_cluster then
						Result.append (interface_names.string_general_as_lower (interface_names.s_cluster_stone))
					elseif l_group.is_assembly then
						Result.append (interface_names.string_general_as_lower (interface_names.s_assembly_stone))
					end
					Result.append (l_group.name)
				end
			elseif l_target_stone /= Void and then l_target_stone.is_valid then
				Result.append (interface_names.string_general_as_lower (interface_names.s_target_stone))
				Result.append (l_target_stone.target.name)
			else
				Result := a_stone.stone_name.as_string_32
			end
		ensure
			result_attached: Result /= Void
		end

	stone_from_ql_item (a_item: QL_ITEM): STONE
			-- Stone from `a_item'
		require
			a_item_attached: a_item /= Void
		local
			l_target: QL_TARGET
			l_class: QL_CLASS
			l_feature: QL_REAL_FEATURE
			l_group: QL_GROUP
			l_code: QL_CODE_STRUCTURE_ITEM
		do
			if a_item /= Void then
				if a_item.is_class then
					l_class ?= a_item
					if l_class.class_c /= Void then
						create {CLASSC_STONE} Result.make (l_class.class_c)
					else
						create {CLASSI_STONE} Result.make (l_class.class_i)
					end
				elseif a_item.is_real_feature then
					l_feature ?= a_item
					create {FEATURE_STONE} Result.make (l_feature.e_feature)
				elseif a_item.is_group then
					l_group ?= a_item
					create {CLUSTER_STONE} Result.make (l_group.group)
				elseif a_item.is_code_structure then
					l_code ?= a_item
					create {AST_STONE} Result.make (l_code.written_class, l_code.ast)
				elseif a_item.is_target then
					l_target ?= a_item
					create {TARGET_STONE} Result.make (l_target.target)
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
