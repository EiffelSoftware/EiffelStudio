indexing
	description: "Objects that manipulate objects of type EV_WIDGET"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_WIDGET
	
	-- The following properties from EV_WIDGET are manipulated by `Current'.
	-- Is_show_requested - Performed on the real object only. Not the display object
	-- Minimum_width - Performed on the real object only. Not the display object
	-- Minimum_height - Performed on the real object only. Not the display_object

inherit
	GB_EV_ANY
		undefine
			attribute_editor
		redefine
			ev_type
		end


	GB_XML_UTILITIES
		export
			{NONE} all
		undefine
			default_create
		end
		
	GB_EV_WIDGET_EDITOR_CONSTRUCTOR
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
		do
			create Result.make (3)
			full_information := get_unique_full_info (element)
			
			element_info := full_information @ (is_show_requested_string)
			if element_info /= Void then
				if element_info.data.is_equal (false_string) then
					Result.extend (info.actual_name_for_feature_call + "hide")
				end
			end
			if attribute_set (Minimum_width_string) then
				Result.append (build_set_code_for_integer (Minimum_width_string, info.actual_name_for_feature_call, "set_minimum_width ("))
			end
			if attribute_set (Minimum_height_string) then
				Result.append (build_set_code_for_integer (Minimum_height_string, info.actual_name_for_feature_call, "set_minimum_height ("))
			end
		end

feature {GB_XML_STORE} -- Output
	
	generate_xml (element: XM_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		local
			notebook_parent: EV_NOTEBOOK
		do
			notebook_parent ?= objects.first.parent
			
				-- | FIXME Windows notebook bug.
				-- On Windows, notebooks hide their contents when the containing tab is not visible.
				-- Therefore, there is a bug where querying `is_show_requested' for an item that is not
				-- in the selected tab returns `False' when it should not.
				-- We check that the item is not parented in a notebook before saving it as hidden. This does
				-- not let you hide an item within a notebook, but it definitely is better than the behaviour
				-- of items being hidden. Julian.
			
			if not objects.first.is_show_requested and not is_instance_of (first, dynamic_type_from_string ("EV_WINDOW")) and notebook_parent = Void then
				add_element_containing_boolean (element, is_show_requested_string, False)
			end
			if objects.first.minimum_width_set_by_user or uses_constant (Minimum_width_string) then
				add_integer_element (element, Minimum_width_string, objects.first.minimum_width)	
			end
			if objects.first.minimum_height_set_by_user or uses_constant (Minimum_height_string) then
				add_integer_element (element, Minimum_height_string, objects.first.minimum_height)
			end
		end
		
	modify_from_xml (element: XM_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
			information: ELEMENT_INFORMATION
		do
			full_information := get_unique_full_info (element)
			
			information := full_information @ (is_show_requested_string)
			if information /= Void then
				if information.data.is_equal (false_string) then
					for_first_object (agent {EV_WIDGET}.hide)
				end
			end
			
			if full_information @ (Minimum_width_string) /= Void then
				for_first_object (agent {EV_WIDGET}.set_minimum_width (retrieve_and_set_integer_value (Minimum_width_string)))
			end
			
			if full_information @ (Minimum_height_string) /= Void then
				for_first_object (agent {EV_WIDGET}.set_minimum_height (retrieve_and_set_integer_value (Minimum_height_string)))
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


end -- class GB_EV_WINDOW
