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
		redefine
			modify_from_xml_after_build
		end

	GB_EV_PIXMAPABLE_EDITOR_CONSTRUCTOR
	--	undefine
	--		default_create
	--	end
		
	CONSTANTS
		undefine
			default_create
		end
		
	GB_SHARED_DEFERRED_BUILDER
		undefine
			default_create
		end
		
feature {GB_XML_STORE} -- Output

	generate_xml (element: XM_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		do
			if first.pixmap_path /= Void or uses_constant (pixmap_path_string)  then
				add_string_element (element, pixmap_path_string, objects.first.pixmap_path)
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
					pixmap_constant ?= constants.all_constants.item (element_info.data)
					create constant_context.make_with_context (pixmap_constant, object, type, pixmap_path_string)
					pixmap_constant.add_referer (constant_context)
					object.add_constant_context (constant_context)
					create new_pixmap
					new_pixmap := clone (pixmap_constant.pixmap)
					for_all_objects (agent {EV_PIXMAPABLE}.set_pixmap (new_pixmap))
					--Result := string_constant.value
				else
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
		end

feature {GB_CODE_GENERATOR} -- Output

	generate_code (element: XM_ELEMENT; info: GB_GENERATED_INFO): STRING is
			-- `Result' is string representation of
			-- settings held in `Current' which is
			-- in a compilable format.
		local
			element_info: ELEMENT_INFORMATION
			data: STRING
			a_pixmap_string: STRING
			pixmap_constant: GB_STRING_CONSTANT
			constant_context: GB_CONSTANT_CONTEXT
		do
			Result := ""
			full_information := get_unique_full_info (element)
			element_info := full_information @ (pixmap_path_string)
			if element_info /= Void then
				if element_info.is_constant then
					Result := ""
					a_pixmap_string := element_info.data--constant_by_name (pixmap_path_string)
				else
					info.enable_pixmaps_set
					data := element_info.data
					data := data.substring (data.last_index_of (Directory_seperator, data.count), data.count)
					data := "constant_by_name (%"pixmap_location%") + %"" + data
					Result := pixmap_name + ".set_with_named_file (" + data + "%")"
					a_pixmap_string := pixmap_name
				end

				if type_conforms_to (dynamic_type_from_string (info.type), dynamic_type_from_string (Ev_container_string)) then
					Result := Result + indent + info.name + ".set_background_pixmap (" + a_pixmap_string + ")"
				else
					Result := Result + indent + info.name + ".set_pixmap (" + a_pixmap_string + ")"
				end
			end
			Result := strip_leading_indent (Result)
		end

end -- class GB_EV_PIXMAPABLE