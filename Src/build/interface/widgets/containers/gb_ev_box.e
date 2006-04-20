indexing
	description: "Objects that manipulate objects of type EV_BOX"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_BOX

	-- The following properties from EV_BOX are manipulated by `Current'.
	-- Is_homgeneous - Performed on the real object and the display_object child.
	-- Padding width - Performed on the real object and the display_object child
	-- Border_width - Performed on the real object and the display_object child
	-- Is_item_expanded - Performed on the real object and the display_object child

inherit
	
	GB_EV_ANY
		undefine
			attribute_editor
		redefine
			modify_from_xml_after_build
		end
		
	GB_XML_UTILITIES
		undefine
			default_create
		end
		
	GB_EV_BOX_EDITOR_CONSTRUCTOR
		
	GB_SHARED_DEFERRED_BUILDER
		undefine
			default_create
		end

feature {GB_XML_STORE} -- Output

	generate_xml (element: XM_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		local
			temp_string: STRING
		do
				-- Boxes are not homogeneous by default.
			if objects.first.is_homogeneous = True then
				add_element_containing_boolean (element, Is_homogeneous_string, objects.first.is_homogeneous)
			end
				-- Padding is 0 by default.
			if objects.first.padding_width > 0 or uses_constant (Padding_string) then
				add_integer_element (element, Padding_string, objects.first.padding_width)	
			end
				-- Border is 0 by default.
			if objects.first.border_width > 0 or uses_constant (Border_string) then
				add_integer_element (element, Border_string, objects.first.border_width)
			end
			
				-- If there are one or more children in the box, then we always
				-- store the string of details. This could be changed to be made smarter
				-- at some point, so we only store if one ore more are not expanded.
				-- Initialize `temp_string' as empty.
			temp_string := ""
			from
				first.start
			until
				first.off
			loop
						-- For each child that is expandable add "1" else add "0".
					if first.is_item_expanded (first.item) then
						temp_string := temp_string + "1"
					else
						temp_string := temp_string + "0"
					end
				first.forth
			end
			if not temp_string.is_empty then
				add_element_containing_string (element, Is_item_expanded_string, temp_string)
			end
		end
		
	modify_from_xml (element: XM_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
			element_info: ELEMENT_INFORMATION
		do
			full_information := get_unique_full_info (element)
			
			element_info := full_information @ (Is_homogeneous_string)
			if element_info /= Void then
				if element_info.data.is_equal (True_string) then
					for_all_objects (agent {EV_BOX}.enable_homogeneous)
				else
					for_all_objects (agent {EV_BOX}.disable_homogeneous)
				end
			end

			if attribute_set (Padding_string) then
				for_all_objects (agent {EV_BOX}.set_padding_width (retrieve_and_set_integer_value (Padding_string)))
			end
			
			if attribute_set (Border_string) then
				for_all_objects (agent {EV_BOX}.set_border_width (retrieve_and_set_integer_value (Border_string)))
			end
		
				-- We set up some deferred building now.
			deferred_builder.defer_building (Current, element)
		end
		
feature {GB_CODE_GENERATOR} -- Output

	generate_code (element: XM_ELEMENT; info: GB_GENERATED_INFO): ARRAYED_LIST [STRING] is
			-- `Result' is string representation of
			-- settings held in `Current' which is
			-- in a compilable format.
		local
			element_info: ELEMENT_INFORMATION
			children: ARRAYED_LIST [GB_GENERATED_INFO]
		do
			create Result.make (4)
			full_information := get_unique_full_info (element)
			element_info := full_information @ (Is_homogeneous_string)
			if element_info /= Void then
				if element_info.data.is_equal (True_string) then
					Result.extend (info.actual_name_for_feature_call + "enable_homogeneous")
				else
					Result.extend (info.actual_name_for_feature_call + "disable_homogeneous")
				end
			end
			
			if attribute_set (Padding_string) then
				Result.append (build_set_code_for_integer (padding_string, info.actual_name_for_feature_call, "set_padding ("))
			end
			
			if attribute_set (Border_string) then
				Result.append (build_set_code_for_integer (border_string, info.actual_name_for_feature_call, "set_border_width ("))
			end

			element_info := full_information @ (Is_item_expanded_string)
				-- We have to check that there is an `is_item_expanded' string.
			if element_info /= Void then
				children := info.children
				check
					consistent: children.count = element_info.data.count
				end
				from
					children.start
				until
					children.off
				loop
						-- We only generate code for all the children that are disabled as they
						-- are expanded by default.
					if element_info.data @ children.index /= '1' then						
						Result.extend (info.actual_name_for_feature_call + "disable_item_expand (" + children.item.ev_any_access_name + ")")
					end
					children.forth
				end
			end
		end
		
feature {GB_DEFERRED_BUILDER} -- Status setting

	modify_from_xml_after_build (element: XM_ELEMENT) is
			-- Build from XML any information that was
			-- deferred during the load/build cycle.
		local
			element_info: ELEMENT_INFORMATION
			second: like ev_type
			temp_string: STRING
			box_parent1, box_parent2: EV_BOX
			children: ARRAYED_LIST [GB_OBJECT]
		do
			full_information := get_unique_full_info (element)
			element_info := full_information @ (Is_item_expanded_string)
				-- We only stored the expanded information if there were
				-- children.
			if element_info /= Void then			
				temp_string := element_info.data
				second ?= (objects @ 2)
				box_parent1 ?= first
				box_parent2 ?= second
				check
					string_matches: temp_string.count = first.count
				end
				children := object.children
				check
					children_consistent: children.count = first.count
				end
				from
					first.start
					second.start
				until
					first.off
				loop
					if temp_string @ first.index = '1' then
						box_parent1.enable_item_expand (first.item)
						box_parent2.enable_item_expand (second.item)
					else
						box_parent1.disable_item_expand (first.item)
						box_parent2.disable_item_expand (second.item)
						
							-- Now flag the child object as non expanded.
						children.i_th (first.index).disable_expanded_in_box
					end
					first.forth
					second.forth
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


end -- class GB_EV_BOX
