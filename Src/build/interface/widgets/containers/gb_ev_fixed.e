indexing
	description: "Objects that manipulate objects of type EV_FIXED"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_FIXED

	-- The following properties from EV_FIXED are manipulated by `Current'.
	-- item_x_position - Performed on the real object and the display_object child.
	-- item_y_position - Performed on the real object and the display_object child
	-- item_width - Performed on the real object and the display_object child
	-- item_height - Performed on the real object and the display_object child

inherit
	
	GB_EV_ANY
		undefine
			attribute_editor
		redefine
			modify_from_xml_after_build
		end
		
	GB_EV_FIXED_EDITOR_CONSTRUCTOR
		
	INTERNAL
		undefine
			default_create
		end
		
	GB_SHARED_DEFERRED_BUILDER
		undefine
			default_create
		end

feature {GB_CODE_GENERATOR} -- Output

	generate_code (element: XM_ELEMENT; info: GB_GENERATED_INFO): ARRAYED_LIST [STRING] is
			-- `Result' is string representation of
			-- settings held in `Current' which is
			-- in a compilable format.
		local
			element_info: ELEMENT_INFORMATION
			temp_x_position_string, temp_y_position_string,
			temp_width_string, temp_height_string: STRING
			counter: INTEGER
			lower, upper: INTEGER
			current_child_name: STRING
			children_names: ARRAYED_LIST [STRING]
		do
			create Result.make (8)
			full_information := get_unique_full_info (element)
			element_info := full_information @ (x_position_string)
			if element_info /= Void then
				temp_x_position_string := element_info.data
			end
			element_info := full_information @ (y_position_string)
			if element_info /= Void then
				temp_y_position_string := element_info.data
			end
			element_info := full_information @ (width_string)
			if element_info /= Void then
				temp_width_string := element_info.data
			end
			element_info := full_information @ (height_string)
			if element_info /= Void then
				temp_height_string := element_info.data
			end
			if temp_x_position_string /= Void then
				check
					strings_equal_in_length: temp_x_position_string.count = temp_y_position_string.count and
						temp_x_position_string.count = temp_width_string.count and
						temp_x_position_string.count = temp_height_string.count
					strings_divisible_by_4: temp_x_position_string.count \\ 4 = 0
						-- Cannot check this, as `Current' will have been built especially
						-- for code generation purposes, and `objects' will be empty,
						-- hence `first' will be Void.
					--strings_correct_length: temp_x_position_string.count // 4 = first.count			
				end
				Result.extend ("%T-- Size and position all children of `" + info.name + "'.")
				children_names := info.child_names
				from
					counter := 1
				until
					counter = temp_x_position_string.count // 4 + 1
				loop
					lower := (counter - 1) * 4 + 1
					upper := (counter - 1) * 4 + 4
					current_child_name := children_names @ counter
					Result.extend (info.actual_name_for_feature_call + "set_item_x_position (" + current_child_name + ", " + temp_x_position_string.substring (lower, upper) + ")")
					Result.extend (info.actual_name_for_feature_call + "set_item_y_position (" + current_child_name + ", " + temp_y_position_string.substring (lower, upper) + ")")
					Result.extend (info.actual_name_for_feature_call + "set_item_width (" + current_child_name + ", " + temp_width_string.substring (lower, upper) + ")")
					Result.extend (info.actual_name_for_feature_call + "set_item_height (" + current_child_name + ", " + temp_height_string.substring (lower, upper) + ")")
					counter := counter + 1
				end
			end
		end
		
feature {GB_XML_STORE} -- Output

	
	generate_xml (element: XM_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		local
			temp_x_position_string, temp_y_position_string,
			temp_width_string, temp_height_string: STRING
		do
			temp_x_position_string := ""
			temp_y_position_string := ""
			temp_width_string := ""
			temp_height_string := ""
			from
				first.start
			until
				first.off
			loop
				temp_x_position_string := temp_x_position_string + add_leading_zeros (first.item.x_position.out, 4)
				temp_y_position_string := temp_y_position_string + add_leading_zeros (first.item.y_position.out, 4)
				temp_width_string := temp_width_string + add_leading_zeros (first.item.width.out, 4)
				temp_height_string := temp_height_string + add_leading_zeros (first.item.height.out, 4)
				first.forth
			end
			if not temp_x_position_string.is_empty then
				add_element_containing_string (element, x_position_string, temp_x_position_string)
			end
			if not temp_y_position_string.is_empty then
				add_element_containing_string (element, y_position_string, temp_y_position_string)
			end
			if not temp_width_string.is_empty then
				add_element_containing_string (element, width_string, temp_width_string)
			end
			if not temp_height_string.is_empty then
				add_element_containing_string (element, height_string, temp_height_string)
			end
		end
		
	modify_from_xml (element: XM_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		do
				-- All the building for an EV_FIXED needs to be deferred so
				-- we set up some deferred building now.
			deferred_builder.defer_building (Current, element)
		end
		
feature {GB_DEFERRED_BUILDER} -- Status setting

	modify_from_xml_after_build (element: XM_ELEMENT) is
			-- Build from XML any information that was
			-- deferred during the load/build cycle.
		local
			element_info: ELEMENT_INFORMATION
			temp_x_position_string, temp_y_position_string,
			temp_width_string, temp_height_string: STRING
			extracted_string: STRING
			lower, upper: INTEGER
		do
			full_information := get_unique_full_info (element)
			element_info := full_information @ (x_position_string)
			if element_info /= Void then
				temp_x_position_string := element_info.data				
			end
			
			element_info := full_information @ (y_position_string)
			if element_info /= Void then
				temp_y_position_string := element_info.data				
			end
			
			element_info := full_information @ (width_string)
			if element_info /= Void then
				temp_width_string := element_info.data				
			end
			
			element_info := full_information @ (height_string)
			if element_info /= Void then
				temp_height_string := element_info.data				
			end
			
			if temp_x_position_string /= Void then
				-- Nothing to do now, if there are no children.
				check
					strings_equal_in_length: temp_x_position_string.count = temp_y_position_string.count and
						temp_x_position_string.count = temp_width_string.count and
						temp_x_position_string.count = temp_height_string.count
					strings_divisible_by_4: temp_x_position_string.count \\ 4 = 0
					strings_correct_length: temp_x_position_string.count // 4 = first.count
				end

			
				from
					first.start
				until
					first.off
				loop
					lower := (first.index - 1) * 4 + 1
					upper := (first.index - 1) * 4 + 4
						-- Read current x position data from `temp_x_position_string'.
					extracted_string := temp_x_position_string.substring (lower, upper)
					check
						value_is_integer: extracted_string.is_integer
					end
					set_item_x_position (first.item, extracted_string.to_integer)
						
						-- Read current y position data from `temp_y_position_string'.
					extracted_string := temp_y_position_string.substring (lower, upper)
					check
						value_is_integer: extracted_string.is_integer
					end
					set_item_y_position (first.item, extracted_string.to_integer)
					
						-- Read current width data from `temp_width_string'.
					extracted_string := temp_width_string.substring (lower, upper)
					check
						value_is_integer: extracted_string.is_integer
					end
					set_item_width (first.item, extracted_string.to_integer)
					
						-- Read current height data from `temp_height_string'.
					extracted_string := temp_height_string.substring (lower, upper)
					check
						value_is_integer: extracted_string.is_integer
					end
					set_item_height (first.item, extracted_string.to_integer)
					
					first.forth
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


end -- class GB_EV_FIXED
