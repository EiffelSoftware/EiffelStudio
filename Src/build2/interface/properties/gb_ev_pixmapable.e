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
		undefine
			default_create
		end
		
	CONSTANTS
		undefine
			default_create
		end
		
feature {GB_XML_STORE} -- Output

	generate_xml (element: XM_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		do
			if first.pixmap_path /= Void then
				add_element_containing_string (element, pixmap_path_string, objects.first.pixmap_path)
			end
		end

	modify_from_xml (element: XM_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
			element_info: ELEMENT_INFORMATION
			new_pixmap: EV_PIXMAP
			a_file_name: FILE_NAME
			file: RAW_FILE
			data: STRING
		do
			full_information := get_unique_full_info (element)
			element_info := full_information @ (pixmap_path_string)	
			if element_info /= Void then
				create new_pixmap
				data := element_info.data
				data := data.substring (data.last_index_of (Directory_seperator, data.count), data.count)
				data := constant_by_name ("pixmap_location") + data
				create a_file_name.make_from_string (data)
				create file.make (a_file_name)
				if file.exists then
					new_pixmap.set_with_named_file (data)
					for_all_objects (agent {EV_PIXMAPABLE}.set_pixmap (new_pixmap))
				end
				for_all_objects (agent {EV_PIXMAPABLE}.set_pixmap_path (a_file_name))
			end
		end

feature {GB_CODE_GENERATOR} -- Output

	generate_code (element: XM_ELEMENT; info: GB_GENERATED_INFO): STRING is
			-- `Result' is string representation of
			-- settings held in `Current' which is
			-- in a compilable format.
		local
			element_info: ELEMENT_INFORMATION
			data: STRING
		do
			Result := ""
			full_information := get_unique_full_info (element)
			element_info := full_information @ (pixmap_path_string)
			if element_info /= Void then
				info.enable_pixmaps_set
				data := element_info.data
				data := data.substring (data.last_index_of (Directory_seperator, data.count), data.count)
				data := "constant_by_name (%"pixmap_location%") + %"" + data
				Result := pixmap_name + ".set_with_named_file (" + data + "%")"

				if type_conforms_to (dynamic_type_from_string (info.type), dynamic_type_from_string (Ev_container_string)) then
					Result := Result + indent + info.name + ".set_background_pixmap (" + pixmap_name + ")"
				else
					Result := Result + indent + info.name + ".set_pixmap (" + pixmap_name + ")"
				end
			end
			Result := strip_leading_indent (Result)
		end

end -- class GB_EV_PIXMAPABLE