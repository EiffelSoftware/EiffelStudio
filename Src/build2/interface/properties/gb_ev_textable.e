indexing
	description: "Objects that manipulate objects of type EV_TEXTABLE"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_TEXTABLE
	
	-- The following properties from EV_TEXTABLE are manipulated by `Current'.
	-- Text - Performed on the real object and the display_object child.

inherit
	GB_EV_ANY
		undefine
			attribute_editor,
			set_up_user_events,
			has_user_events
		end
		
	EV_FRAME_CONSTANTS
			export
			{NONE} all
		undefine
			default_create
		end
		
	EV_ANY_HANDLER
		undefine
			default_create
		end

	GB_EV_TEXTABLE_EDITOR_CONSTRUCTOR
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
			textable: EV_TEXTABLE
		do
			textable ?= default_object_by_type (class_name (first))
			if not textable.text.is_equal (objects.first.text) or uses_constant (Text_string) then
				add_string_element (element, Text_string, objects.first.text)
			end
		end
		
	modify_from_xml (element: XM_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
			element_info: ELEMENT_INFORMATION
		do
			full_information := get_unique_full_info (element)
			element_info := full_information @ (text_string)
				-- We must prune the CDATA tag. We will only have this while generating internally
				-- while resetting an object. When we are using the XML document, this is stripped
				-- automatically so we do not encounter it.
			if element_info /= Void and then element_info.data /= Void and then element_info.data.count /= 0 then
				for_all_objects (agent {EV_TEXTABLE}.set_text (retrieve_and_set_string_value (text_string)))
			end
		end
		
feature {GB_CODE_GENERATOR} -- Output

	generate_code (element: XM_ELEMENT; info: GB_GENERATED_INFO): ARRAYED_LIST [STRING] is
			-- `Result' is string representation of
			-- settings held in `Current' which is
			-- in a compilable format.
		local
			element_info: ELEMENT_INFORMATION
		do
			create Result.make (1)
			full_information := get_unique_full_info (element)
			element_info := full_information @ (text_string)
			if element_info /= Void and then element_info.data.count /= 0 then
				Result.append (build_set_code_for_string (text_string, info.actual_name_for_feature_call, "set_text ("))
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


end -- class GB_EV_TEXTABLE
