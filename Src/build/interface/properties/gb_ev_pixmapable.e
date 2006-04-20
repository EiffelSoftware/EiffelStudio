indexing
	description: "Objects that manipulate objects of type EV_PIXMAPABLE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_PIXMAPABLE
	
	-- The following properties from EV_PIXMAPABLE are manipulated by `Current'.
	-- Pixmap - Performed on the real object and the display_object.

inherit
	GB_EV_ANY
		undefine
			attribute_editor
		redefine
			modify_from_xml_after_build
		end

	GB_EV_PIXMAPABLE_EDITOR_CONSTRUCTOR
		
	GB_SHARED_DEFERRED_BUILDER
		undefine
			default_create
		end
		
feature {GB_XML_STORE} -- Output

	generate_xml (element: XM_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		do
			if first.internal_pixmap_path /= Void or uses_constant (pixmap_path_string)  then
				add_string_element (element, pixmap_path_string, objects.first.internal_pixmap_path)
			end
		end
		
	modify_from_xml (element: XM_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		do
				-- We set up some deferred building, as
				-- we must wait until all pixmaps have been loaded.
				-- They are loaded after regular constants, as they
				-- rely on other constants.
			deferred_builder.defer_building (Current, element)
		end

	modify_from_xml_after_build (element: XM_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
			element_info: ELEMENT_INFORMATION
			new_pixmap: EV_PIXMAP
			a_file_name: FILE_NAME
			file: RAW_FILE
			data: STRING
			pixmap_constant: GB_PIXMAP_CONSTANT
			constant_context: GB_CONSTANT_CONTEXT
		do
			full_information := get_unique_full_info (element)
			element_info := full_information @ (pixmap_path_string)	
			if element_info /= Void then
				if element_info.is_constant then
					pixmap_constant ?= components.constants.all_constants.item (element_info.data)
					create constant_context.make_with_context (pixmap_constant, object, type, pixmap_path_string)
					pixmap_constant.add_referer (constant_context)
					object.add_constant_context (constant_context)
					create new_pixmap
					new_pixmap := pixmap_constant.pixmap.twin
					for_all_objects (agent {EV_PIXMAPABLE}.set_pixmap (new_pixmap))
				else
					create new_pixmap
					data := element_info.data
					create a_file_name.make_from_string (data)
					create file.make (a_file_name)
					if file.exists then
						new_pixmap.set_with_named_file (data)
						for_all_objects (agent {EV_PIXMAPABLE}.set_pixmap (new_pixmap))
					end
					for_all_objects (agent {EV_PIXMAPABLE}.set_internal_pixmap_path (a_file_name))
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
			data, a_pixmap_string, set_string: STRING
		do
			create Result.make (2)
			full_information := get_unique_full_info (element)
			element_info := full_information @ (pixmap_path_string)
			if element_info /= Void then
				if type_conforms_to (dynamic_type_from_string (info.type), dynamic_type_from_string (Ev_container_string)) then
					set_string := "set_background_pixmap ("
				else
					set_string := "set_pixmap ("
				end
				if element_info.is_constant then
					a_pixmap_string := element_info.data
					Result.extend (pixmap_constant_set_procedures_string + ".extend (agent " + info.actual_name_for_feature_call + set_string + "?))")
					Result.extend (pixmap_constant_retrieval_functions_string + ".extend (agent " + retrieve_string_setting (pixmap_path_string) + ")")
				else
					info.enable_pixmaps_set
					data := element_info.data
					Result.extend (pixmap_name + ".set_with_named_file (%"" + data + "%")")
					a_pixmap_string := pixmap_name
					Result.extend (info.actual_name_for_feature_call + set_string + a_pixmap_string + ")")
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


end -- class GB_EV_PIXMAPABLE
