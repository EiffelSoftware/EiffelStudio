indexing
	description: "Objects that manipulate objects of type EV_PROGRESS_BAR."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_PROGRESS_BAR
	
	-- The following properties from EV_PROGRESS_BAR are manipulated by `Current'.
	-- Is_segmented - Performed on the real object and the display object.

inherit
	GB_EV_ANY
		undefine
			attribute_editor
		end
		
	GB_EV_PROGRESS_BAR_EDITOR_CONSTRUCTOR

feature {GB_XML_STORE} -- Output

	generate_xml (element: XM_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		do
			if not first.is_segmented then
				add_element_containing_boolean (element, is_segmented_string, objects.first.is_segmented)
			end
		end

	modify_from_xml (element: XM_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
			element_info: ELEMENT_INFORMATION
		do
			full_information := get_unique_full_info (element)
			element_info := full_information @ (is_segmented_string)
			if element_info /= Void then
				if element_info.data.is_equal (True_string) then
					for_first_object (agent {EV_PROGRESS_BAR}.enable_segmentation)
				else
					for_first_object (agent {EV_PROGRESS_BAR}.disable_segmentation)
				end
			end
		end
		
	generate_code (element: XM_ELEMENT; info: GB_GENERATED_INFO):ARRAYED_LIST [STRING] is
			-- `Result' is string representation of
			-- settings held in `Current' which is
			-- in a compilable format.
		local
			element_info: ELEMENT_INFORMATION
		do
			create Result.make (1)
			full_information := get_unique_full_info (element)
			element_info := full_information @ (is_segmented_string)
			if element_info /= Void then
				if element_info.data.is_equal (True_string) then
					Result.extend (info.actual_name_for_feature_call + "enable_segmentation")
				else
					Result.extend (info.actual_name_for_feature_call + "disable_segmentation")
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
