indexing
	description: "Objects that manipulate objects of type EV_PIXMAPABLE."
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
		end

	GB_EV_PIXMAPABLE_EDITOR_CONSTRUCTOR
		
feature {GB_XML_STORE} -- Output

	generate_xml (element: XML_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		do
			if first.pixmap_path /= Void then
				add_element_containing_string (element, pixmap_path_string, objects.first.pixmap_path)
			end
		end

	modify_from_xml (element: XML_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
			new_pixmap: EV_PIXMAP
			file_name: FILE_NAME
			file: RAW_FILE
		do
			full_information := get_unique_full_info (element)
			element_info := full_information @ (pixmap_path_string)	
			if element_info /= Void then
				create new_pixmap
				create file_name.make_from_string (element_info.data)
				create file.make (file_name)
				if file.exists then
					new_pixmap.set_with_named_file (element_info.data)
					for_all_objects (agent {EV_PIXMAPABLE}.set_pixmap (new_pixmap))
				end
				for_all_objects (agent {EV_PIXMAPABLE}.set_pixmap_path (element_info.data))
			end
		end

feature {GB_CODE_GENERATOR} -- Output

	generate_code (element: XML_ELEMENT; info: GB_GENERATED_INFO): STRING is
			-- `Result' is string representation of
			-- settings held in `Current' which is
			-- in a compilable format.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
		do
			Result := ""
			full_information := get_unique_full_info (element)
			element_info := full_information @ (pixmap_path_string)
			if element_info /= Void then
				info.enable_pixmaps_set
				Result := pixmap_name + ".set_with_named_file (%"" + element_info.data + "%")"
				if type_conforms_to (dynamic_type_from_string (info.type), dynamic_type_from_string (Ev_container_string)) then
					Result := Result + indent + info.name + ".set_background_pixmap (" + pixmap_name + ")"
				else
					Result := Result + indent + info.name + ".set_pixmap (" + pixmap_name + ")"
				end
			end
			Result := strip_leading_indent (Result)
		end

end -- class GB_EV_PIXMAPABLE