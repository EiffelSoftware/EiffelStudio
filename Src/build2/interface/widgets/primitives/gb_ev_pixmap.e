indexing
	description: "Objects that manipulate objects of type EV_PIXMAP"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_PIXMAP

	
	-- The following properties from EV_PIXMAPABLE are manipulated by `Current'.
	-- Pixmap - Performed on the real object and the display_object.

inherit
	GB_EV_ANY
		undefine
			attribute_editor
		redefine
			attribute_editor,
			ev_type
		end
		
	GB_EV_PIXMAP_EDITOR_CONSTRUCTOR
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
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
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
				create a_file_name.make_from_string (element_info.data)
				create file.make (a_file_name)	
				if file.exists then
					new_pixmap.set_with_named_file (data)
					for_all_objects (agent {EV_PIXMAP}.set_with_named_file (a_file_name))
					for_all_objects (agent {EV_PIXMAP}.enable_pixmap_exists)
				else
					for_all_objects (agent {EV_PIXMAP}.disable_pixmap_exists)
				end
					-- We must know the path if successful or not.
				for_all_objects (agent {EV_PIXMAP}.set_pixmap_path (a_file_name))
			end
		end

feature {GB_CODE_GENERATOR} -- Output

	generate_code (element: XM_ELEMENT; info: GB_GENERATED_INFO): STRING is
			-- `Result' is string representation of
			-- settings held in `Current' which is
			-- in a compilable format.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
			data: STRING
		do
			Result := ""
			full_information := get_unique_full_info (element)
			element_info := full_information @ (pixmap_path_string)
			if element_info /= Void then
				data := element_info.data
				data := data.substring (data.last_index_of (Directory_seperator, data.count), data.count)
				data := "constant_by_name (%"pixmap_location%") + %"" + data
				Result := info.name + ".set_with_named_file (" + data + "%")"
			end
			Result := strip_leading_indent (Result)
		end

end -- class GB_EV_PIXMAP
