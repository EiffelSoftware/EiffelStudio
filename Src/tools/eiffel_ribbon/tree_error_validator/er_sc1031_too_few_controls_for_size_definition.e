note
	description: "[
		Group contains too few controls for the chosen SizeDefinition
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_SC1031_TOO_FEW_CONTROLS_FOR_SIZE_DEFINITION

inherit
	ER_TREE_VALIDATION_VISITOR
		redefine
			visit_ribbon_tabs
		end

feature -- Command

	visit_ribbon_tabs (a_tree_node: EV_TREE_NODE)
			-- <Precursor>
		do
			visit_node_recursive (a_tree_node)
		end

feature {NONE} -- Implementation

	visit_node_recursive (a_tree_node: EV_TREE_NODE)
			-- Visit tree node recursively
		local
			l_child_button_count: INTEGER
			l_size_definition: detachable STRING
		do
			if a_tree_node.text.same_string ({ER_XML_CONSTANTS}.group) then
				if attached {ER_TREE_NODE_GROUP_DATA} a_tree_node.data as l_group_data then
					l_size_definition := l_group_data.size_definition
				end

				if l_size_definition /= Void then
					from
						a_tree_node.start
					until
						a_tree_node.after
					loop
						if attached {EV_TREE_NODE} a_tree_node.item as l_element then
							l_child_button_count := l_child_button_count + 1
						end
						a_tree_node.forth
					end

					if not button_count_of_size_definition_valid (l_child_button_count, l_size_definition) then
						display_error_on_tree_node (a_tree_node, "Group contains too few controls for the chosen SizeDefinition")
					end
				end
			else
				across a_tree_node as l_cursor loop
					visit_node_recursive (l_cursor.item)
				end
			end
		end

	button_count_of_size_definition_valid (a_test_count: INTEGER; a_size_definition_name: STRING): BOOLEAN
			-- If `a_size_definition_name' with `a_test_count' controls valid?
			-- Result false means `a_test_count' is TOO FEW
		local
			l_node_widget: ER_GROUP_NODE_WIDGET
			l_predefines: ARRAYED_LIST [STRING]
			l_customized_size_defs: HASH_TABLE [INTEGER, STRING]
		do
			-- First find in predefined size definitions
			Result := True -- by default, is valid
			create l_node_widget
			l_predefines := l_node_widget.predefined_size_definitions
			l_predefines.compare_objects
			if l_predefines.has (a_size_definition_name) then
				if a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.onebutton) then
					Result := a_test_count >= 1
				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.twobuttons) then
					Result := a_test_count >= 2
				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.threebuttons) then
					Result := a_test_count >= 3
				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.ThreeButtons_OneBigAndTwoSmall) then
					Result := a_test_count >= 3
				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.ThreeButtonsAndOneCheckBox) then
					Result := a_test_count >= 4
				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.FourButtons) then
					Result := a_test_count >= 4
				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.FiveButtons) then
					Result := a_test_count >= 5
				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.FiveOrSixButtons) then
					Result := a_test_count >= 5
				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.SixButtons) then
					Result := a_test_count >= 6
				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.SixButtons_TwoColumns) then
					Result := a_test_count >= 6
				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.SevenButtons) then
					Result := a_test_count >= 7
				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.EightButtons) then
					Result := a_test_count >= 8
				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.EightButtons_LastThreeSmall) then
					Result := a_test_count >= 8
				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.NineButtons) then
					Result := a_test_count >= 9
				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.TenButtons) then
					Result := a_test_count >= 10
				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.ElevenButtons) then
					Result := a_test_count >= 11
				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.OneFontControl) then
					Result := a_test_count >= 1
				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.IntFontOnly) then
					Result := a_test_count >= 1
				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.IntRichFont) then
					Result := a_test_count >= 1
				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.IntFontWithColor) then
					Result := a_test_count >= 1
				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.OneInRibbonGallery) then
					Result := a_test_count >= 1
				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.BigButtonsAndSmallButtonsOrInputs) then
					Result := a_test_count >= 2 -- FIXME: need check later
				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.InRibbonGalleryAndBigButton) then
					Result := a_test_count >= 2
				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.InRibbonGalleryAndButtons_GalleryScalesFirst) then
					Result := a_test_count >= 2
				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.InRibbonGalleryAndThreeButtons) then
					Result := a_test_count >= 4
				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.ButtonGroupsAndInputs) then
					Result := a_test_count >= 2
				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.ButtonGroups) then
					Result := a_test_count >= 1 -- FIXME: need check later
				end
			else
				-- Is custom size definition
				l_customized_size_defs := child_count_of_customized_size_definitions
				if l_customized_size_defs.count > 0 then
					if l_customized_size_defs.has (a_size_definition_name) then
						Result := a_test_count >= l_customized_size_defs.item (a_size_definition_name)
					end
				end
			end
		end

feature -- Helper

	child_count_of_customized_size_definitions: HASH_TABLE [INTEGER, STRING]
			-- Child button count of custoized size definition
			-- Result hash table key is Size Definition name, result hash table value is child count
		local
			l_shared: ER_SHARED_TOOLS
			l_root_size_def: XML_ELEMENT
			l_control_name_def_count: INTEGER
			l_size_def: detachable STRING
			l_writer: ER_SIZE_DEFINITION_WRITER
		do
			create Result.make (10)
			create l_shared
			if attached l_shared.size_definition_cell.item as l_size_def_tool then
				l_writer := l_size_def_tool.size_definition_writer
				if not l_writer.is_empty then
					l_root_size_def := l_writer.root_xml_for_saving

					from
						l_root_size_def.start
					until
						l_root_size_def.after
					loop
						if attached {XML_ELEMENT} l_root_size_def.item_for_iteration as l_one_size_def then
							check l_one_size_def.name.same_string ({ER_XML_CONSTANTS}.size_definition) end
							from
								l_size_def := Void
								l_control_name_def_count := 0
								l_one_size_def.start
							until
								l_one_size_def.after
							loop
								if attached {XML_ELEMENT} l_one_size_def.item_for_iteration as l_one_control_name_map
									and then l_one_control_name_map.name.same_string ({ER_XML_CONSTANTS}.control_name_map) then
									l_control_name_def_count := l_one_control_name_map.count
								elseif attached {XML_ATTRIBUTE} l_one_size_def.item_for_iteration as l_size_def_name and then
									l_size_def_name.name.same_string ({ER_XML_ATTRIBUTE_CONSTANTS}.name) then
									l_size_def := l_size_def_name.value
								end
								l_one_size_def.forth
							end

							if attached l_size_def and l_control_name_def_count > 0 then
								Result.put (l_control_name_def_count, l_size_def)
							else
								check error: False end
							end
						end
						l_root_size_def.forth
					end
				end
			end
		end
note
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
