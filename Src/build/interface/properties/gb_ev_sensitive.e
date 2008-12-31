note
	description: "Objects that manipulate objects of type EV_SENSITIVE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_SENSITIVE

	-- The following properties from EV_SENSITIVE are manipulated by `Current'.
	-- Is_sensitive - Performed on the real object only. Not the display object.

inherit
	GB_EV_ANY
		undefine
			attribute_editor
		end

	GB_EV_SENSITIVE_EDITOR_CONSTRUCTOR

feature {GB_XML_STORE} -- Output

	generate_xml (element: XM_ELEMENT)
			-- Generate an XML representation of `Current' in `element'.
			-- Note that we must query the _I, as there is no way to know
			-- if the widget was really disabled by the user, or by its
			-- parent except in the interface.
		do
			if first.internal_non_sensitive then
				add_element_containing_boolean (element, is_sensitive_string, objects.first.is_sensitive)
			end
		end

	modify_from_xml (element: XM_ELEMENT)
			-- Update all items in `objects' based on information held in `element'.
		local
			element_info: ELEMENT_INFORMATION
		do
			full_information := get_unique_full_info (element)
			element_info := full_information @ (is_sensitive_string)
			if element_info /= Void then
				if element_info.data.is_equal (True_string) then
					for_first_object (agent {EV_SENSITIVE}.enable_sensitive)
				else
					for_first_object (agent {EV_SENSITIVE}.disable_sensitive)
				end
			end
		end

	generate_code (element: XM_ELEMENT; info: GB_GENERATED_INFO): ARRAYED_LIST [STRING]
			-- `Result' is string representation of
			-- settings held in `Current' which is
			-- in a compilable format.
		local
			element_info: ELEMENT_INFORMATION
		do
			create Result.make (1)
			full_information := get_unique_full_info (element)
			element_info := full_information @ (is_sensitive_string)
			if element_info /= Void then
				if element_info.data.is_equal (True_string) then
					Result.extend (info.actual_name_for_feature_call + "enable_sensitive")
				else
					Result.extend (info.actual_name_for_feature_call + "disable_sensitive")
				end
			end
		end

note
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
