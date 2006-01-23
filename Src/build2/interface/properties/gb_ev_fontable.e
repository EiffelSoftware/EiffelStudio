indexing
	description: "Objects that manipulate objects of type EV_FONTABLE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_FONTABLE
	
	-- The following properties from EV_FONTABLE are manipulated by `Current'.
	-- Font - Performed on the real object and the display_object.

inherit
	GB_EV_ANY
		undefine
			attribute_editor
		end
		
	GB_EV_FONTABLE_EDITOR_CONSTRUCTOR


feature {GB_XML_STORE} -- Output

	generate_xml (element: XM_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		local
			font: EV_FONT
			fontable: EV_FONTABLE
		do
			font := first.font
			
			fontable ?= default_object_by_type (class_name (first))
			if not fontable.font.is_equal (font) or uses_constant (font_string) then
				add_font_element (element, font_string, objects.first.font)
			end
		end

	modify_from_xml (element: XM_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
			element_info: ELEMENT_INFORMATION
			font: EV_FONT
			font_constant: GB_FONT_CONSTANT
			constant_context: GB_CONSTANT_CONTEXT
		do
			full_information := get_unique_full_info (element)
				-- Must only set the font if a font was really contained.
			if full_information @ font_family_string /= Void then
				create font
				element_info := full_information @ (font_family_string)
				if element_info /= Void then
					font.set_family (element_info.data.to_integer)
				end
				element_info := full_information @ (font_weight_string)
				if element_info /= Void then
					font.set_weight (element_info.data.to_integer)
				end
				element_info := full_information @ (font_shape_string)
				if element_info /= Void then
					font.set_shape (element_info.data.to_integer)
				end
				element_info := full_information @ (font_height_string)
				if element_info /= Void then
					font.set_height (element_info.data.to_integer)
				end
					-- We have code for both the old and the new font height
					-- to maintain backwards compatibility for older projects which
					-- did not use points.
				element_info := full_information @ (font_height_points_string)
				if element_info /= Void then
					font.set_height_in_points (element_info.data.to_integer)
				end
				element_info := full_information @ (font_preferred_family_string)
				if element_info /= Void then
					font.preferred_families.extend (element_info.data)
				end
				for_all_objects (agent {EV_FONTABLE}.set_font (font))
			else
				element_info := full_information @ font_string
				if element_info /= Void then
					font_constant ?= components.constants.all_constants.item (element_info.data)
					create constant_context.make_with_context (font_constant, object, type, font_string)
					font_constant.add_referer (constant_context)
					object.add_constant_context (constant_context)
					for_all_objects (agent {EV_FONTABLE}.set_font (font_constant.value))
				end
			end
		end

feature {GB_CODE_GENERATOR} -- Output

	generate_code (element: XM_ELEMENT; info: GB_GENERATED_INFO): ARRAYED_LIST [STRING] is
			-- `Result' is string representation of
			-- settings held in `Current' which is
			-- in a compilable format.
		local
			element_info: ELEMENT_INFORMATION
			value: INTEGER
			temp_string: STRING
		do
			create Result.make (5)
			full_information := get_unique_full_info (element)
			element_info := full_information @ (font_family_string)
				-- As we are maining backwards compatibility, we check both entries.
			if element_info = Void then
				element_info := full_information @ (font_string)
			end
			if element_info /= Void then
				if element_info.is_constant then
					Result.extend (font_constant_set_procedures_string + ".extend (agent " + info.actual_name_for_feature_call + "set_font (?))")
					Result.extend (font_constant_retrieval_functions_string + ".extend (agent " + retrieve_string_setting (font_string) + ")")
				else
					info.enable_fonts_set
					Result.extend ("create internal_font")
					temp_string := "internal_font.set_family (feature {EV_FONT_CONSTANTS}."
					check
						data_is_integer: element_info.data.is_integer
					end
					value := element_info.data.to_integer
					inspect value
					when feature {EV_FONT_CONSTANTS}.Family_screen then
						temp_string.append ("Family_screen)")
					when feature {EV_FONT_CONSTANTS}.Family_roman then
						temp_string.append ("Family_roman)")
					when feature {EV_FONT_CONSTANTS}.Family_sans then
						temp_string.append ("Family_sans)")
					when feature {EV_FONT_CONSTANTS}.Family_typewriter then
						temp_string.append ("Family_typewriter)")
					when feature {EV_FONT_CONSTANTS}.Family_modern then
						temp_string.append ("Family_modern)")
					else
						check
							Invalid_value: False
						end
					end
					Result.extend (temp_string)

					element_info := full_information @ (font_weight_string)
					if element_info /= Void then
						temp_string := "internal_font.set_weight (feature {EV_FONT_CONSTANTS}."
						check
							data_is_integer: element_info.data.is_integer
						end		
						value := element_info.data.to_integer
						inspect value
						when feature {EV_FONT_CONSTANTS}.weight_thin then
							temp_string.append ("Weight_thin)")
						when feature {EV_FONT_CONSTANTS}.weight_regular then
							temp_string.append ("Weight_regular)")
						when feature {EV_FONT_CONSTANTS}.weight_bold then
							temp_string.append ("Weight_bold)")
						when feature {EV_FONT_CONSTANTS}.weight_black then
							temp_string.append ("Weight_black)")
						else
							check
								Invalid_value: False
							end
						end						
					end
					Result.extend (temp_string)
					
					element_info := full_information @ (font_shape_string)
					if element_info /= Void then
						temp_string := "internal_font.set_shape (feature {EV_FONT_CONSTANTS}."
						check
							data_is_integer: element_info.data.is_integer
						end		
						value := element_info.data.to_integer
						inspect value
						when feature {EV_FONT_CONSTANTS}.shape_regular then
							temp_string.append ("Shape_regular)")
						when feature {EV_FONT_CONSTANTS}.shape_italic then
							temp_string.append ("Shape_italic)")
						else
							check
								Invalid_value: False
							end
						end
						Result.extend (temp_string)
					end
					element_info := full_information @ (font_height_points_string)
					if element_info /= Void then
						Result.extend ("internal_font.set_height_in_points (" + element_info.data + ")")
					end
					element_info := full_information @ (font_preferred_family_string)
					if element_info /= Void then
						Result.extend ("internal_font.preferred_families.extend (%"" + element_info.data + "%")")
					end
					Result.extend (info.actual_name_for_feature_call + "set_font (internal_font)")
				end
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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


end -- class GB_EV_DESELECTABLE
