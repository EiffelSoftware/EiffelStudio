note
	description: "[
		Controls of type '[string name]' cannot be used at this location in group SizeDefinition '[string name]'.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_SC1046_WRONG_CONTROL_TYPE

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
			l_child_control_types: ARRAYED_LIST [INTEGER]
			l_size_definition: detachable STRING
		do
			if a_tree_node.text.same_string ({ER_XML_CONSTANTS}.group) then
				if attached {ER_TREE_NODE_GROUP_DATA} a_tree_node.data as l_group_data then
					l_size_definition := l_group_data.size_definition
				end

				if l_size_definition /= Void then
					from
						create l_child_control_types.make (a_tree_node.count)
						a_tree_node.start
					until
						a_tree_node.after
					loop
						if attached {EV_TREE_NODE} a_tree_node.item as l_element then
							if l_element.text.same_string ({ER_XML_CONSTANTS}.font_control) then
								l_child_control_types.extend (font_control)
							elseif l_element.text.same_string ({ER_XML_CONSTANTS}.in_ribbon_gallery) then
								l_child_control_types.extend (in_ribbon_gallery_control)
							else
								l_child_control_types.extend (unknown_control)
							end
						end
						a_tree_node.forth
					end

					if not control_type_of_size_definition_valid (l_child_control_types, l_size_definition) then
						display_error_on_tree_node (a_tree_node, "Control(s) cannot be used at this group with selected SizeDefinition")
					end
				end
			else
				across a_tree_node as l_cursor loop
					visit_node_recursive (l_cursor.item)
				end
			end
		end

	control_type_of_size_definition_valid (a_control_type_list: ARRAYED_LIST [INTEGER]; a_size_definition_name: STRING): BOOLEAN
			-- If `a_control_type_list' valid for `a_size_definition_name'?
		local
			l_node_widget: ER_GROUP_NODE_WIDGET
			l_predefines: ARRAYED_LIST [STRING]
			l_customized_size_defs: HASH_TABLE [INTEGER, STRING]
			l_helper: ER_SC1031_TOO_FEW_CONTROLS_FOR_SIZE_DEFINITION
		do
			-- First find in predefined size definitions
			create l_node_widget
			l_predefines := l_node_widget.predefined_size_definitions
			l_predefines.compare_objects
			Result := True -- by default, is valid
			a_control_type_list.compare_objects
			if l_predefines.has (a_size_definition_name) then
				if a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.onebutton) then

				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.twobuttons) then

				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.threebuttons) then

				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.ThreeButtons_OneBigAndTwoSmall) then

				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.ThreeButtonsAndOneCheckBox) then

				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.FourButtons) then

				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.FiveButtons) then

				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.FiveOrSixButtons) then

				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.SixButtons) then

				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.SixButtons_TwoColumns) then

				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.SevenButtons) then

				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.EightButtons) then

				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.EightButtons_LastThreeSmall) then

				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.NineButtons) then

				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.TenButtons) then

				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.ElevenButtons) then

				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.OneFontControl) then
					Result := a_control_type_list.has (font_control)
				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.IntFontOnly) then
					Result := a_control_type_list.has (font_control)
				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.IntRichFont) then
					Result := a_control_type_list.has (font_control)
				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.IntFontWithColor) then
					Result := a_control_type_list.has (font_control)
				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.OneInRibbonGallery) then
					-- OneInRibbonGallery can contain control other than InRibbonGallery control, UICC.exe compiles fine
--					Result := a_control_type_list.has (in_ribbon_gallery_control)
				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.BigButtonsAndSmallButtonsOrInputs) then

				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.InRibbonGalleryAndBigButton) then
--					Result := a_control_type_list.has (in_ribbon_gallery_control)
				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.InRibbonGalleryAndButtons_GalleryScalesFirst) then
--					Result := a_control_type_list.has (in_ribbon_gallery_control)
				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.InRibbonGalleryAndThreeButtons) then
--					Result := a_control_type_list.has (in_ribbon_gallery_control)
				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.ButtonGroupsAndInputs) then

				elseif a_size_definition_name.same_string ({ER_GROUP_NODE_WIDGET}.ButtonGroups) then

				end
			else
				-- Is custom size definition
				create l_helper
				l_customized_size_defs := l_helper.child_count_of_customized_size_definitions
				if l_customized_size_defs.count > 0 then
					if l_customized_size_defs.has (a_size_definition_name) then
--						Result := a_control_type >= l_customized_size_defs.item (a_size_definition_name)
					end
				end
			end
		end

feature -- Enumeration

	font_control: INTEGER = 1
			-- Font control

	in_ribbon_gallery_control: INTEGER = 2
			-- In ribbon gallery

	unknown_control: INTEGER = 100
			-- Unknown control
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
