note
	description: "[
					Ribbon command vistor when using DLL
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_UPDATE_COMMAND_VISITOR

inherit
	ER_VISITOR
		redefine
			visit_application_commands
		end

feature -- Command

	visit_application_commands (a_commands: ER_XML_TREE_ELEMENT)
			-- <Precursor>
		do
			from
				a_commands.start
			until
				a_commands.after
			loop
				if attached {ER_XML_TREE_ELEMENT} a_commands.item_for_iteration as l_item then
					check l_item.name.same_string (constants.command) end
					update_command_node (l_item)
				end

				a_commands.forth
			end
		end

feature {NONE} -- Implementation

	update_command_node (a_commands: ER_XML_TREE_ELEMENT)
			-- Update data in a Command xml node
		require
			valid: a_commands.name.same_string (constants.command)
		local
			l_command_name: STRING
			l_tree_nodes: ARRAYED_LIST [EV_TREE_NODE]
			l_current_command_data: detachable ER_TREE_NODE_DATA
		do
			if a_commands.name.same_string (constants.command) then
				from
					a_commands.start
				until
					a_commands.after
				loop
					if attached {XML_ATTRIBUTE} a_commands.item_for_iteration as l_attribute then
						if l_attribute.name.same_string (atrribute.name) then
							l_command_name := l_attribute.value
							l_tree_nodes := shared.layout_constructor_list.first.all_items_with_command_name_in_all_constructors (l_command_name)
--							check only_one: l_tree_nodes.count = 1 end -- ApplicationMenu and ApplicationMenu share same command name
							if not l_tree_nodes.is_empty and then attached {ER_TREE_NODE_DATA} l_tree_nodes.first.data as l_data then
								l_current_command_data := l_data
							end
						end
					elseif l_current_command_data /= Void then
						if attached {XML_ELEMENT} a_commands.item_for_iteration as l_sub_node then
							if l_sub_node.name.same_string (constants.command_label_title) then
								if l_sub_node.count > 0 and then attached {ER_XML_TREE_ELEMENT} l_sub_node.first as l_string_node then
									l_current_command_data.set_label_title (l_string_node.content)
								elseif attached {ER_XML_TREE_ELEMENT} l_sub_node as l_node then
									l_current_command_data.set_label_title (l_node.content)
								end
							elseif l_sub_node.name.same_string (constants.command_large_images) then
								check l_sub_node.count = 1 end
								if attached {ER_XML_TREE_ELEMENT} l_sub_node.first as l_string_node then
									l_current_command_data.set_large_image (l_string_node.content)
								end
							elseif l_sub_node.name.same_string (constants.command_small_images) then
								check l_sub_node.count = 1 end
								if attached {ER_XML_TREE_ELEMENT} l_sub_node.first as l_string_node then
									l_current_command_data.set_small_image (l_string_node.content)
								end
							elseif l_sub_node.name.same_string (constants.command_key_tip) then
								if l_sub_node.count > 0 and then attached {ER_XML_TREE_ELEMENT} l_sub_node.first as l_string_node then
									l_current_command_data.set_keytip (l_string_node.content)
								elseif attached {ER_XML_TREE_ELEMENT} l_sub_node as l_node then
									l_current_command_data.set_keytip (l_node.content)
								end
							end
						end
					end
					a_commands.forth
				end
			end

		end

	atrribute: ER_XML_ATTRIBUTE_CONSTANTS
			-- Attribute constants
		once
			create Result
		end
note
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
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
