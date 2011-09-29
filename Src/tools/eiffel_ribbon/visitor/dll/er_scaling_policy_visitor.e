note
	description: "[
					Group scaling policy loader
				]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_SCALING_POLICY_VISITOR

inherit
	ER_VISITOR
		redefine
			visit_scaling_policy
		end

feature -- Command

	visit_scaling_policy (a_scaling_policy: ER_XML_TREE_ELEMENT)
			-- <Precursor>
		do
			if attached {ER_XML_TREE_ELEMENT} a_scaling_policy.parent as l_parent then
				check l_parent.name.same_string (constants.tab) end

				vision2_tab_tree_node := remove_tab_scaling_policy_from_parent (l_parent)

				-- Update parent's data
				from
					a_scaling_policy.start
				until
					a_scaling_policy.after
				loop
					if attached {ER_XML_TREE_ELEMENT} a_scaling_policy.item_for_iteration as l_item and then
						l_item.name.same_string ({ER_XML_CONSTANTS}.scaling_policy) then
						update_scaling_policy (l_item)
					end

					a_scaling_policy.forth
				end
			end
		end

feature {NONE} -- Implementation

	update_scaling_policy (a_scaling_policy: ER_XML_TREE_ELEMENT)
			-- Update scaling policy data to Vision2 Tree node group items
		require
			not_void: a_scaling_policy /= Void
			valid: a_scaling_policy.name.same_string ({ER_XML_CONSTANTS}.scaling_policy)
		do
			from
				a_scaling_policy.start
			until
				a_scaling_policy.after
			loop
				if attached {ER_XML_TREE_ELEMENT} a_scaling_policy.item_for_iteration as l_item then
					if l_item.name.same_string ({ER_XML_CONSTANTS}.scaling_policy_ideal_sizes) then
						from
							l_item.start
						until
							l_item.after
						loop
							if attached {ER_XML_TREE_ELEMENT} l_item.item_for_iteration as l_ideal_sizes_item and then
								l_ideal_sizes_item.name.same_string ({ER_XML_CONSTANTS}.scale) then
								update_vision2_group_data (l_ideal_sizes_item, True)
							end
							l_item.forth
						end
					elseif l_item.name.same_string ({ER_XML_CONSTANTS}.scale) then
						update_vision2_group_data (l_item, False)
					end
				end
				a_scaling_policy.forth
			end
		end

	update_vision2_group_data (a_scale: ER_XML_TREE_ELEMENT; a_is_ideal_size: BOOLEAN)
			-- Update Vision2's group tree node data
		require
			not_void: a_scale /= Void
			valid: a_scale.name.same_string ({ER_XML_CONSTANTS}.scale)
		local
			l_group_name: detachable STRING
		do
			from
				a_scale.start
			until
				a_scale.after
			loop
				if attached {XML_ATTRIBUTE} a_scale.item_for_iteration as l_attribute then
					if l_attribute.name.same_string ({ER_XML_ATTRIBUTE_CONSTANTS}.group) then
						l_group_name := l_attribute.value
					elseif l_attribute.name.same_string ({ER_XML_ATTRIBUTE_CONSTANTS}.size) then
						if l_group_name /= Void then
							if attached group_data_for (l_group_name) as l_group_data then
								if a_is_ideal_size then
									if l_attribute.value.same_string ({ER_XML_ATTRIBUTE_CONSTANTS}.large) then
										l_group_data.set_ideal_sizes_large_checked (True)
									elseif l_attribute.value.same_string ({ER_XML_ATTRIBUTE_CONSTANTS}.medium) then
										l_group_data.set_ideal_sizes_medium_checked (True)
									elseif l_attribute.value.same_string ({ER_XML_ATTRIBUTE_CONSTANTS}.small) then
										l_group_data.set_ideal_sizes_small_checked (True)
									end
								else
									if l_attribute.value.same_string ({ER_XML_ATTRIBUTE_CONSTANTS}.large) then
										l_group_data.set_scale_large_checked (True)
									elseif l_attribute.value.same_string ({ER_XML_ATTRIBUTE_CONSTANTS}.medium) then
										l_group_data.set_scale_medium_checked (True)
									elseif l_attribute.value.same_string ({ER_XML_ATTRIBUTE_CONSTANTS}.small) then
										l_group_data.set_scale_small_checked (True)
									elseif l_attribute.value.same_string ({ER_XML_ATTRIBUTE_CONSTANTS}.popup) then
										l_group_data.set_scale_popup_checked (True)
									end
								end
							end
						else
							check group_name_must_set_first: False end
						end
					end
				end

				a_scale.forth
			end
		end

	group_data_for (a_command_name: STRING): detachable ER_TREE_NODE_GROUP_DATA
			-- Group data for `a_command_name'
		do
			if attached vision2_tab_tree_node as l_tab then
				from
					l_tab.start
				until
					l_tab.after or Result /= Void
				loop
					if attached {EV_TREE_ITEM} l_tab.item as l_group then
						if attached {ER_TREE_NODE_GROUP_DATA} l_group.data as l_data then
							if attached l_data.command_name as l_command_name and then
								l_command_name.same_string (a_command_name) then
								Result := l_data
							end
						end
					end

					l_tab.forth
				end
			end
		end

	remove_tab_scaling_policy_from_parent (a_parent_tab: ER_XML_TREE_ELEMENT): detachable EV_TREE_NODE
			-- Remove tab_scaling_policy from parent in Vision2 tree
		require
			not_void: a_parent_tab /= Void
		local
			l_one_layout_constructor: ER_LAYOUT_CONSTRUCTOR
			l_nodes: ARRAYED_LIST [EV_TREE_NODE]
			l_found: BOOLEAN
		do
			if shared.layout_constructor_list.count >= 1 then
				l_one_layout_constructor := shared.layout_constructor_list.first

				if attached command_name_of (a_parent_tab) as l_command_name then
					l_nodes := l_one_layout_constructor.all_items_with_command_name_in_all_constructors (l_command_name)
					check l_nodes.count = 1 end
					Result := l_nodes.first

					from
						-- Remove child tab_scaling_policy item that loaded previously
						Result.start
					until
						Result.after or l_found
					loop
						if attached {EV_TREE_ITEM} Result.item as l_item then
							if l_item.text.same_string (constants.tab_scaling_policy) then
								l_found := True
								Result.prune_all (l_item)
							end
						end
						if not l_found then
							Result.forth
						end
					end
				end
			end
		end

	command_name_of (a_tab: ER_XML_TREE_ELEMENT): detachable STRING
			-- Find out command name of `a_tab'
		require
			not_void: a_tab /= Void
		do
			from
				a_tab.start
			until
				a_tab.after or Result /= Void
			loop
				if attached {XML_ATTRIBUTE} a_tab.item_for_iteration as l_attribute then
					if l_attribute.name.same_string ({ER_XML_ATTRIBUTE_CONSTANTS}.command_name) then
						Result := l_attribute.value
					end
				end
				if Result = void then
					a_tab.forth
				end
			end
		end

	vision2_tab_tree_node: detachable EV_TREE_NODE
			-- Parent tab Vision2 tree node
;note
	copyright: "Copyright (c) 1984-2011, Eiffel Software"
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
