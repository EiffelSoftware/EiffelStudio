indexing
	description: "Objects that manipulate objects of type EV_COLORIZABLE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_COLORIZABLE
	
	-- The following properties from EV_COLORIZABLE are manipulated by `Current'.
	-- foreground_color - Performed on the real object and the display_object.
	-- background_color - Performed on the real object and the display_object.

inherit
	GB_EV_ANY
		undefine
			attribute_editor
		end

	GB_EV_COLORIZABLE_EDITOR_CONSTRUCTOR
		undefine
			default_create
		end

	EV_DIALOG_CONSTANTS
		export
			{NONE} all
		undefine
			default_create
		end
		
	DEFAULT_OBJECT_STATE_CHECKER
		export
			{NONE} all
		undefine
			default_create
		end

feature {GB_XML_STORE} -- Output

	generate_xml (element: XM_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		local
			colorizable: EV_COLORIZABLE
			default_background, default_foreground: EV_COLOR
		do
			colorizable ?= default_object_by_type (class_name (first))
			default_background := colorizable.background_color
			default_foreground := colorizable.foreground_color
			
			if not default_background.is_equal (objects.first.background_color) or uses_constant (background_color_string) then
				add_color_element (element, background_color_string, objects.first.background_color)
			end
			if not default_foreground.is_equal (objects.first.foreground_color) or uses_constant (foreground_color_string) then
				add_color_element (element, foreground_color_string, objects.first.foreground_color)
			end
		end

	modify_from_xml (element: XM_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
			element_info: ELEMENT_INFORMATION
		do
			full_information := get_unique_full_info (element)
			element_info := full_information @ (background_color_string)
			if element_info /= Void then
				for_all_objects (agent {EV_COLORIZABLE}.set_background_color (retrieve_and_set_color_value (background_color_string)))
			end
			element_info := full_information @ (foreground_color_string)
			if element_info /= Void then
				for_all_objects (agent {EV_COLORIZABLE}.set_foreground_color (retrieve_and_set_color_value (foreground_color_string)))
			end
		end
		
feature {GB_CODE_GENERATOR} -- Output

	generate_code (element: XM_ELEMENT; info: GB_GENERATED_INFO): ARRAYED_LIST [STRING] is
			-- `Result' is string representation of
			-- settings held in `Current' which is
			-- in a compilable format.
		local
			element_info: ELEMENT_INFORMATION
			temp_color: EV_COLOR
		do
			create Result.make (2)
			full_information := get_unique_full_info (element)
			element_info := full_information @ (background_color_string)
			if element_info /= Void then
				if element_info.is_constant then
					Result.extend (color_constant_set_procedures_string + ".extend (agent " + info.actual_name_for_feature_call + "set_background_color (?))")
					Result.extend (color_constant_retrieval_functions_string + ".extend (agent " + retrieve_string_setting (background_color_string) + ")")
				else
					temp_color := build_color_from_string (element_info.data)
					Result.extend (info.actual_name_for_feature_call + "set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (" + temp_color.red_8_bit.out + ", " + temp_color.green_8_bit.out + ", " + temp_color.blue_8_bit.out + "))")
				end
			end
			element_info := full_information @ (foreground_color_string)
			if element_info /= Void then
				if element_info.is_constant then
					Result.extend (color_constant_set_procedures_string + ".extend (agent " + info.actual_name_for_feature_call + "set_foreground_color (?))")
					Result.extend (color_constant_retrieval_functions_string + ".extend (agent " + retrieve_string_setting (foreground_color_string) + ")")
				else
					temp_color := build_color_from_string (element_info.data)
					Result.extend (info.actual_name_for_feature_call + "set_foreground_color (create {EV_COLOR}.make_with_8_bit_rgb (" + temp_color.red_8_bit.out + ", " + temp_color.green_8_bit.out + ", " + temp_color.blue_8_bit.out + "))")
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


end -- class GB_EV_SENSITIVE
