indexing
	description: "Objects that manipulate objects of type EV_NOTEBOOK"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_NOTEBOOK

inherit
	
	GB_EV_ANY
		undefine
			attribute_editor
		redefine
			ev_type,
			modify_from_xml_after_build
		end
		
	GB_EV_NOTEBOOK_EDITOR_CONSTRUCTOR
		
	GB_SHARED_DEFERRED_BUILDER
		undefine
			default_create
		end

feature {GB_XML_STORE} -- Output

	generate_xml (element: XML_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		local
			notebook: EV_NOTEBOOK
			names_string: STRING
		do
			notebook ?= new_instance_of (dynamic_type_from_string (class_name (first)))
			notebook.default_create
			if first.tab_position /= notebook.tab_position then
				add_element_containing_integer (element, Tab_position_string, first.tab_position)
			end
			from
				first.start
				names_string := ""
			until
				first.off
			loop
				names_string.append_string (first.item_text (first.item))
				if first.index /= first.count then
					names_string.append_character (separator_char)
				end
				first.forth
			end
			if not names_string.is_empty then
				add_element_containing_string (element, Item_text_string, names_string)
			end
		end
		
	modify_from_xml (element: XML_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
		do
			full_information := get_unique_full_info (element)
			
			element_info := full_information @ (Tab_position_string)
			if element_info /= Void then
				for_all_objects (agent {EV_NOTEBOOK}.set_tab_position (element_info.data.to_integer))
			end
				-- We set up some deferred building now.
			deferred_builder.defer_building (Current, element)
		end
		
	modify_from_xml_after_build (element: XML_ELEMENT) is
			-- Build from XML any information that was
			-- deferred during the load/build cycle.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
			names: ARRAYED_LIST [STRING]
		do
			full_information := get_unique_full_info (element)
			element_info := full_information @ (Item_text_string)
			if element_info /= Void then
				names := names_from_string (element_info.data)
				from
					names.start
				until
					names.off
				loop
					first.set_item_text (first.i_th (names.index), names.item)
					(objects @ 2).set_item_text ((objects @ 2).i_th (names.index), names.item)
					system_status.enable_project_modified
					command_handler.update

					names.forth
				end
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
			names: ARRAYED_LIST [STRING]
			children_names: ARRAYED_LIST [STRING]
		do
			Result := ""
			full_information := get_unique_full_info (element)
			element_info := full_information @ (tab_position_string)
			if element_info /= Void then
				Result := info.name + ".set_tab_position (" + element_info.data + ")"
			end
			element_info := full_information @ (Item_text_string)
			if element_info /= Void then
				children_names := info.child_names
				names := names_from_string (element_info.data)
				check
					consistent_counts: children_names.count = names.count
				end
				from
					names.start
				until
					names.off
				loop
						-- If the current name is empty, then we do not generate a setting.
					if not names.item.is_equal ("") then
						Result := Result + indent + info.name + ".set_item_text (" + (children_names @ (names.index)) + ", %"" + names.item + "%")"
					end
					names.forth
				end
			end
			Result := strip_leading_indent (Result)
		end

end -- class GB_EV_NOTEBOOK
